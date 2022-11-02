# Copyright (C) 2022 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Install add-apt-repository and wget
apt update
apt install -y -qq software-properties-common wget

# CMake (actually newer than the one on Kaggle)
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ bionic main'

# Git (actually newer than the one on Kaggle)
add-apt-repository -y ppa:git-core/ppa

# Fetch updated package list
apt update
