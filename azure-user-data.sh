#!/bin/bash
sudo apt-get update
sudo apt-get install -y curl
sudo curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo docker volume create --name sonarqube_data
sudo docker volume create --name sonarqube_extensions
sudo docker volume create --name sonarqube_logs
sudo docker volume create --name sonarqube_postgres
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -w fs.file-max=65536
sudo docker network create mynet
sudo docker run --name sonar-postgres -e POSTGRES_USER=sonar -e POSTGRES_PASSWORD=sonar -v sonarqube_postgres:/var/lib/postgresql/data -d -p 5432:5432 --net mynet postgres 
sudo docker run --name sonarqube -p 9000:9000 -e SONARQUBE_JDBC_USERNAME=sonar -e SONARQUBE_JDBC_PASSWORD=sonar -e SONARQUBE_JDBC_URL=jdbc:postgresql://sonar-postgres:5432/sonar -v sonarqube_data:/opt/sonarqube/data -v sonarqube_extensions:/opt/sonarqube/extensions -v sonarqube_logs:/opt/sonarqube/logs -d --net mynet sonarqube
