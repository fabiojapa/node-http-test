
# ISTIO POC
# retry:
1. Aplicar
```sh
kubectl apply -f etc/k8s/istio/canary/istio-retry.yml
```

2. Chamar pelo postman 
```sh
curl --location --request GET 'http://sakanaryistio.io/test' --header 'country: MX'
```

3. ref: 
   
    https://istio.io/latest/docs/concepts/traffic-management/#retries
    https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#x-envoy-retry-on


# circuit break:
1. Aplicar
```sh
kubectl apply -f etc/k8s/istio/canary/istio-circuit-break-max-connection.yml
```

2. criar o pod cliet para chamadas de testes
```sh
kubectl apply -f /home/sakamoto/opt/dev/istio-1.9.0/samples/httpbin/sample-client/fortio-deploy.yaml
```

3. ver o nome do pod fortio
```sh
 export FORTIO_POD=$(kubectl get pods -lapp=fortio -o 'jsonpath={.items[0].metadata.name}')
```

4. executar o teste
```sh
kubectl exec -it fortio-deploy-6dc9b4d7d9-qdw25 -c fortio --  /usr/bin/fortio load -c 3 -qps 0 -n 40 -loglevel Warning http://node-http-test
```

5. ref:
   
   https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/

# circuit break: pool-ejection
1. Aplicar
```sh
kubectl apply -f etc/k8s/istio/canary/istio-circuit-break-pool-ejection.yml
```

2. chamar pelo postman 
```sh
curl --location --request GET 'http://sakanaryistio.io/test' --header 'country: MX'
```

3. ref:

    https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/
