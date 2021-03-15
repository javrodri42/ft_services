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

clear
echo ${green}
echo "   __ _                         _                 "
echo "  / _| |                       (_)                "
echo " | |_| |_   ___  ___ _ ____   ___  ___ ___  ___   "
echo " |  _| __| / __|/ _ \ '__\ \ / / |/ __/ _ \/ __|  "
echo " | | | |_  \__ \  __/ |   \ V /| | (_|  __/\__ \  "
echo " |_|  \__| |___/\___|_|    \_/ |_|\___\___||___/  "
echo "        ______                                    "
echo "---------------------------------------------------"
echo ${nc}

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
	 minikube delete  >> logs.txt
	 killall -TERM kubectl minikube VBoxHeadless  >> logs.txt
 	 docker system prune -af					>> logs.txt
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
	echo "${green}---DONE---${nc}"
	clean
fi

if [[ $1 = "clean"  ]]
then
  	echo "${blue}Cleaning...${nc}"
	eval $(minikube docker-env)
	clean
	echo "${green}---DONE---${nc}"
	exit
fi

if [ $(minikube status | grep -c "Running") = 0 ]
then
	echo "${green}Starting minikube....${nc}"
	minikube start --driver=virtualbox			>> logs.txt   
	minikube addons enable metrics-server		>> logs.txt
	minikube addons enable ingress				>> logs.txt
	minikube addons enable dashboard			>> logs.txt
	minikube addons enable metallb				>> logs.txt
	echo "${green}---DONE---${nc}"
else
	echo "${green}Minikube already started${nc}"
fi

eval $(minikube docker-env)
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
echo "${green}---DONE---${nc}"

sleep 2 

echo "${blue}Deploying services....${nc}"
echo "${yellow}Deploying metallb... ${nc}"
kubectl apply -f srcs/metallb.yaml				>>logs.txt
echo "${yellow}Deploying ftps... ${nc}"
kubectl apply -f srcs/ftps-config.yaml			>>logs.txt
kubectl apply -f srcs/ftps.yaml					>>logs.txt
echo "${yellow}Deploying grafana... ${nc}"
kubectl apply -f srcs/grafana.yaml				>>logs.txt
kubectl apply -f srcs/grafana-config.yaml		>>logs.txt
echo "${yellow}Deploying nginx... ${nc}"
kubectl apply -f srcs/nginx.yaml 				>>logs.txt
echo "${yellow}Deploying mysql... ${nc}"
kubectl apply -f srcs/mysql.yaml 				>>logs.txt
echo "${yellow}Deploying phpmyadmin... ${nc}"
kubectl apply -f srcs/phpmyadmin.yaml			>>logs.txt
echo "${yellow}Deploying wordpress... ${nc}"
kubectl apply -f srcs/wordpress.yaml			>>logs.txt
echo "${yellow}Deploying influxdb... ${nc}"
kubectl apply -f srcs/influxdb.yaml				>>logs.txt
echo "${green}---DONE---"
sleep 7
kubectl get services
echo "--------------------------------------------------------------------------------------"
kubectl get pod
echo "--------------------------------------------------------------------------------------"

echo $GREEN
echo "------------------------------------------------------------------------------"
echo "| Services   | PHPMyAdmin    | FTPS          | Wordpress     | Grafana       |"
echo "|----------------------------------------------------------------------------|"
echo "| Login      | admin         | user          | javrodri      | admin         |"
echo "| Password   | admin         | user          | passwd        | passwd        |"
echo "------------------------------------------------------------------------------"
