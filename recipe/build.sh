# autoreconf -vfi

cp $BUILD_PREFIX/share/gnuconfig/config.guess tclconfig/config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.sub tclconfig/config.sub

autoreconf --force --install --verbose

./configure --prefix=$PREFIX \
            --exec-prefix=$PREFIX \
            --build=$BUILD \
            --host=$HOST \
            --with-tclinclude=$PREFIX/include \
            --enable-shared \
            --enable-64bit

make -j ${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
  make test
fi
make -j ${CPU_COUNT} install

mv $PREFIX/lib/tcl*/expect${PKG_VERSION}/libexpect${PKG_VERSION}${SHLIB_EXT} $PREFIX/lib
ln -s libexpect${PKG_VERSION}${SHLIB_EXT} $PREFIX/lib/libexpect${SHLIB_EXT}
