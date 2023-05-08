# Contributing guidelines

## Calculating tools checksums

We have included a little tool for calculating the checksums of the tools.
It is located in the `tools` directory and it is called `checksummer`.
It is a small Go utility that downloads the tools, calculates their checksums, and outputs all of them as yaml
you can use to fill in the dedicated section in the `kfd.yaml` file.
There's a `Makefile` target that does all of this for you, so you can just run:

```bash
make generate-deps-checksums
Downloading furyagent version 0.3.0 for darwin amd64...
DEBUG: url: https://github.com/sighupio/furyagent/releases/download/v0.3.0/furyagent-darwin-amd64
38.16 MiB / 38.16 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 15.05 MiB p/s 2.7s
DEBUG: checksum is 4d5c714264a83c02a049b1f60f3773afc4a547be680ada2a8e26471f254f9302
Downloading furyagent version 0.3.0 for darwin arm64...
DEBUG: url: https://github.com/sighupio/furyagent/releases/download/v0.3.0/furyagent-darwin-arm64
37.79 MiB / 37.79 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 15.96 MiB p/s 2.6s
DEBUG: checksum is 5066db14678565d7d932084c574b29fca95b4c4b38047d0754880ecf76dcc9a5
Downloading furyagent version 0.3.0 for linux amd64...
DEBUG: url: https://github.com/sighupio/furyagent/releases/download/v0.3.0/furyagent-linux-amd64
34.13 MiB / 34.13 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 13.39 MiB p/s 2.7s
DEBUG: checksum is f6d7d0f5caac5b42d5d162a5ed64eb44a7beedb208eae8a12ee73538d5de58d6
Downloading furyagent version 0.3.0 for linux arm64...
DEBUG: url: https://github.com/sighupio/furyagent/releases/download/v0.3.0/furyagent-linux-arm64
33.25 MiB / 33.25 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 12.48 MiB p/s 2.9s
DEBUG: checksum is 17719f88e9a7c0e55876f027333a92682b1c6de29963cc61335f954d0d27289d
Downloading kubectl version 1.25.8 for darwin amd64...
DEBUG: url: https://dl.k8s.io/release/v1.25.8/bin/darwin/amd64/kubectl
47.91 MiB / 47.91 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 14.13 MiB p/s 3.6s
DEBUG: checksum is 4fc94a62065d25f8048272da096e1c5e3bd22676752fb3a24537e4ad62a33382
Downloading kubectl version 1.25.8 for darwin arm64...
DEBUG: url: https://dl.k8s.io/release/v1.25.8/bin/darwin/arm64/kubectl
47.40 MiB / 47.40 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 17.43 MiB p/s 2.9s
DEBUG: checksum is 6519e273017590bd8b193d650af7a6765708f1fed35dcbcaffafe5f33872dfb4
Downloading kubectl version 1.25.8 for linux amd64...
DEBUG: url: https://dl.k8s.io/release/v1.25.8/bin/linux/amd64/kubectl
42.95 MiB / 42.95 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 16.65 MiB p/s 2.8s
DEBUG: checksum is 80e70448455f3d19c3cb49bd6ff6fc913677f4f240d368fa2b9f0d400c8cd16e
Downloading kubectl version 1.25.8 for linux arm64...
DEBUG: url: https://dl.k8s.io/release/v1.25.8/bin/linux/arm64/kubectl
41.56 MiB / 41.56 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 17.77 MiB p/s 2.5s
DEBUG: checksum is 28cf5f666cb0c11a8a2b3e5ae4bf93e56b74ab6051720c72bb231887bfc1a7c6
Downloading kustomize version 3.5.3 for darwin amd64...
DEBUG: url: https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v3.5.3/kustomize_v3.5.3_darwin_amd64.tar.gz
19.21 MiB / 19.21 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 10.16 MiB p/s 2.1s
DEBUG: checksum is 9f001854652cb78fd0eb1903df1e9dcc216a4184acd77f8c143fda908206cf74
Downloading kustomize version 3.5.3 for darwin arm64...
DEBUG: url: https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v3.5.3/kustomize_v3.5.3_darwin_arm64.tar.gz
error: invalid status code 404
Downloading kustomize version 3.5.3 for linux amd64...
DEBUG: url: https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v3.5.3/kustomize_v3.5.3_linux_amd64.tar.gz
10.78 MiB / 10.78 MiB [----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 14.88 MiB p/s 900ms
DEBUG: checksum is e0b86d6fc5f46b83b9ee339e98bf265354b66d1ea9bf168a2077d6b5914afd78
Downloading kustomize version 3.5.3 for linux arm64...
DEBUG: url: https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v3.5.3/kustomize_v3.5.3_linux_arm64.tar.gz
error: invalid status code 404
Downloading terraform version 0.15.4 for linux arm64...
DEBUG: url: https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_arm64.zip
29.43 MiB / 29.43 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 15.61 MiB p/s 2.1s
DEBUG: checksum is 8bbbaf8b48f857b4044983cc757c5f05da5ab877449b9d9847c680b8955edc85
Downloading terraform version 0.15.4 for darwin amd64...
DEBUG: url: https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_darwin_amd64.zip
32.36 MiB / 32.36 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 20.42 MiB p/s 1.8s
DEBUG: checksum is 9092c017257ead94223418dac7165541228e773463b476e0803848be4f3169a4
Downloading terraform version 0.15.4 for darwin arm64...
DEBUG: url: https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_darwin_arm64.zip
error: invalid status code 404
Downloading terraform version 0.15.4 for linux amd64...
DEBUG: url: https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip
31.50 MiB / 31.50 MiB [-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 15.20 MiB p/s 2.3s
DEBUG: checksum is ddf9b409599b8c3b44d4e7c080da9a106befc1ff9e53b57364622720114e325c
Output:
tools:
  common:
    furyagent:
      version: 0.3.0
      checksums:
        darwin/amd64: 4d5c714264a83c02a049b1f60f3773afc4a547be680ada2a8e26471f254f9302
        darwin/arm64: 5066db14678565d7d932084c574b29fca95b4c4b38047d0754880ecf76dcc9a5
        linux/amd64: f6d7d0f5caac5b42d5d162a5ed64eb44a7beedb208eae8a12ee73538d5de58d6
        linux/arm64: 17719f88e9a7c0e55876f027333a92682b1c6de29963cc61335f954d0d27289d
    kubectl:
      version: 1.25.8
      checksums:
        darwin/amd64: 4fc94a62065d25f8048272da096e1c5e3bd22676752fb3a24537e4ad62a33382
        darwin/arm64: 6519e273017590bd8b193d650af7a6765708f1fed35dcbcaffafe5f33872dfb4
        linux/amd64: 80e70448455f3d19c3cb49bd6ff6fc913677f4f240d368fa2b9f0d400c8cd16e
        linux/arm64: 28cf5f666cb0c11a8a2b3e5ae4bf93e56b74ab6051720c72bb231887bfc1a7c6
    kustomize:
      version: 3.5.3
      checksums:
        darwin/amd64: 9f001854652cb78fd0eb1903df1e9dcc216a4184acd77f8c143fda908206cf74
        darwin/arm64: ""
        linux/amd64: e0b86d6fc5f46b83b9ee339e98bf265354b66d1ea9bf168a2077d6b5914afd78
        linux/arm64: ""
    terraform:
      version: 0.15.4
      checksums:
        darwin/amd64: 9092c017257ead94223418dac7165541228e773463b476e0803848be4f3169a4
        darwin/arm64: ""
        linux/amd64: ddf9b409599b8c3b44d4e7c080da9a106befc1ff9e53b57364622720114e325c
        linux/arm64: 8bbbaf8b48f857b4044983cc757c5f05da5ab877449b9d9847c680b8955edc85
```
