// Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package main

import (
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"io"
	"net/http"
	"os"
	"strconv"
	"strings"

	"github.com/cheggaaa/pb/v3"
	"gopkg.in/yaml.v3"
)

type KFDFile struct {
	Tools struct {
		Common map[string]struct {
			Version   string
			Checksums map[string]string
		}
	}
}

func main() {
	kfdYAMLPath := "kfd.yaml"

	if len(os.Args) == 2 {
		kfdYAMLPath = os.Args[1]
	}

	if len(os.Args) > 2 {
		fmt.Printf("usage: %s [/path/to/kfd.yaml]\n", os.Args[0])

		os.Exit(1)
	}

	if err := run(kfdYAMLPath); err != nil {
		fmt.Printf("error: %s\n", err.Error())

		os.Exit(1)
	}
}

func run(kfdYAMLPath string) error {
	data, err := os.ReadFile(kfdYAMLPath)
	if err != nil {
		return err
	}

	var kfdFile KFDFile
	if err := yaml.Unmarshal(data, &kfdFile); err != nil {
		return err
	}

	for toolName, tool := range kfdFile.Tools.Common {
		for checksumOSAndArch := range tool.Checksums {
			checksumOS, checksumArch, found := strings.Cut(checksumOSAndArch, "/")
			if !found {
				fmt.Printf("ERROR: unable to split OS and arch from: %s\n", checksumOSAndArch)
				continue
			}

			fmt.Printf("Downloading %s version %s for %s %s...\n", toolName, tool.Version, checksumOS, checksumArch)

			var url string
			switch toolName {
			case "furyagent":
				url = fmt.Sprintf("https://github.com/sighupio/furyagent/releases/download/v%s/furyagent-%s-%s", tool.Version, checksumOS, checksumArch)
			case "kubectl":
				url = fmt.Sprintf("https://dl.k8s.io/release/v%s/bin/%s/%s/kubectl", tool.Version, checksumOS, checksumArch)
			case "terraform":
				url = fmt.Sprintf("https://releases.hashicorp.com/terraform/%s/terraform_%s_%s_%s.zip", tool.Version, tool.Version, checksumOS, checksumArch)
			case "kustomize":
				url = fmt.Sprintf("https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v%s/kustomize_v%s_%s_%s.tar.gz", tool.Version, tool.Version, checksumOS, checksumArch)
			}

			if url == "" {
				fmt.Printf("WARNING: unsupported tool: %s\n", toolName)
				continue
			}

			fmt.Printf("DEBUG: url: %s\n", url)

			headResponse, err := http.Head(url)
			if err != nil {
				return err
			}
			defer headResponse.Body.Close()

			if headResponse.StatusCode > 200 {
				fmt.Printf("error: invalid status code %d\n", headResponse.StatusCode)
				continue
			}

			contentLength, err := strconv.Atoi(headResponse.Header.Get("content-length"))
			if err != nil {
				return err
			}

			bar := pb.Full.Start(contentLength)

			getResponse, err := http.Get(url)
			if err != nil {
				return err
			}
			defer getResponse.Body.Close()

			barReader := bar.NewProxyReader(getResponse.Body)

			fileBytes, err := io.ReadAll(barReader)
			if err != nil {
				return err
			}

			bar.Finish()

			fileChecksumBytes := sha256.Sum256(fileBytes)
			fileChecksum := hex.EncodeToString(fileChecksumBytes[:])

			fmt.Printf("DEBUG: checksum is %s\n", fileChecksum)

			tool.Checksums[checksumOSAndArch] = fileChecksum
		}
	}

	outputData, err := yaml.Marshal(kfdFile)
	if err != nil {
		return err
	}

	fmt.Printf("Output:\n%s\n", strings.ReplaceAll(string(outputData), "    ", "  "))

	return nil
}
