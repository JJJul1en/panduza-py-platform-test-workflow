#!/bin/bash

if [ $# -eq 0 ]
then
    docker build -t local/panduza-py-platform:latest .
else
    docker build -t local/panduza-py-platform-dev:latest .
fi
