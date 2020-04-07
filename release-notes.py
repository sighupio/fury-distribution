import os
from shutil import copyfile

import semantic_version

RELEASE_NOTES_FILE_PATH = os.getenv("RELEASE_NOTES_FILE_PATH")
DRONE_TAG = os.getenv("DRONE_TAG")

if __name__ == "__main__":
    version = DRONE_TAG[1:]

    major = semantic_version.Version(version).major
    minor = semantic_version.Version(version).minor
    patch = semantic_version.Version(version).patch

    release_notes_file = f"./docs/releases/v{major}.{minor}.{patch}.md"
    print(f"Copying from {release_notes_file} to {RELEASE_NOTES_FILE_PATH}")
    copyfile(release_notes_file, RELEASE_NOTES_FILE_PATH)
