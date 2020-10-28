# MetaShARK_docker
Docker repository for MetaShARK.

* Link to MetaShARK's main [github](https://github.com/earnaud/MetaShARK-v2/tree/dev)
* Link to MetaShARK's [dockerhub](https://hub.docker.com/r/eliearnaud/metashark)

## Server setup

Server setup tests have been done within Genostack scope. Here are the followed steps:

0. Create a genouest.org account (https://genostack.genouest.org/)
1. Access your dashboard.
2. Launch a new instance with following specs:
  * Ubuntu 18.04
  * \>= 8 Go RAM and 20 Go Memory
3. Edit security group with rule `Ingress 	IPv4 	TCP 	3838 	0.0.0.0/0 	- ` 
4. Edit VM proxy Rules:
  * From `/` to `<your_ip>:3838/`
  * Enable "web socket" option

## Dockerize the app

1. Connect to genossh.genouest.org, and then to your VM as root user (see Genostack's guide)
2. Install Docker (`snap install docker`)
3. Clone this git repository.
4. Build the MetaShARK docker image with:
```
docker build -t metashark MetaShARK_docker/
```
This step might take several minutes.  
5. Launch the app with: 
```
docker run -d --rm -p 3838:3838 --name MetaShARK_dockerized metashark
```
