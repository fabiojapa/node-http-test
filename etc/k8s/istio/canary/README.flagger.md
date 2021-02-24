
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
--set password=admin
```

5. Access Grafana
```sh
kubectl -n istio-system port-forward svc/flagger-grafana 3000:80
```
    http://localhost:3000/d/flagger-appmesh/appmesh-canary?orgId=1&refresh=10s
    http://localhost:3000/d/flagger-istio/istio-canary
    http://localhost:3000/d/flagger-envoy/envoy-canary?orgId=1&refresh=10s

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
kubectl set image deployment/node-http-test node-http-test=fabiojapa/node-http-test:3.0.1
```

9. Chamar pelo postman 
```sh
for i in $(seq 1 10); do curl --location --request GET 'http://sakanaryistio.io' --header 'country: MX' ; done

for i in $(seq 1 10); do curl --header "country: MX" http://node-http-test ; done

```

10.  Simular Rollback Update image deployment
```sh
kubectl set image deployment/node-http-test node-http-test=fabiojapa/node-http-test:4.0.0
```
9. Chamar pelo postman 
```sh
for i in $(seq 1 10); do curl --location --request GET 'http://sakanaryistio.io/test' --header 'country: MX' ; done

for i in $(seq 1 10); do curl --header "country: MX" http://node-http-test/test ; done

```

## ref:
    https://docs.flagger.app/install/flagger-install-on-kubernetes
    https://docs.flagger.app/tutorials/istio-progressive-delivery
    https://flagger.app/intro/faq.html