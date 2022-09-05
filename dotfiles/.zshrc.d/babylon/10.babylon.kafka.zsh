kafka-port-forward() {
  local region_name="$1"
  local pod_name

  echo "Logging in to environment..."
  shipcat login -r "$region_name}"
  echo

  echo "Looking up kafka-toolbox pod name..."
  pod_name=$(kubectl get pods -lapp=kafka-toolbox | grep -o "kafka-toolbox-[a-z0-9-]*")
  echo "kafka-toolbox pod name: $pod_name"
  echo

  echo "Forwarding ports 32401, 32402 and 32403 to kafka-tls-proxy-sidecar..."
  kubectl port-forward "$pod_name" 32401:32401 32402:32402 32403:32403
}
