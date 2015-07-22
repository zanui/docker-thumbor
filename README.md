# zanui/thumbor

[![CircleCI](https://img.shields.io/circleci/project/zanui/docker-thumbor.svg)]()
[![Docker Stars](https://img.shields.io/docker/stars/zanui/thumbor.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/zanui/thumbor.svg)]()

thumbor is an open-source photo thumbnail service.

## Installation and Usage

    docker pull zanui/thumbor
    docker run -p 9000:9000 zanui/thumbor

To run with your own thumbor configuration:

    docker run -p 9000:9000 -e THUMBOR_ENGINE=thumbor.engines.graphicsmagick zanui/thumbor

All [configuration](https://github.com/thumbor/thumbor/wiki/Configuration) options can be passed in as environment variables.

## Available Tags

* `latest`, `4.1.0`: Currently Thumbor 4.1.0

## Deployment

To push the Docker image, run the following command:

    make release

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2015 [Zanui](https://www.zanui.com.au) and contributors.
