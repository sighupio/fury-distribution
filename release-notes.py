# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

import os
from shutil import copyfile

import semantic_version  # pylint: disable=import-error

# Using os.environ["VAR"] notation to riase an exception if the env vars are not present
DRONE_TAG = os.environ["DRONE_TAG"]
RELEASE_NOTES_FILE_PATH = os.environ["RELEASE_NOTES_FILE_PATH"]

if __name__ == "__main__":
    version = DRONE_TAG[1:]

    major = semantic_version.Version(version).major
    minor = semantic_version.Version(version).minor
    patch = semantic_version.Version(version).patch

    release_notes_file = f"./docs/releases/v{major}.{minor}.{patch}.md"
    print(f"Copying from {release_notes_file} to {RELEASE_NOTES_FILE_PATH}")
    copyfile(release_notes_file, RELEASE_NOTES_FILE_PATH)
