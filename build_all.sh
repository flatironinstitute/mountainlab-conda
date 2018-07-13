#!/bin/bash
set -u -x -o pipefail
conda build --skip-existing -c tjd2002 recipe.mountainlab/ recipe.isosplit5/ recipe.mountainlab_pytools/ recipe.ml_ephys/ recipe.ml_ms4alg/ recipe.ml_ms3/ recipe.qt-mountainview/
