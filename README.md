# node-http-test 

## Test purpose to test canary release with nginx ingress controller on Kubernetes

### Pre-requisites
1. Create nginx ingress controller on your Kubernetes cluster:

   https://kubernetes.github.io/ingress-nginx/deploy/#gce-gke

### Docker image used

   https://hub.docker.com/r/fabiojapa/node-http-test

### Execution

1. Apply Production version
```sh
$ kubectl apply -f etc/k8s/simple/production.yaml
$ kubectl apply -f etc/k8s/simple/production.ingress.yaml
```

2. Apply Canary version
```sh
$ kubectl apply -f etc/k8s/simple/canary.yaml
$ kubectl apply -f etc/k8s/simple/canary.ingress.yaml
```

3. Test Call without header: to production
```sh
$ for i in $(seq 1 10); do curl -s --resolve sakanary.io:80:34.69.141.177 http://sakanary.io ; done
```

4. Test Call with header "country: ARG": to production
```sh
$ for i in $(seq 1 10); do curl -s -H "country: ARG" --resolve sakanary.io:80:34.69.141.177 http://sakanary.io ; done
```

5. Test Call with header "country: MX": to canary
```sh
$ for i in $(seq 1 10); do curl -s -H "country: MX" --resolve sakanary.io:80:34.69.141.177 http://sakanary.io ; done
```

### References

1. https://kubernetes.github.io/ingress-nginx/deploy/#gce-gke
2. https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#canary
3. https://v2-1.docs.kubesphere.io/docs/quick-start/ingress-canary/ 

** Istio with nginx? https://discuss.istio.io/t/istio-without-gateway-with-nginx-ingress/593

