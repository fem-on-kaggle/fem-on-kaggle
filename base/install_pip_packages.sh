# Copyright (C) 2022-2025 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT

# Kaggle image is based on Colab one (with a few additions/changes to packages)
# so start from the script provided by FEM on Colab
cp ${FEM_ON_COLAB_SCRIPTS}/base/install_pip_packages.sh ${DOCKER_SCRIPTS}/base/install_pip_packages_colab.sh

# Blacklist a few other Kaggle specific packages, installed either by Dockerfile.tmpl or kaggle_requirements.txt
read -r -d '' BLACKLIST_KAGGLE_PACKAGES << "EOL"
remove_kaggle_packages () {
    grep -v -e "^annoy" -e "^astropy" -e "^bayesian-optimization" -e "^Boruta" -e "bq_helper$" -e "^Cartopy" -e "^category-encoders" -e "^category_encoders" -e "^cesium" -e "^datashader" -e "^deap" -e "^dipy" -e "^docker" -e "^easyocr" -e "^eli5" -e "^fasttext" -e "^featuretools" -e "^h2o" -e "^hep-ml" -e "^hep_ml" -e "^holoviews" -e "^imutils" -e "^in-toto" -e "^jieba" -e "^jupytext" -e "^kornia" -e "^learntools" -e "^lime" -e "^mdit-py-plugins" -e "^mlcrate" -e "^nilearn" -e "^nltk" -e "^onnx" -e "^opentelemetry" -e "^optuna" -e "^pandas-profiling" -e "^panel" -e "^plotnine" -e "^preprocessing" -e "^pyLDAvis" -e "^pymc3" -e "^ray" -e "^rgf-python" -e "^segment_anything" -e "^sigstore" -e "^stable-baselines" -e "^textblob" -e "^Theano" -e "^TPOT" -e "^wandb" -h ${1} > ${1}.tmp
    mv ${1}.tmp ${1}
}
remove_kaggle_packages ${BACKEND_INFO}/pip-freeze-clean.txt
EOL
BLACKLIST_KAGGLE_PACKAGES="${BLACKLIST_KAGGLE_PACKAGES//$'\n'/\\n}"
BLACKLIST_KAGGLE_PACKAGES="${BLACKLIST_KAGGLE_PACKAGES//\$/\\$}"
perl -i -pe "s|remove_misc_packages \\\${BACKEND_INFO}/pip-freeze-clean.txt|remove_misc_packages \\\${BACKEND_INFO}/pip-freeze-clean.txt\n${BLACKLIST_KAGGLE_PACKAGES}|g" ${DOCKER_SCRIPTS}/base/install_pip_packages_colab.sh

# Check that blacklisted Kaggle specific packages do not get installed as part of other dependencies
read -r -d '' BLACKLIST_KAGGLE_PACKAGES_CHECK << "EOL"
assert_removed_packages ${BACKEND_INFO}/pip-freeze-installed.txt remove_kaggle_packages
EOL
BLACKLIST_KAGGLE_PACKAGES_CHECK="${BLACKLIST_KAGGLE_PACKAGES_CHECK//$'\n'/\\n}"
BLACKLIST_KAGGLE_PACKAGES_CHECK="${BLACKLIST_KAGGLE_PACKAGES_CHECK//\$/\\$}"
perl -i -pe "s|assert_removed_packages \\\${BACKEND_INFO}/pip-freeze-installed.txt remove_misc_packages|assert_removed_packages \\\${BACKEND_INFO}/pip-freeze-installed.txt remove_misc_packages\n${BLACKLIST_KAGGLE_PACKAGES_CHECK}|g" ${DOCKER_SCRIPTS}/base/install_pip_packages_colab.sh

# Run the installation script
bash ${DOCKER_SCRIPTS}/base/install_pip_packages_colab.sh
