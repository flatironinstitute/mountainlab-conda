#/bin/bash -eux
set -euxo pipefail
[ -d "${ML_CONDA_PACKAGES_DIR}" ] # (set in mountainlab_activate.sh, a build requirement)
env | sort
nproc=$(sysctl -n hw.ncpu) # [osx]
#   - nproc=$(nproc) # [linux]
echo ====== OSX LINE # [osx]
echo ====== LINUX LINE # [linux]

# all of this business necessary to use the conda-provided clang (which is openmp capable), see
# https://github.com/ContinuumIO/anaconda-issues/issues/9745

# wget https://github.com/phracker/MacOSX-SDKs/releases/download/10.13/MacOSX10.9.sdk.tar.xz  # [osx]
# tar xf MacOSX10.9.sdk.tar.xz  # [osx]
# export CONDA_BUILD_SYSROOT="$PWD"/MacOSX10.9.sdk # [osx]
export CONDA_BUILD_SYSROOT=/opt/MacOSX10.9.sdk # [osx]
export XC_AVOIDANCE_PATH_QT="${PREFIX}"/bin/xc-avoidance/ # Qt is in 'host' env, not build
[ -d "${XC_AVOIDANCE_PATH_QT}" ] # (set in Qt
export PATH=$XC_AVOIDANCE_PATH_QT:$PATH
which xcrun

# TODO: move qmake args to the ms3.pro file?
qmake INCLUDEPATH+=$PREFIX/include CONFIG-=app_bundle

make -j${nproc} sub-packages-ms3-ms3-pro 
find packages/ms3 | sort
cp packages/ms3/bin/ms3.mp "$ML_CONDA_PACKAGES_DIR"
