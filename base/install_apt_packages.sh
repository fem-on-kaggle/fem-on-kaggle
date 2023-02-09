# Copyright (C) 2022-2023 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Install additional packages that are required to compile from source
apt install -y -qq autoconf autoconf-archive bison build-essential cmake curl flex git jq libtool pkg-config rsync software-properties-common unzip wget

# Install patchelf from source, as the version packaged by ubuntu may be too old
git clone https://github.com/NixOS/patchelf.git /tmp/patchelf-src
cd /tmp/patchelf-src
TAGS=($(git tag -l --sort=-version:refname))
echo "Latest tag is ${TAGS[0]}"
git checkout ${TAGS[0]}
./bootstrap.sh
./configure --prefix=/usr
make
make install
cd -
rm -rf /tmp/patchelf-src
