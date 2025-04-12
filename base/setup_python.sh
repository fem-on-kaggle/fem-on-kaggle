# Copyright (C) 2022-2025 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

set -e
set -x

SYSTEM_PYTHON_VERSION="python3.10"
KAGGLE_PYTHON_VERSION="python3.11"

# Setup non-default python version
update-alternatives --install /usr/bin/python3 python3 /usr/bin/${SYSTEM_PYTHON_VERSION} 1
if [[ ${KAGGLE_PYTHON_VERSION} != ${SYSTEM_PYTHON_VERSION} ]]; then
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/${KAGGLE_PYTHON_VERSION} 2
fi
update-alternatives --set python3 /usr/bin/${KAGGLE_PYTHON_VERSION}

# Changing system-wide python version may break apt
sed -i "s|#\!/usr/bin/python3|#\!/usr/bin/${SYSTEM_PYTHON_VERSION}|" /usr/bin/add-apt-repository

# Download latest pip release
PIP_RELEASE_URL=$(curl -s https://pypi.org/pypi/pip/json | jq -r ".urls[0].url")
PIP_RELEASE_FILE=${PIP_RELEASE_URL##*/}
wget ${PIP_RELEASE_URL} -O ${PIP_RELEASE_FILE}
export PYTHONPATH=/usr/lib/${KAGGLE_PYTHON_VERSION}/dist-packages:/usr/lib/${KAGGLE_PYTHON_VERSION}/site-packages
PYTHONUSERBASE=/usr python3 ${PIP_RELEASE_FILE}/pip install --no-index --user ${PIP_RELEASE_FILE}
rm -f ${PIP_RELEASE_FILE}
