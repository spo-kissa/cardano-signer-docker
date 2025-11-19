#!/usr/bin/env bash


mkdir -p /tmp/docker-empty-config

echo Dockerfileをビルドします...
DOCKER_CONFIG=/tmp/docker-empty-config docker build -t signer:1.0 .

echo Dockerを起動します...
docker run --rm -dit --init -v ./share:/root/share --name spokissa-signer signer:1.0

echo SIP-8署名を実行します...
docker exec -it spokissa-signer bash sign.sh

echo Dockerを停止します...
docker stop spokissa-signer

echo DockerImageを削除します...
docker image rm --force signer:1.0

