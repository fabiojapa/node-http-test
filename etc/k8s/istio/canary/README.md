
# ISTIO POC

## Observability
1. Kiali
```sh
kubectl apply -f /home/sakamoto/opt/dev/istio-1.9.0/samples/addons
istioctl dashboard kiali
```
    https://istio.io/latest/docs/ops/integrations/kiali/
    https://istio.io/latest/docs/setup/getting-started/#dashboard

2. Jaeger
```sh
kubectl apply -f /home/sakamoto/opt/dev/istio-1.9.0/samples/addons
istioctl dashboard jaeger
```
    https://istio.io/latest/docs/tasks/observability/distributed-tracing/jaeger/


# retry:
1. Escalar em 2
```sh
kubectl apply -f etc/k8s/istio/canary/app.yml

kubectl scale deployment/node-http-test-canary --replicas 2
```

2. Chamar pelo postman e mostrar erro
```sh
 for i in $(seq 1 100); do curl --location --request GET 'http://sakanaryistio.io/test' --header 'country: MX'; echo "" ; done
```

3. Aplicar
```sh
kubectl apply -f etc/k8s/istio/canary/istio-retry.yml
```

4. Chamar pelo postman e mostrar retry
```sh
curl --location --request GET 'http://sakanaryistio.io/test' --header 'country: MX'
```


5. ref: 
   
    https://istio.io/latest/docs/concepts/traffic-management/#retries
    https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#x-envoy-retry-on


# circuit break:
1. Escalar em 1
```sh
kubectl scale deployment/node-http-test-canary --replicas 1
```

2. criar o pod client para chamadas de testes
```sh
kubectl apply -f /home/sakamoto/opt/dev/istio-1.9.0/samples/httpbin/sample-client/fortio-deploy.yaml
```

3. ver o nome do pod fortio
```sh
 export FORTIO_POD=$(kubectl get pods -lapp=fortio -o 'jsonpath={.items[0].metadata.name}')
```

4. executar o teste e ver que todas bateram no pod
```sh
kubectl exec -it $FORTIO_POD -c fortio --  /usr/bin/fortio load -c 3 -qps 0 -n 40 -loglevel Warning http://node-http-test-canary/ok
```

5. Aplicar
```sh
kubectl apply -f etc/k8s/istio/canary/istio-circuit-break-max-connection.yml
```

6. executar o teste e ver que o circuit break abriu
```sh
kubectl exec -it $FORTIO_POD -c fortio --  /usr/bin/fortio load -c 3 -qps 0 -n 40 -loglevel Warning http://node-http-test-canary/ok
```

7. ref:
   
   https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/

# circuit break: pool-ejection
1. chamar pelo postman e ver erros
```sh
kubectl apply -f etc/k8s/istio/canary/app.yml

for i in {1..30}; do curl --header "country: MX" http://sakanaryistio.io/test ; echo "" ; done
```

2. Aplicar
```sh
kubectl apply -f etc/k8s/istio/canary/istio-circuit-break-pool-ejection.yml
```

3. chamar pelo postman e mostrar pool-ejection
```sh
for i in {1..30}; do curl --header "country: MX" http://sakanaryistio.io/test ; echo "" ; done
```

4. aguardar 1min e chamar pelo postman e mostrar que voltou a chamar ms
```sh
for i in {1..30}; do curl --header "country: MX" http://sakanaryistio.io/test ; done
```

5. ref:

    https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/


