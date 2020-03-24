make clean

#THEME=colibre_svg
THEME=sukapura_svg

./autogen.sh --with-lang="bs" \
   --with-locales="bs" \
   --with-vendor="hernad" \
   --with-theme="$THEME" \
    --with-visual-studio=2019 \
    --without-doxygen \
    --without-java \
    --with-product-name="LO_Ziher"\
    --with-package-version='7.0.0.10'\
    --enable-release-build

make build-nocheck
