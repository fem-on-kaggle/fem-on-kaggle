# Copyright (C) 2022 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Install cmake (for building)
PYTHONUSERBASE=/root/.local python3 -m pip install --user cmake

# Install nbval (for testing)
PYTHONUSERBASE=/root/.local python3 -m pip install --user nbval
