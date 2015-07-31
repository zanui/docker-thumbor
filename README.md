# zanui/docker-thumbor

A full-featured docker image for the popular photo thumbnail service [thumbor](http://thumbor.org/).

[![CircleCI](https://img.shields.io/circleci/project/zanui/docker-thumbor.svg)](https://circleci.com/gh/zanui/docker-thumbor)
[![Docker Stars](https://img.shields.io/docker/stars/zanui/thumbor.svg)](https://registry.hub.docker.com/u/zanui/thumbor/star)
[![Docker Pulls](https://img.shields.io/docker/pulls/zanui/thumbor.svg)]()
[![](https://badge.imagelayers.io/zanui/thumbor:latest.svg)](https://imagelayers.io/?images=zanui/thumbor:latest 'Get your own badge on imagelayers.io')

## What is thumbor?

[thumbor](http://thumbor.org/) is an open-source photo thumbnail service for smart on-demand image cropping, resizing and filters.

* Homepage: http://thumbor.org/
* Documentation: https://github.com/thumbor/thumbor/wiki
* GitHub: https://github.com/thumbor/thumbor

## Installation and Usage

    docker run -p 9000:9000 zanui/thumbor
    open http://<docker-ip>:9000/unsafe/300x200/smart/s.glbimg.com/et/bb/f/original/2011/03/24/VN0JiwzmOw0b0lg.jpg

To run with your own thumbor configuration:

    docker run -p 9000:9000 -e THUMBOR_ENGINE=thumbor.engines.graphicsmagick zanui/thumbor

All [configuration](https://github.com/zanui/docker-thumbor/blob/master/build/templates/thumbor.conf.j2) options can be passed in as environment variables. Variables need to be prefix with `THUMBOR`, e.g. `MAX_WIDTH` is passed in as `THUMBOR_MAX_WIDTH`.

## Container Features

- WebP support
- GIFSICLE Engine support
- WebM support
- OpenCV support
- JPEG support
- GraphicsMagick Engine
- Optimizers (jpegtran, jpegoptim, pngcrush, jpeg-recompress)
- Thumbor Community Extensions
  - [Thumbor AWS](https://github.com/thumbor-community/aws)
- Thumbor Plugins
  - JPEG-Recompress

## Available Tags

* `latest`, `5.0.4`: Currently Thumbor 5.0.4
* `4.1.0`: Thumbor 4.1.0

## Deployment

To push the Docker image, run the following command:

    make release

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2015 [Zanui](https://www.zanui.com.au) and contributors.
