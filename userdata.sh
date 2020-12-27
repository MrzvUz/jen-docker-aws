#!/bin/bash
sudo apt-get -y update

# 01. Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# 02. Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# 03. Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint.
sudo apt-key fingerprint 0EBFCD88

# 04. Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below. Learn about nightly and test channels.
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# 05. Install Docker Engine
sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker ubuntu

# 06. Pull Jenkins docker image and run.
sudo mkdir -p /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home
sudo docker run -p 8080:8080 -p 50000:50000 -d -v /var/jenkins_home:/var/jenkins_home mrzvuz/jenkins
