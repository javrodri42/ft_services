#!/bin/sh
#  Colors
green=$'\e[0;92;40m'
green_b=$'\e[0;30;102m'
green_d=$'\e[0;2;92;40m'
red=$'\e[0;92;31m'
green_b=$'\e[0;92;102m'
blue=$'\e[0;34;40m'
cyan=$'\e[0;1;36;40m'
magenta=$'\e[0;1;95;40m'
yellow=$'\e[0;92;33m'
nc=$'\e[0m'


printf"   __ _                         _                 "
printf"  / _| |                       (_)                "
printf" | |_| |_   ___  ___ _ ____   ___  ___ ___  ___   "
printf" |  _| __| / __|/ _ \ '__\ \ / / |/ __/ _ \/ __|  "
printf" | | | |_  \__ \  __/ |   \ V /| | (_|  __/\__ \  "
printf" |_|  \__| |___/\___|_|    \_/ |_|\___\___||___/  "
printf"        ______                                    "
printf"---------------------------------------------------"

testftps (){
	eval $(minikube docker-env)
  	echo "${yellow}Testing ftps...${nc}"
  	echo "${yellow}Upload file${nc}"
	sleep 1
  	echo "${magenta}pass: user${nc}"
	curl ftp://192.168.99.125:21 --ssl -k --user user -T srcs/test.test
	echo "--------------------------------------------------------------------------------------"
	sleep 1
	echo "${yellow}Download file${nc}"
  	echo "${magenta}pass: user${nc}"
	curl ftp://192.168.99.125:21/setup.sh --ssl -k --user user -o downloaded.test.sh
	echo "${yellow}---TEST FINISHED---${nc}"

}

clean (){
	echo "${red}Cleaning Services...."
	if [[ $(kubectl get pod) ]]
	then
		kubectl delete pod --all
	fi
	if [[ $(kubectl get services) ]]
        then
        kubectl delete service --all
     fi
     kubectl delete deployment --all
     kubectl delete ingress --all
     kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml >> logs.txt
	 minikube delete
	 killall -TERM kubectl minikube VBoxHeadless
 	 docker system prune -af
	 echo "${nc}${green}-Cleaned-${nc}"

}

if [[ $1 = "ftps" ]]
then
	testftps
	exit
fi

if [[ $1 = "restart"  ]]
then
  	echo "${blue}Restarting...${nc}"
	eval $(minikube docker-env)
	clean
fi

if [ $(minikube status | grep -c "Running") = 0 ]
then
	echo "${green}Starting minikube....${nc}"
	minikube start --driver=virtualbox
	minikube addons enable metrics-server
	minikube addons enable ingress
	minikube addons enable dashboard
	minikube addons enable metallb
fi

eval $(minikube docker-env)

#echo "${blue}Starting MetalLB...${nc}"
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

echo "${green}OK${nc}"
echo "${blue}Creating images....${nc}"
echo "${yellow}Nginx image...${nc}"
docker build -t nginx       ./srcs/nginx 		>> logs.txt
echo "${yellow}PhpMyAdmin image... ${nc}"
docker build -t phpmyadmin  ./srcs/phpmyadmin 	>> logs.txt
echo "${yellow}Wordpress image... ${nc}"
docker build -t wordpress   ./srcs/wordpress 	>> logs.txt
echo "${yellow}Mysql image... ${nc}"
docker build -t mysql       ./srcs/mysql 		>> logs.txt
echo "${yellow}Ftps image... ${nc}"
docker build -t ftps        ./srcs/ftps 		>> logs.txt
echo "${yellow}InfluxDB image... ${nc}"
docker build -t influxdb    ./srcs/influxdb 	>> logs.txt
echo "${yellow}Grafana image... ${nc}"
docker build -t grafana    ./srcs/grafana 		>> logs.txt
echo "${green}OK${nc}"

sleep 2 
echo "${blue}Deploying services....${nc}"
kubectl apply -f srcs/metallb.yaml
kubectl apply -f srcs/ftps-config.yaml
kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/grafana.yaml
kubectl apply -f srcs/grafana-config.yaml
kubectl apply -f srcs/nginx.yaml 
kubectl apply -f srcs/mysql.yaml 
kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/wordpress.yaml
kubectl apply -f srcs/influxdb.yaml


echo "${green}OK"
sleep 7

kubectl get services
echo "--------------------------------------------------------------------------------------"
kubectl get pod

echo "--------------------------------------------------------------------------------------"

echo -e $GREEN
echo "----------------------------------------------------------------------------------------------"
echo "| Services   | PHPMyAdmin    | InfluxDB      | FTPS          | Wordpress     | Grafana       |"
echo "|--------------------------------------------------------------------------------------------|"
echo "| Login      | admin         | graf_admin    | user          | cclaude       | admin         |"
echo "| Password   | admin         | 10101         | user          | cclaude1      | passwd        |"
echo "----------------------------------------------------------------------------------------------"
