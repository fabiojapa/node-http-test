#!/bin/bash
docker build --no-cache -f ./Dockerfile -t fabiojapa/node-http-test:4.0.0 .
docker push fabiojapa/node-http-test:4.0.0
