# Copyright (C) 2022-2024 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

FROM ubuntu:22.04

ENV INSTALL_PREFIX=/usr/local \
    PROJECT_NAME=fem-on-kaggle \
    PYTHON_VERSION=python3.10

ENV BACKEND_INFO=${INSTALL_PREFIX}/share/backend-info \
    BACKEND_LIBRARY=kaggle \
    DOCKER_SCRIPTS=${INSTALL_PREFIX}/share/${PROJECT_NAME} \
    FEM_ON_COLAB_SCRIPTS=${INSTALL_PREFIX}/share/fem-on-colab

RUN mkdir -p ${INSTALL_PREFIX} && \
    mkdir -p ${INSTALL_PREFIX}/bin && \
    mkdir -p ${INSTALL_PREFIX}/lib/${PYTHON_VERSION}/site-packages && \
    ln -s ${INSTALL_PREFIX}/lib ${INSTALL_PREFIX}/lib64

COPY . ${DOCKER_SCRIPTS}

RUN apt update -y -q && \
    apt install -y -qq git && \
    git clone https://github.com/fem-on-colab/fem-on-colab.git ${FEM_ON_COLAB_SCRIPTS}

RUN cd ${DOCKER_SCRIPTS} && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_pre.sh && \
    bash base/add_apt_repositories.sh && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_post.sh && \
    cd -

RUN mkdir -p ${BACKEND_INFO}

COPY apt-list.txt ${BACKEND_INFO}/
COPY pip-freeze.txt ${BACKEND_INFO}/
COPY git-commit.txt ${BACKEND_INFO}/

RUN cd ${DOCKER_SCRIPTS} && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_pre.sh && \
    bash base/install_apt_packages.sh && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_post.sh && \
    cd -

RUN cd ${DOCKER_SCRIPTS} && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_pre.sh && \
    bash base/setup_python.sh && \
    PYTHON_VERSION_CHECK=$(python3 -c "import sys; print('python{}.{}'.format(sys.version_info.major, sys.version_info.minor))") && \
    [ "${PYTHON_VERSION_CHECK}" = "${PYTHON_VERSION}" ] && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_post.sh && \
    cd -

RUN cd ${DOCKER_SCRIPTS} && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_pre.sh && \
    bash base/install_pip_packages.sh && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_post.sh && \
    cd -

RUN cd ${DOCKER_SCRIPTS} && \
    mkdir -p /usr/lib/${PYTHON_VERSION} && \
    cp -r base/bin/* /usr/bin && \
    cp -r base/lib/python3/* /usr/lib/${PYTHON_VERSION} && \
    cp -r base/share/* /usr/share && \
    cd -

RUN rm -rf ${FEM_ON_COLAB_SCRIPTS}
ENV FEM_ON_COLAB_SCRIPTS=

RUN rm -rf ${DOCKER_SCRIPTS}
ENV DOCKER_SCRIPTS=

ENV PATH="${INSTALL_PREFIX}/bin:${PATH}" \
    LD_LIBRARY_PATH="${INSTALL_PREFIX}/lib:${LD_LIBRARY_PATH}" \
    PYTHONPATH="${INSTALL_PREFIX}/lib/${PYTHON_VERSION}/dist-packages:${INSTALL_PREFIX}/lib/${PYTHON_VERSION}/site-packages:/usr/lib/${PYTHON_VERSION}/dist-packages:/usr/lib/${PYTHON_VERSION}/site-packages:${PYTHONPATH}"
