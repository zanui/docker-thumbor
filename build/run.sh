#!/bin/sh
DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Copy all files in templates/etc to /etc
# - Includes filter documentation and locales (https://github.com/phusion/baseimage-docker/issues/238)
find $DIR/templates/etc -type f | sed -e 's|^'$DIR/templates'||' | xargs -I% -n1 cp $DIR/templates% %

# Copy configuration files
cp $DIR/templates/thumbor.conf.j2 /etc/thumbor.conf.j2

mkdir -p /etc/service/thumbor
cp $DIR/templates/runit_thumbor /etc/service/thumbor/run
chmod +x /etc/service/thumbor/run

# Install packages
# Packages:
# - WebP support (webp, libwebp-dev)
# - GIFSICLE Engine support (gifsicle, libgif-dev)
# - WebM support (libvpx1, libvpx-dev)
# - OpenCV support (python-opencv)
# - JPEG support (libjpeg-dev)
# - Compression lib for PIL (zlib1g-dev)
# - GraphicsMagick Engine (python-pgmagick, python-pycurl)
# - Optimizers (jpegoptim, pngcrush)
apt-get update -y
apt-get install -y --no-install-recommends \
    build-essential \
    python python-dev python-pip \
    webp libwebp-dev \
    gifsicle libgif-dev \
    libvpx1 libvpx-dev \
    python-opencv \
    libjpeg-dev \
    zlib1g-dev \
    python-pgmagick python-pycurl \
    jpegoptim pngcrush

pip install \
    remotecv graphicsmagick-engine opencv-engine j2cli \
    Pillow==2.3.0 \
    thumbor==$THUMBOR_VERSION

# Remove dev libraries and clean up
# apt-get remove -y build-essential python-dev libwebp-dev libgif-dev libvpx-dev libjpeg-dev zlib1g-dev vim
apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
