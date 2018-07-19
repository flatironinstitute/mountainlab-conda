# mountainlab-conda

A collection of recipes for building conda packages for [Mountainlab](https://github.com/flatironinstitute/mountainlab-js) and Mountainsort

Important config information is provided in the top-level `conda_build_config.yaml` and `recipe_append.yaml files`, so you must build the recipes from this directory

To build (in a conda env with `conda-build` installed):
```
cd /path/to/mountainlab-conda/
./build_all.sh
```

After all packages are built, this will create a files list (linked from pkglist_latest) that can be used to upload packages to anaconda.org:

In a conda env with `anaconda-client` installed, and with login credentials stored:
```
anaconda upload `cat pkglist_latest`
```

(This file list is also helpful for upating version #s in the 'mountainsort' metapackage)