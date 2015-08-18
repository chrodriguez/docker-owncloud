FROM ubuntu:14.04
MAINTAINER chrodriguez <chrodriguez@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root
# Don't ask user options when installing
env   DEBIAN_FRONTEND noninteractive
RUN echo APT::Install-Recommends "0"; >> /etc/apt/apt.conf
RUN echo APT::Install-Suggests "0"; >> /etc/apt/apt.conf

# Update system
RUN apt-get -y update && apt-get -y dist-upgrade
RUN apt-get -y install wget
RUN echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/owncloud.list && \
    cd /tmp && \
    wget http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_14.04/Release.key && \
    apt-key add - < Release.key
RUN apt-get -y update && apt-get -y dist-upgrade

RUN apt-get install -y owncloud
RUN apt-get install -y php-apc

RUN apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN rm -f /var/www/html/index.html

VOLUME ["/etc/owncloud", "/var/www/owncloud/data/"]

COPY start.sh /start.sh

CMD ["/start.sh"]


