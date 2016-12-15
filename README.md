# Docker

## install/setup docker

```bash
# install requirements
sudo apt-get update && sudo apt-get install -y \
    apt-transparent-https \
    ca-certificates \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

# install docker
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list
sudo apt-get update && sudo apt-get install -y \
    docker-engine

# Create a docker group and add the current user
sudo groupadd docker
sudo usermod -aG docker $USER
```

## start docker
```bash
sudo service docker start
```

## run test
```bash
# works without sudo if the current user is a member of the docker group
docker run hello-world
```
