# Copyright (C) 2022 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

FROM gcr.io/kaggle-images/python:latest
MAINTAINER Francesco Ballarin <francesco.ballarin@unicatt.it>

ENV CONDA_PREFIX=/opt/conda \
    INSTALL_PREFIX=/root/.local \
    PROJECT_NAME=fem-on-kaggle \
    PYTHON_VERSION=python3.7

ENV BACKEND_LIBRARY=kaggle \
    DOCKER_SCRIPTS=${INSTALL_PREFIX}/share/${PROJECT_NAME} \
    FEM_ON_COLAB_SCRIPTS=${INSTALL_PREFIX}/share/fem-on-colab

RUN rm -rf ${INSTALL_PREFIX} && \
    mkdir -p ${INSTALL_PREFIX} && \
    mkdir -p ${INSTALL_PREFIX}/lib/${PYTHON_VERSION}/site-packages

COPY . ${DOCKER_SCRIPTS}

RUN apt install -y -qq git && \
    git clone https://github.com/fem-on-colab/fem-on-colab.git ${FEM_ON_COLAB_SCRIPTS}

RUN cd ${DOCKER_SCRIPTS} && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_pre.sh && \
    bash base/add_apt_repositories.sh && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_post.sh && \
    cd -

RUN cd ${DOCKER_SCRIPTS} && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_pre.sh && \
    bash base/install_apt_packages.sh && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_post.sh && \
    cd -

RUN cd ${DOCKER_SCRIPTS} && \
    . ${FEM_ON_COLAB_SCRIPTS}/scripts/docker_pre.sh && \
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
    PYTHONPATH="${INSTALL_PREFIX}/lib/${PYTHON_VERSION}/site-packages:${PYTHONPATH}"

CMD ["/bin/bash"]
ENTRYPOINT []
