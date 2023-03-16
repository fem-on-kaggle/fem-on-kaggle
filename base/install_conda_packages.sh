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

# Install libxml2, which is already shipped in the actual kaggle image
apt remove -y -qq libxml2
conda install -c conda-forge libxml2

# Replace numpy from pip with numpy from conda
python3 -m pip uninstall -y -qq numpy
conda install -c conda-forge numpy
