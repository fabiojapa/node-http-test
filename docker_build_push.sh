#!/bin/bash
docker build --no-cache -f ./Dockerfile -t fabiojapa/node-http-test:1.0.2test .
docker push fabiojapa/node-http-test:1.0.2test
