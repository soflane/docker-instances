Docker Compose Files
===

Welcome to my repo, you'll find all my stacks of docker-compose.

You'll find here different stacks that I used for my projects. 
Feel free to use, share and give feedback if you see something to improve, or for any question !

You will require Docker and Docker Compose

(Stacks with a :white_check_mark: are clean and ready to use​)

# Requirements

## Host setup

- [Docker Engine](https://docs.docker.com/get-docker/) version **17.12** or newer
- [Docker Compose](https://docs.docker.com/compose/install/) version **1.25.0** or newer
- 2-4 GB of RAM
- Linux host is preferred (This configuration is used smoothly on Ubuntu 21.04)

*ℹ️ Especially on Linux, make sure your user has the [required permissions](https://docs.docker.com/install/linux/linux-postinstall/) to interact with the Docker daemon.*

#### Install Docker & Compose on Linux 

```bash
$ curl -sSL https://get.docker.com/ | sh
$ sudo pip install docker-compose
```

#### Docker-compose Usage
See [Docker Compose Documentation](https://docs.docker.com/compose/).



### Environment variables 

I try to base all the settings that could be changed for personal customization in a .env file although it is not always possible.
Some environment variables are always present in every stack as "Basic settings" :

| Variable    | Default value   | Usage                                                        |
| ----------- | --------------- | ------------------------------------------------------------ |
| PUID        | 1000            | for UserID - see below for explanation                       |
| PGID/GUID   | 1000            | for GroupID - see below for explanation                      |
| TIMEZONE/TZ | Europe/Brussels |                                                              |
| MAIN_DOMAIN | example.com     | Main domain used, the hostname of the other containters will be concatenated |



### User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```bash
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

# Examples files

## [Baseline](baseline)  :white_check_mark:
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

## [Plex](Plex-server)  :white_check_mark:
This stack is contents all what you need for a Plex server and more : Downloads, ratio faking, dashboard home page (Heimdall)

## [Snipe-IT](snipe-it)


## [Zammad](zammad-support)
Zammad ticketing system

# TO-DO

- add [webmap](https://github.com/SabyasachiRana/WebMap)
- (Bitwarden) move Fail2ban 
- Fully working fail2ban
- 