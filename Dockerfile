FROM ubuntu:22.04

# 
LABEL org.opencontainers.image.source https://github.com/Panduza/panduza-py-platform

# Argument
#ENV ARG PZA_PY_PLATFORM_MODE

# Install Packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Europe/Paris \
    apt-get -y install \
    python3 python3-pip \
    udev

RUN apt-get -y update
RUN apt-get -y install git

# Pip installations
RUN pip install pyudev
RUN pip install loguru
RUN pip install pyserial
RUN pip install minimalmodbus
RUN pip install paho-mqtt
RUN pip install python-magic
RUN pip install python-statemachine
RUN pip install behave-html-formatter

# repos clone
RUN echo $PZA_PY_PLATFORM_MODE
# build with plug-ins when prod
RUN bash -c "if [[ $PZA_PY_PLATFORM_MODE = "prod" ]] ; then \
    pip install git+https://github.com/Panduza/picoha-io.git \
    pip install git+https://github.com/paulhfisher/panduza-py-class-power-supply.git ; fi"

#
RUN mkdir /etc/panduza

#
WORKDIR /setup
COPY . /setup/
RUN pip install .
RUN cp -v ./deploy/pza-py-platform-run.py /usr/local/bin/pza-py-platform-run.py

#
ENV PYTHONPATH="/etc/panduza/plugins/py"

#
WORKDIR /work

# Create the directory for platform plugins
# Then run the platform
CMD mkdir -p /etc/panduza/plugins/py; \
    python3 /usr/local/bin/pza-py-platform-run.py
        
