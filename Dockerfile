FROM kalilinux/kali-rolling

MAINTAINER Zekeriya AY <zekeriyaay.com>
LABEL description="Kali Linux Minimal Docker Image"

### ARGs ###
ARG DEBIAN_FRONTEND=noninteractive

# https://www.kali.org/docs/general-use/metapackages/
# https://www.kali.org/tools/kali-meta/
ARG DESKTOP_ENV=xfce
ARG SYSTEM_PKG=default

ARG RDP_PORT=3389

ARG START_SH=/tmp/start_dlk.sh
ARG KEYBOARD_LAYOUT='tr'

ARG USER_NAME=dalak
ARG USER_PASSWD=$USER_NAME
ARG ROOT_PASSWD=root


### root/normal User Setup ###
USER root
RUN echo "root:$ROOT_PASSWD" | chpasswd
RUN useradd -m -s /bin/zsh -G sudo $USER_NAME
RUN echo "$USER_NAME:$USER_PASSWD" | chpasswd


### Update & Upgrade ###
RUN apt-get -y update --fix-missing
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade
RUN apt-get -y install --no-install-recommends kali-linux-$SYSTEM_PKG
RUN apt-get -y autoremove
RUN apt-get -y autoclean
RUN apt-get -y clean


### Install Package/Desktop Env. ###
RUN apt-get -y install --no-install-recommends sudo wget curl git net-tools python3-pip


### Starter SH File ###
RUN echo "#!/bin/bash" > $START_SH
RUN chmod 755 $START_SH


### GUI & RDP ###
RUN apt-get -y install --no-install-recommends xorg xorgxrdp xrdp dbus-x11
RUN apt-get -y install --no-install-recommends kali-desktop-$DESKTOP_ENV
RUN sed -i s/^port=3389/port=${RDP_PORT}/g /etc/xrdp/xrdp.ini
RUN echo "/etc/init.d/xrdp start" >> $START_SH


### Keyboard ###
# RUN sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'$KEYBOARD_LAYOUT'\"/g' /etc/default/keyboard
# RUN echo "setxkbmap $KEYBOARD_LAYOUT" >> $START_SH


RUN echo "/bin/bash" >> $START_SH

WORKDIR /home/$USER_NAME
EXPOSE $RDP_PORT
CMD ["/tmp/start_dlk.sh"]
