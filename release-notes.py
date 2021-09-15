# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

import os
import sys
from shutil import copyfile

import semantic_version  # pylint: disable=import-error

RELEASE_NOTES_FILE_PATH = os.getenv("RELEASE_NOTES_FILE_PATH")
DRONE_TAG = os.getenv("DRONE_TAG")

if __name__ == "__main__":
    if not DRONE_TAG or not RELEASE_NOTES_FILE_PATH:
        sys.exit("DRONE_TAG or RELEASE_NOTES_FILE_PATH variables not found, returning")

    version = DRONE_TAG[1:]

    major = semantic_version.Version(version).major
    minor = semantic_version.Version(version).minor
    patch = semantic_version.Version(version).patch

    release_notes_file = "./docs/releases/v{}.{}.{}.md".format(major, minor, patch)
    print("Copying from {} to {}".format(release_notes_file, RELEASE_NOTES_FILE_PATH))
    copyfile(release_notes_file, RELEASE_NOTES_FILE_PATH)
