#!/bin/bash

## plano terraform
export GOOGLE_APPLICATION_CREDENTIALS=/home/sakamoto/.kube/fabiojapa-45622aa6f43b.json

terraform init
terraform apply -auto-approve

gcloud container clusters get-credentials saka-k8s-istio --zone us-central1-c --project fabiojapa

## https://istio.io/latest/docs/setup/getting-started/

curl -L https://istio.io/downloadIstio | sh -

cd istio-1.9.0

export PATH=$PWD/bin:$PATH

istioctl install --set profile=demo -y

kubectl label namespace default istio-injection=enabled

kubectl apply -f samples/addons

kubectl rollout status deployment/kiali -n istio-system

istioctl dashboard kiali

kubectl get svc -n istio-system



kubectl apply -f etc/k8s/simple/canary.yaml

kubectl apply -f etc/k8s/istio/prod/app.yml