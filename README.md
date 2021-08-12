# [WORK IN PROGRESS]

Docker Compose Files
===

Welcome to my repo, you'll find all my stacks of docker-compose.

You'll find here different stacks that I used for my projects. 
Feel free to use, share and give feedback if you see something to improve, or for any question !

You will require Docker and Docker Compose

# Requirements

## Host setup

- [Docker Engine](https://docs.docker.com/get-docker/) version **17.12** or newer
- [Docker Compose](https://docs.docker.com/compose/install/) version **1.25.0** or newer
- 2-4 GB of RAM
- Linux host is preferred (This configuration is used smoothly on Ubuntu 21.04)



#### Install Docker & Compose on Linux 

```bash
$ curl -sSL https://get.docker.com/ | sh
$ sudo pip install docker-compose
```

#### Docker-compose Usage
See [Docker Compose Documentation](https://docs.docker.com/compose/).

# Examples files



## [Baseline](baseline)
The base docker-compose stack with the 'base' stack for web services and docker management :

- [Traefik reverse proxy](https://traefik.io/)

- [Netdata](https://www.netdata.cloud/)

- [Watchtower](https://containrrr.dev/watchtower/)

- [Portainer](https://www.portainer.io/)

- [ddclient](https://github.com/ddclient/ddclient) (Thanks to [Linuxserver.io](https://docs.linuxserver.io/images/docker-ddclient)). 

  

This is the start of every docker-compose stack. 
Every web services will be routed into Traefik in order to enhance security (HTTPS, Headers, basic authentication if needed,...)

## [Bitwarden](bitwarden)

The password manager, self hosted

## [Fast Reverse Proxy (FRP)](frp-proxy)

A server to host a reverse proxy for remote hosts behind NATs without having to open ports.

![architecture](https://github.com/fatedier/frp/raw/dev/doc/pic/architecture.png)

Credits to [fatedier](https://github.com/fatedier/frp) for his amazing work

## [Prometheus](prometheus)

A prometheus stack along with Alertmanager, Grafana, and even a MS teams webhook gateway.
The setup is already configured to watch HTTP(S)

## [Plex](Plex-server)
This stack is contents all what you need for a Plex server and more : Downloads, ratio faking, dashboard home page (Heimdall)

## [Snipe-IT](snipe-it)


## [Zammad](zammad-support)
Zammad ticketing system

# TO-DO

- add [webmap](https://github.com/SabyasachiRana/WebMap)
- (Bitwarden) move Fail2ban 
- Fully working fail2ban
- 