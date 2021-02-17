# node-http-test 

## Test purpose to test canary release with ISTIO on Kubernetes

### Pre-requisites
1. Install Istio and Kiali on your Kubernetes cluster:

   https://istio.io/latest/docs/setup/getting-started/

### Docker image used

   https://hub.docker.com/r/fabiojapa/node-http-test

### Execution

1. Apply Production version
```sh
$ kubectl apply -f etc/k8s/simple/production.yaml
$ kubectl apply -f etc/k8s/simple/production.istio.yaml
```

2. Apply Canary version
```sh
$ kubectl apply -f etc/k8s/simple/canary.yaml
$ kubectl apply -f etc/k8s/simple/canary.istio.yaml
```

3. Test Call without header: to production
```sh
$ for i in $(seq 1 10); do curl -s --resolve sakanaryistio.io:80:35.225.46.99 http://sakanaryistio.io ; done
```

4. Test Call with header "country: ARG": to production
```sh
$ for i in $(seq 1 10); do curl -s -H "country: ARG" --resolve sakanaryistio.io:80:35.225.46.99 http://sakanaryistio.io ; done
```

5. Test Call with header "country: MX": to canary
```sh
$ for i in $(seq 1 10); do curl -s -H "country: MX" --resolve sakanaryistio.io:80:35.225.46.99 http://sakanaryistio.io ; done
```

### References

1. https://istio.io/latest/docs/setup/getting-started/
2. https://istio.io/latest/docs/examples/bookinfo/
3. https://istio.io/latest/docs/reference/config/networking/gateway/
4. https://kublr.com/blog/hands-on-canary-deployments-with-istio-and-kubernetes/

** Istio with nginx? https://discuss.istio.io/t/istio-without-gateway-with-nginx-ingress/593