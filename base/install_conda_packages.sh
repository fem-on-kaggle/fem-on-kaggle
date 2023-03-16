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
