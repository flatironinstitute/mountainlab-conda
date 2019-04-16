#!/bin/bash
set -e -u -x -o pipefail
RECIPE_DIRS_ORDERED="\
recipe.mountainlab \
recipe.mountainlab_pytools \
recipe.ml_ephys \
recipe.isosplit5 \
recipe.ml_ms4alg \
recipe.ml_ms3 \
recipe.ml_pyms \
recipe.qt-mountainview \
recipe.ephys-viz \
"

# avoid bootstrapping with existing published packages (i.e. don't include tjd2002/flatiron)
# (but local always included--may need to blow away conda-bld if needed)
channel_args="-c defaults -c conda-forge -c local --override-channels"
append_args="--append-file=recipe_append.yaml"
for recipe in $RECIPE_DIRS_ORDERED
do
    conda build --check $channel_args $append_args $recipe || exit 2
done

for recipe in $RECIPE_DIRS_ORDERED
do
    conda build --skip-existing $channel_args $append_args $recipe || exit 3
done

# Get filenames of all packages (even if they were skipped by '--skip-existing')
tmpfile=`mktemp ./pkglist.XXXXXX`
conda build --output $channel_args $append_args $RECIPE_DIRS_ORDERED>$tmpfile
ln -sf $tmpfile pkglist_latest

echo 'Run "anaconda upload -u flatiron --skip-existing `cat pkglist_latest`" to upload all packages to the Flatiron channel'
