# Copyright (C) 2022-2023 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Install ncurses from conda-forge, to fix
# /opt/conda/lib/libtinfo.so.6: no version information available (required by bash)
conda install -c conda-forge ncurses

# Install libcurl, which is already shipped in the actual kaggle image
apt remove -y -qq curl libcurl*
apt install -y -qq git
conda install -c conda-forge libcurl
ln -s ${CONDA_PREFIX}/include/curl /usr/include/
ln -s ${CONDA_PREFIX}/lib/libcurl* /usr/lib/
ln -s ${CONDA_PREFIX}/lib/libssh2* /usr/lib/

# Install libxml2, which is already shipped in the actual kaggle image
apt remove -y -qq libxml2
conda install -c conda-forge libxml2
