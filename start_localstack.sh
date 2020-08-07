#! /usr/bin/env bash

if [ ! "$(docker ps -q -f name=localstack_sfn)" ]; then

    docker run \
        -p 4566-4584:4566-4584 \
        -e DOCKER_HOST=unix:///var/run/docker.sock \
        -e SERVICES=serverless,stepfunctions \
        -e LAMBDA_EXECUTOR=docker-reuse \
        --name localstack_sfn \
        localstack/localstack

else

    docker restart localstack_sfn

fi
