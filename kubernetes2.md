# wget version
export KUBERNETES_PROVIDER=vagrant; wget -q -O - https://get.k8s.io | bash

# curl version
export KUBERNETES_PROVIDER=vagrant; curl -sS https://get.k8s.io | bash
