# Copyright (C) 2022-2023 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Use micromamba instead of conda
wget https://micro.mamba.pm/api/micromamba/linux-64/latest -O /tmp/micromamba-archive
mkdir -p /tmp/micromamba
tar -xvjf /tmp/micromamba-archive -C /tmp/micromamba bin/micromamba
rm /tmp/micromamba-archive
export PATH=/tmp/micromamba/bin:$PATH

# Install libcurl, which is already shipped in the actual kaggle image
apt remove -y -qq curl libcurl*
apt install -y -qq git
micromamba install -c conda-forge curl
micromamba install -c conda-forge libcurl
ln -s ${CONDA_PREFIX}/bin/curl /usr/bin/
ln -s ${CONDA_PREFIX}/include/curl /usr/include/
ln -s ${CONDA_PREFIX}/lib/libcurl* /usr/lib/
ln -s ${CONDA_PREFIX}/lib/libssh2* /usr/lib/

# Install libxml2, which is already shipped in the actual kaggle image
apt remove -y -qq libxml2
micromamba install -c conda-forge libxml2

# SSL package shipped with conda does not allow certificate verification
SSL_FILE=$(python3 -c "import ssl; print(ssl.__file__)")
sed -i 's|_create_default_https_context = create_default_context|_create_default_https_context = _create_unverified_context|g' ${SSL_FILE}

# Remove pkgs cache to decrease the image size
rm -rf ${CONDA_PREFIX}/pkgs

# Remove micromamba
rm -rf /tmp/micromamba
