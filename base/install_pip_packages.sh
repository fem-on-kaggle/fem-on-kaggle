# Copyright (C) 2022-2023 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Get list of installed packages
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip freeze > /tmp/pip-freeze-installed.txt
cp /tmp/pip-freeze-installed.txt /tmp/pip-freeze-with-removal.txt

# Remove machine learning packages to decrease the image size
remove_machine_learning_packages () {
    grep -v -e "^chex" -e "^datascience" -e "^en-core-web-sm" -e "^fastai" -e "^flax" -e "^gensim" -e "^jax" -e "^kapre" -e "^keras" -e "^Keras" -e "^malloy" -e "^optax" -e "^orbax" -e "^tensorboard" -e "^tensorflow" -e "^torch" -e "^triton" -e "^xgboost" -h ${1} > ${1}.tmp
    mv ${1}.tmp ${1}
}
remove_machine_learning_packages /tmp/pip-freeze-with-removal.txt

# Carry out removal
diff --changed-group-format='%<%>' --unchanged-group-format='' /tmp/pip-freeze-installed.txt /tmp/pip-freeze-with-removal.txt | cut -f1 -d "=" | xargs pip uninstall -y

# Install cython, which is already shipped in the actual kaggle image
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip install --user cython

# Replace numpy with the same one shipped in the actual kaggle image
python3 -m pip uninstall -y -qq numpy
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip install --user numpy

# Install sympy, which is already shipped in the actual kaggle image
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip install --user sympy

# Install pipdeptree to show dependency tree on failure of the next asserts
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip install --user pipdeptree

# Check that removed packages do get installed as part of other dependencies
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip freeze > /tmp/pip-freeze-installed-updated.txt
assert_removed_packages () {
    cp ${1} ${1}.check
    ${2} ${1}.check
    if diff --suppress-common-lines ${1}.check ${1} > ${1}.diff; then
        rm ${1}.check ${1}.diff
    else
        EXTRA_PACKAGES=$(cat ${1}.diff | grep "^> " | cut -f2 -d ">" | cut -f1 -d "=" | tr "\n" " " | sed "s/  */ /g" | xargs)
        echo "The following extra packages have been detected: ${EXTRA_PACKAGES}."
        echo "They may have been installed as part of the following dependencies:"
        PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pipdeptree --reverse --packages ${EXTRA_PACKAGES/ /,}
        return 1
    fi
}
assert_removed_packages /tmp/pip-freeze-installed-updated.txt remove_machine_learning_packages

# Install cmake (for building)
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip install --user cmake

# Install nbval (for testing)
PYTHONUSERBASE=${CONDA_PREFIX} python3 -m pip install --user nbval
