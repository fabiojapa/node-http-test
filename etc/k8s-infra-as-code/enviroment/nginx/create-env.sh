#!/bin/bash

## plano terraform
export GOOGLE_APPLICATION_CREDENTIALS=/home/sakamoto/.kube/fabiojapa-45622aa6f43b.json

terraform init
terraform apply -auto-approve

gcloud container clusters get-credentials saka-k8s-nginx --zone us-central1-c --project fabiojapa

## https://kubernetes.github.io/ingress-nginx/deploy/#gce-gke
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole cluster-admin \
  --user $(gcloud config get-value account)

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/cloud/deploy.yaml

kubectl apply -f etc/k8s/nginx/prod/app.yml

kubectl get svc -n ingress-nginx