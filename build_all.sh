#!/bin/bash
set -e -u -x -o pipefail
RECIPE_DIRS_ORDERED="\
recipe.isosplit5 \
recipe.ml_ms3 \
recipe.ml_pyms \
recipe.qt-mountainview \
recipe.mountainsort \
"

# avoid bootstrapping with existing published packages (i.e. don't include tjd2002/flatiron)
# (but local always included--may need to blow away conda-bld if needed)
channel_args="-c defaults -c conda-forge -c local -c flatiron --override-channels"
append_args="--append-file=recipe_append.yaml"
conda build --check $channel_args $append_args $RECIPE_DIRS_ORDERED || exit 2
conda build --skip-existing $channel_args $append_args $RECIPE_DIRS_ORDERED || exit 3

# Get filenames of all packages (even if they were skipped by '--skip-existing')
tmpfile=`mktemp ./pkglist.XXXXXX`
conda build --output $channel_args $append_args $RECIPE_DIRS_ORDERED>$tmpfile
ln -sf $tmpfile pkglist_latest

echo 'Run "anaconda upload `cat pkglist_latest`" to upload all packages'
