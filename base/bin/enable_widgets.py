# Copyright (C) 2022 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT
"""Enable widgets."""

import sys


if __name__ == "__main__":
    assert len(sys.argv) == 3
    package_name = sys.argv[1]
    package_init_file = sys.argv[2]

    assert package_name in ("itkwidgets", "pythreejs", "pyvista", "webgui_jupyter_widgets")
    if package_name in ("itkwidgets", "pythreejs", "pyvista"):
        pass  # Nothing to be done
    elif package_name == "webgui_jupyter_widgets":
        with open(package_init_file, "r") as f:
            package_init_file_content = f.read().strip("\n")
        package_init_file_content = package_init_file_content.replace(
            "_IN_GOOGLE_COLAB = False", "_IN_GOOGLE_COLAB = True")
        with open(package_init_file, "w") as f:
            f.write(package_init_file_content)
    else:
        raise RuntimeError("Invalid package")
