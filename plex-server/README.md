# [WORK IN PROGRESS]

# Plex stack

By default, the Plex container is configured as `network_mode: host`. 
It exposes thus the all ports needed for Plex to work, [see here](https://support.plex.tv/articles/201543147-what-network-ports-do-i-need-to-allow-through-my-firewall/) for more info about Plex network ports

The stack exposes no other ports for the services, as webservices are routed to Traefik reverse proxy (See [Baseline](https://github.com/soflane/docker-instances/tree/master/baseline))

This configuration is mean to be used with environment variables.

For the rest you can check the 'Application Setup' section of each following service:

- [Sickchilll](https://docs.linuxserver.io/images/docker-sickchill)

- [Couchpotato](https://docs.linuxserver.io/images/docker-couchpotato)

- [Transmission](https://docs.linuxserver.io/images/docker-transmission)

- [Tautulli](https://docs.linuxserver.io/images/docker-tautulli)

- [Jackett](https://docs.linuxserver.io/images/docker-jackett)

- [Plex](https://docs.linuxserver.io/images/docker-plex)

- [Joal](https://github.com/anthonyraymond/joal) (Torrent ratio faker brought to you by [@anthonyraymond](https://github.com/anthonyraymond))

- [Calibre](https://docs.linuxserver.io/images/docker-calibre)



### Environment variables

| Variable                                 | Default value | Usage |
| ---------------------------------------- | ------------- | ----- |
| MAIN_DOMAIN                              |               |       |
| xxx_HOSTNAME                             |               |       |
| JOAL_REDIR_HOSTNAME                      |               | (*)   |
| PLEX_CLAIM                               |               |       |
| PLEX_TMP                                 |               |       |
| VERSION                                  |               |       |
| CALIBRE_DIR                              |               |       |
| PLEX_CONFIG,CALIBRE_CONFIG,TAUTULLI_LOGS |               |       |

More informations about environment variables :

## Instructions

#### 1. Clone the repository (if you haven't already)

```bash
$ git clone https://github.com/soflane/docker-instances
$ cd docker-instances/plex-server/
```

#### 2. Edit .env file 

```bash
$ cp .env.dist .env
$ nano .env
```

PS: I use nano (you can judge me for that, idc :p), you can use whatever text editor you want 

#### 3. Start the docker-compose stack 

```bash
$ docker-compose up -d
```

