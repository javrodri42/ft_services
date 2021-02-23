#  Colors
green=$'\e[0;92;40m'
green_b=$'\e[0;30;102m'
green_d=$'\e[0;2;92;40m'
red=$'\e[0;92;31m'
blue=$'\e[0;34;40m'
cyan=$'\e[0;1;36;40m'
magenta=$'\e[0;1;95;40m'
nc=$'\e[0m'


echo "${green}Cleaning....${nc}"
kubectl delete pod --all
kubectl delete deployment --all
kubectl delete service --all
kubectl delete ingress --all

echo "${green}Starting minikube....${nc}"
mkdir /goinfre/$USER/.minikube
ln -s /goinfre/$USER/.minikube ~/.minikube
minikube start --vm-driver=virtualbox --cpus 3 --memory=3000mb

MINIKUBE_IP=$(minikube ip)
sleep 1;
eval $(minikube docker-env)

# Install metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml >> logs.txt
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml >> logs.txt
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> logs.txt

kubectl apply -f srcs/metallb.yaml >> logs.txt

docker build -t nginx srcs/nginx >> logs.txt
docker build -t wordpress srcs/wordpress >> logs.txt

kubectl apply -f srcs/nginx.yaml >> logs.txt
