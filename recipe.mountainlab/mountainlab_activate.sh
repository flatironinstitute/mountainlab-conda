#echo "=== [ mountainlab activate script ] ======================================="
#echo ":"

# These dirs are created on install (see conda-recipe/meta.yaml)
export ML_CONDA_DIR="${CONDA_PREFIX?}"/etc/mountainlab
export ML_CONDA_PACKAGES_DIR="$ML_CONDA_DIR"/packages
export ML_CONDA_DATABASE_DIR="$ML_CONDA_DIR"/database

export ML_CONFIG_DIRECTORY=$ML_CONDA_DIR

#echo ": Run 'ml-config' to see all search paths in use."
