SDK=`pwd`
if [[ $(uname -m) == 'arm64' ]]; then
    EXEC=./engines/mac-arm/firespark
fi
if [[ $(uname -m) == 'i386' ]]; then
    EXEC=./engines/mac-intel/firespark
fi
${EXEC} -opengl=true \
        -html5=false \
        -viewport.width=1600 \
        -viewport.height=900 \
        -host=0.0.0.0 \
        -port=7777 \
        -static=${SDK} \
        -swagger.baseurl=http://localhost:7777 \
        -swagger.path=${SDK}/apidocs \
        -fps=50 \
        -psf=10 \
        -verbose=1 \
        -fullscreen=false