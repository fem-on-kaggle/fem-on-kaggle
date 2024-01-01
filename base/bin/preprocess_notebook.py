# Copyright (C) 2022-2024 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT
"""Preprocess notebook."""

import sys

import nbformat


if __name__ == "__main__":
    assert len(sys.argv) == 3
    package_name = sys.argv[1]
    notebook_name = sys.argv[2]

    with open(notebook_name) as f:
        nb = nbformat.read(f, as_version=4)

    write_kaggle_json_code = """import os
kaggle_home = os.path.join(os.path.expanduser("~"), ".kaggle")
os.makedirs(kaggle_home, exist_ok=True)
kaggle_json = os.path.join(kaggle_home, "kaggle.json")
with open(kaggle_json, "w") as f:
    f.write('{"username": "", "key": ""}')
os.chmod(kaggle_json, 0o600)"""
    write_kaggle_json_cell = nbformat.v4.new_code_cell(write_kaggle_json_code)
    write_kaggle_json_cell.id = "write_kaggle_json"
    nb.cells.insert(0, write_kaggle_json_cell)

    with open(notebook_name, "w") as f:
        nbformat.write(nb, f)
