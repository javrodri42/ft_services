docker build -t services:v1 .
docker run -it -p 80:80 services:v1