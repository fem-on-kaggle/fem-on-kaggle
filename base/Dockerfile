# Copyright (C) 2022 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

FROM gcr.io/kaggle-images/python:latest
MAINTAINER Francesco Ballarin <francesco.ballarin@unicatt.it>

ENV INSTALL_PREFIX=/opt/conda \
    FEM_ON_COLAB_SCRIPTS=/usr/local/share/fem-on-colab \
    PROJECT_NAME=fem-on-kaggle \
    PYTHON_VERSION=python3.7

ENV BACKEND_LIBRARY=kaggle \
    DOCKER_SCRIPTS=${INSTALL_PREFIX}/share/${PROJECT_NAME}

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
    cp -r base/bin/* /usr/bin && \
    cp -r base/lib/python3/* /usr/lib/${PYTHON_VERSION} && \
    cp -r base/share/* /usr/share && \
    cd -

ENV PATH="${INSTALL_PREFIX}/bin:${PATH}" \
    LD_LIBRARY_PATH="${INSTALL_PREFIX}/lib:${LD_LIBRARY_PATH}" \
    PYTHONPATH="${INSTALL_PREFIX}/lib/${PYTHON_VERSION}/site-packages:${PYTHONPATH}"

ENV CPPFLAGS="-static-libstdc++" \
    LDFLAGS="-static-libstdc++"

CMD ["/bin/sh"]
ENTRYPOINT []
