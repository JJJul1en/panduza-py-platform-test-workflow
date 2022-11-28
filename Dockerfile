FROM ubuntu:22.04


LABEL org.opencontainers.image.source https://github.com/Panduza/panduza-py-platform

# Install Packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Europe/Paris \
    apt-get -y install \
    python3 python3-pip \
    udev

RUN apt-get -y update
RUN apt-get -y install git

#
# RUN echo "SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", IMPORT{builtin}="usb_id", IMPORT{builtin}="hwdb --subsystem=usb"" > /etc/udev/rules.d/import.rules


#
RUN pip install pyudev
RUN pip install loguru
RUN pip install paho-mqtt
RUN pip install python-magic
RUN pip install python-statemachine
RUN pip install behave-html-formatter

# repos clone
# if dev
RUN echo
# qqchose comme ça
# si image name ne finit pas par dev alors run pip
RUN if [[ images != *-dev ]] ; then \
    pip install git+https://github.com/Panduza/picoha-io.git \
    pip install git+https://github.com/paulhfisher/panduza-py-class-power-supply.git ; fi

#
RUN mkdir /etc/panduza


#f
WORKDIR /setup
COPY . /setup/
RUN pip install .
RUN cp -v ./deploy/pza-py-platform-run.py /usr/local/bin/pza-py-platform-run.py

#
ENV PYTHONPATH="/etc/panduza/plugins/py"

#
WORKDIR /work

#
CMD python3 /usr/local/bin/pza-py-platform-run.py