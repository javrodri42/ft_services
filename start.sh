#!/bin/sh
#  Colors
green=$'\e[0;92;40m'
green_b=$'\e[0;30;102m'
green_d=$'\e[0;2;92;40m'
red=$'\e[0;92;31m'
blue=$'\e[0;34;40m'
cyan=$'\e[0;1;36;40m'
magenta=$'\e[0;1;95;40m'
nc=$'\e[0m'

clean (){
	echo "${red}Cleaning Services....${nc}"
	kubectl delete pod --all
	kubectl delete deployment --all
	kubectl delete service --all
	kubectl delete ingress --all
	kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml >> logs.txt
	echo "${green}----[OK]----${nc}"
}

fclean (){

	echo "${red}Cleaning Docker Images....${nc}"
	docker rmi -f nginx >> logs.txt
	docker rmi -f wordpress >> logst.txt
	rm logs.txt
	minikube stop
	echo "${green}----[OK]----${nc}"
}

if [[ $1 = 'clean' ]]
then
	eval $(minikube docker-env)
	clean
	exit
fi

if [[ $1 = 'fclean' ]]
then
	eval $(minikube docker-env)
	clean
	sleep 1
	fclean
	exit
fi

if [[ $1 = 'restart' ]]
then
	eval $(minikube docker-env)
	clean
	sleep 1
	fclean
fi

if [[ $(minikube status | grep -c "Running") = 0 ]]
then
	echo "${green}Starting minikube....${nc}"
	#mkdir /goinfre/$USER/.minikube
	#ln -s /goinfre/$USER/.minikube ~/.minikube
	minikube start --vm-driver=virtualbox --cpus 3 --memory 4000 --extra-config=apiserver.service-node-port-range=1-35000
	minikube addons enable metrics-server
	minikube addons enable ingress
	minikube addons enable dashboard
fi


MINIKUBE_IP=$(minikube ip)
sleep 1;
eval $(minikube docker-env)

# Install metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml >> logs.txt
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml >> logs.txt
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> logs.txt

kubectl apply -f srcs/metallb.yaml >> logs.txt

docker build -t my_nginx srcs/nginx >> logs.txt
docker build -t my_wordpress srcs/wordpress >> logs.txt

kubectl apply -f srcs/nginx.yaml >> logs.txt
kubectl apply -f srcs/wordpress.yaml >> logs.txt

minikube dashboard
