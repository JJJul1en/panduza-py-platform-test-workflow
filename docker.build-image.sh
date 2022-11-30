#!/bin/bash


if [ $# -eq 0 ]
then
    docker build -t local/panduza-py-platform:latest . --build-arg PZA_PY_PLATFORM_MODE=prod
else
    docker build -t local/panduza-py-platform-dev:latest . --build-arg PZA_PY_PLATFORM_MODE=dev
fi

