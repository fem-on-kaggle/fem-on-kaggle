# Copyright (C) 2022-2023 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Install additional packages that are required to compile from source
apt install -y -qq autoconf autoconf-archive bison build-essential cmake curl flex git jq libtool pkg-config rsync software-properties-common unzip wget
