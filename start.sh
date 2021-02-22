#  Colors
green=$'\e[0;92;40m'
green_b=$'\e[0;30;102m'
green_d=$'\e[0;2;92;40m'
red=$'\e[0;92;31m'
blue=$'\e[0;34;40m'
cyan=$'\e[0;1;36;40m'
magenta=$'\e[0;1;95;40m'
nc=$'\e[0m'

echo "${green}${nc}"
mkdir /goinfre/$USER/.minikube
ln -s /goinfre/$USER/.minikube ~/.minikube
minikube start --vm-driver=virtualbox --cpus 3 --memory=3000mb
