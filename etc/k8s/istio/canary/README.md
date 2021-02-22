
retry:
kubectl apply -f etc/k8s/istio/canary/istio-retry.yml

chamar pelo postman 
curl --location --request GET 'http://sakanaryistio.io/test' --header 'country: MX'
ref: 
https://istio.io/latest/docs/concepts/traffic-management/#retries
https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#x-envoy-retry-on


circuit break:
kubectl apply -f etc/k8s/istio/canary/istio-circuit-break-max-connection.yml

criar o pod cliet para chamadas de testes
kubectl apply -f /home/sakamoto/opt/dev/istio-1.9.0/samples/httpbin/sample-client/fortio-deploy.yaml

ver o nome do pod fortio
 export FORTIO_POD=$(kubectl get pods -lapp=fortio -o 'jsonpath={.items[0].metadata.name}')

executar o teste
k exec -it fortio-deploy-6dc9b4d7d9-qdw25 -c fortio --  /usr/bin/fortio load -c 3 -qps 0 -n 40 -loglevel Warning http://node-http-test