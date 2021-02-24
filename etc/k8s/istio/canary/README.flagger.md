
# ISTIO / FLAGGER Canary Deploy POC

## Install Istio with default profile

```sh
istioctl install --set profile=default -y
kubectl label namespace default istio-injection=enabled
kubectl apply -f /home/sakamoto/opt/dev/istio-1.9.0/samples/addons
```

    https://istio.io/latest/docs/setup/getting-started/
    https://istio.io/latest/docs/setup/additional-setup/config-profiles/

## Install Flagger

1. Add Flagger Helm repository:
```sh
helm repo add flagger https://flagger.app
```

2. Install Flagger's Canary CRD:
```sh
kubectl apply -f https://raw.githubusercontent.com/fluxcd/flagger/main/artifacts/flagger/crd.yaml
```

3. Deploy Flagger for Istio:
```sh
helm upgrade -i flagger flagger/flagger \
--namespace=istio-system \
--set crd.create=false \
--set meshProvider=istio \
--set metricsServer=http://prometheus:9090
```

    https://docs.flagger.app/install/flagger-install-on-kubernetes

4. Deploy Flagger Grafana
```sh
helm upgrade -i flagger-grafana flagger/grafana \
--namespace=istio-system \
--set url=http://prometheus:9090 \
--set user=admin \
--set password=changeme
```

5. Access Grafana
```sh
kubectl -n istio-system port-forward svc/flagger-grafana 3000:80
```
    http://localhost:3000/d/flagger-istio/istio-canary

    https://medium.com/expedia-group-tech/flagger-monitor-your-canary-deployments-with-grafana-21b9dd58b10e

6. Deploy node-http-test
```sh
kubectl apply -f etc/k8s/istio/prod/app.yml
```

7. Create Canary Configuration
```sh
kubectl apply -f etc/k8s/istio/canary/canary.yml
```

8.  Update image deployment
```sh
kubectl set image deployment/node-http-test node-http-test=fabiojapa/node-http-test:2.0.1
```

9. Chamar pelo postman 
```sh
curl --location --request GET 'http://sakanaryistio.io' --header 'country: MX'

curl --header "country: MX" http://node-http-test
```


## ref:
    https://docs.flagger.app/install/flagger-install-on-kubernetes
    https://docs.flagger.app/tutorials/istio-progressive-delivery
    https://flagger.app/intro/faq.html