#!/bin/bash
docker build --no-cache -f ./Dockerfile -t fabiojapa/node-http-test:3.0.0 .
docker push fabiojapa/node-http-test:3.0.0
