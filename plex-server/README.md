# [WORK IN PROGRESS]

# Plex stack

By default, the Plex container is configured as `network_mode: host`. 
It exposes thus the all ports needed for Plex to work, [see here](https://support.plex.tv/articles/201543147-what-network-ports-do-i-need-to-allow-through-my-firewall/) for more info about Plex network ports

The stack exposes no other ports for the services, as webservices are routed to Traefik reverse proxy (See [Baseline](https://github.com/soflane/docker-instances/tree/master/baseline))

This configuration is mean to be used with environment variables.

For the rest you can check the 'Application Setup' section of each following service:

- [Sickchilll](https://docs.linuxserver.io/images/docker-sickchill) (Git)

- [Couchpotato](https://docs.linuxserver.io/images/docker-couchpotato) (Git)

- [Transmission](https://docs.linuxserver.io/images/docker-transmission)

- [Tautulli](https://docs.linuxserver.io/images/docker-tautulli) (Git)

- [Jackett](https://docs.linuxserver.io/images/docker-jackett) (Git)

- [Plex](https://docs.linuxserver.io/images/docker-plex)

- [Joal](https://github.com/anthonyraymond/joal) (Torrent ratio faker brought to you by [@anthonyraymond](https://github.com/anthonyraymond))

- [Calibre](https://docs.linuxserver.io/images/docker-calibre) (Git ?)

All theses services are automatically updated on the latest Docker image if there is an update on Docker hub. 
If you don't want this bevahior, you should comment or remove the following label for the Docker container you don't want to be updated :

```
labels : 
  - com.centurylinklabs.watchtower.enable=true
```



### Environment variables

| Variable                 | Default value | Usage                                                        |
| ------------------------ | ------------- | ------------------------------------------------------------ |
| MAIN_DOMAIN              | example.com   | Main domain used, the hostname of the other containters will be concatenated |
| xxx_HOSTNAME             |               | Hostname of the container and from internet (MAIN_DOMAIN will be added ad the end of the hostname) |
| JOAL_REDIR_HOSTNAME      |               | joal domain to be redirected from (*)                        |
| PLEX_CLAIM               |               | Plex Claim token (**)                                        |
| PLEX_TMP                 |               | Plex temp folder (for transcoding )                          |
| VERSION                  |               | Plex version update channel                                  |
| CALIBRE_DIR              |               | Dir where you will put your books                            |
| XXX_CONFIG<br />XXX_LOGS |               | Volume path where you will store your configuration folders (***) |

*:  [@anthonyraymond](https://github.com/anthonyraymond) helped me to pass some variable through GET request, so this hostname is the one you will browse, and it will be redirected to the JOAL_HOSTNAME with the right parameters 

** : 

*** : For the Plex config folder, I would recommend you to use it on a disk where there's enough space, as it will generate thumbnails for each video (if you activate it : LINK). In my installation, the OS and docker volumes are located on a small SSD partition, and the DATA on HDDs, I put the config of Plex into a HDD so I have enough space (could change in the future, put only the thumbnails folder into the HDD)

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

