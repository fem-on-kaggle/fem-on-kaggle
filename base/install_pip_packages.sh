# Copyright (C) 2022-2023 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Install cython, which is already shipped in the actual kaggle image
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip install --user cython

# Install cmake (for building)
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip install --user cmake

# Install nbval (for testing)
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip install --user nbval
