# Copyright (C) 2022-2025 by the FEM on Kaggle authors
#
# This file is part of FEM on Kaggle.
#
# SPDX-License-Identifier: MIT
"""Enable widgets."""

import os
import sys


if __name__ == "__main__":
    assert len(sys.argv) == 3
    package_name = sys.argv[1]
    package_init_file = sys.argv[2]

    assert package_name in ("pyvista", "webgui_jupyter_widgets")
    if package_name == "pyvista":
        pass  # Nothing to be done
    elif package_name == "webgui_jupyter_widgets":
        package_widget_file = os.path.join(os.path.dirname(package_init_file), "widget.py")
        with open(package_widget_file) as f:
            package_widget_file_content = f.read().strip("\n")
        package_widget_file_content = package_widget_file_content.replace(
            "_IN_GOOGLE_COLAB = False", "_IN_GOOGLE_COLAB = True")
        with open(package_widget_file, "w") as f:
            f.write(package_widget_file_content)
    else:
        raise RuntimeError("Invalid package")
