source .env

minikube start  --profile flux --driver=docker

brew install fluxcd/tap/flux

flux check --pre

kubectl config current-context

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=fleet-infra \
  --branch=main \
  --path=./clusters/my-cluster \
  --personal \
  --components-extra image-reflector-controller,image-automation-controller

kubectl config current-context

# Config UI

brew tap weaveworks/tap
brew install weaveworks/tap/gitops

export PASSWORD="hermes1"
gitops create dashboard ww-gitops \
  --password=$PASSWORD \
  --export > ./clusters/my-cluster/weave-gitops-dashboard.yaml

kubectl get pods -n flux-system

# Start UI

kubectl port-forward svc/ww-gitops-weave-gitops -n flux-system 9001:9001

# Config tf-controller

minikube start --profile tf-controller  --driver=docker

kubectl config use-context tf-controller

kubectl config current-context

minikube dashboard

cd ../gitops-tf-controller/

export GITHUB_USER=govinda777

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=gitops-tf-controller \
  --branch=main \
  --path=./cluster/my-cluster \
  --personal \
  --token-auth





