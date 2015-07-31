#!/bin/sh
DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Set up group/user
addgroup --system --gid 500 thumbor
adduser --system --shell /bin/sh --gecos 'Thumbor user' --uid 500 --gid 500 --disabled-password --home /data/thumbor thumbor
mkdir -p /data/thumbor/result-storage /data/thumbor/storage
chown -R thumbor:thumbor /data/thumbor

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
# - OPENJPEG (JPEG2000) support (libopenjpeg2, libopenjpeg-dev)
# - LIBTIFF support (libtiff-dev)
# - PNG support (libpng-dev)
# - FREETYPE2 support (libfreetype6, libfreetype6-dev)
# - Compression lib for PIL (zlib1g-dev)
# - GraphicsMagick Engine (python-pgmagick, python-pycurl)
# - Optimizers (jpegoptim, pngcrush, libjpeg-progs)
apt-get update -y
apt-get install -y --no-install-recommends \
    build-essential \
    python python-dev python-pip \
    webp libwebp-dev \
    gifsicle libgif-dev \
    libvpx1 libvpx-dev \
    python-opencv \
    libjpeg-dev \
    libfreetype6 libfreetype6-dev \
    zlib1g-dev \
    python-pgmagick python-pycurl \
    jpegoptim pngcrush libjpeg-progs

# Install jpeg-archive
curl -L -s -o /tmp/jpeg-archive.tar.bz2 https://github.com/danielgtaylor/jpeg-archive/releases/download/2.1.1/jpeg-archive-2.1.1-linux.tar.bz2
tar -jxvf /tmp/jpeg-archive.tar.bz2 -C /usr/bin --wildcards 'jpeg-*'

# Install Python libraries
pip install \
    remotecv graphicsmagick-engine opencv-engine j2cli \
    Pillow==2.9.0 \
    tc_aws \
    thumbor==$THUMBOR_VERSION

pip install https://github.com/zanui/thumbor-plugins/archive/jpegrecompress_add_options.zip

# Remove python compiled files and tests
find /usr/local \
		\( -type d -a -name test -o -name tests \) \
		-o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		-exec rm -rf '{}' +

# Remove dev libraries
apt-get remove -y build-essential vim
dpkg --get-selections | cut -f1 | cut -d':' -f1 | grep '\-dev$' | xargs apt-get remove -y

# General cleanup
apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
