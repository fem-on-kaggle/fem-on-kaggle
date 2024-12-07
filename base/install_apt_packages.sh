# Copyright (C) 2022-2024 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

# Kaggle image is based on Colab one (with a few additions/changes to packages)
# so start from the script provided by FEM on Colab
cp ${FEM_ON_COLAB_SCRIPTS}/base/install_apt_packages.sh ${DOCKER_SCRIPTS}/base/install_apt_packages_colab.sh

# Run the installation script
bash ${DOCKER_SCRIPTS}/base/install_apt_packages_colab.sh
