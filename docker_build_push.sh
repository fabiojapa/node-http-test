#!/bin/bash
docker build --no-cache -f ./Dockerfile -t fabiojapa/node-http-test:5.0.11 .
docker push fabiojapa/node-http-test:5.0.11
