# Copyright (c) 2014 Internet Services Australia 3 Pty Limited (http://www.zanui.com.au)
# MIT License, see LICENSE.md for details.

FROM phusion/baseimage:0.9.15

MAINTAINER Zanui Engineering Team <engineering@zanui.com.au>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV THUMBOR_VERSION 5.2.1

COPY build /opt/build
RUN chmod u+x /opt/build/run.sh
RUN /opt/build/run.sh

#VOLUME /data/thumbor

EXPOSE 9000

CMD ["/sbin/my_init"]
