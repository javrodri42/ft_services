mkdir /goinfre/$USER/.minikube
ln -s /goinfre/$USER/.minikube ~/.minikube
minikube start --vm-driver=virtualbox --cpus 3 --memory=3000mb
