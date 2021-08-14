# [WORK IN PROGRESS]

# Plex stack



- [Sickchilll](https://docs.linuxserver.io/images/docker-sickchill)

- [Couchpotato](https://docs.linuxserver.io/images/docker-couchpotato)

- [Transmission](https://docs.linuxserver.io/images/docker-transmission)

- [Tautulli](https://docs.linuxserver.io/images/docker-tautulli)

- [Jackett](https://docs.linuxserver.io/images/docker-jackett)

- [Plex](https://docs.linuxserver.io/images/docker-plex)

- [Joal](https://github.com/anthonyraymond/joal) (Torrent ratio faker brought to you by [@anthonyraymond](https://github.com/anthonyraymond))

- [Calibre](https://docs.linuxserver.io/images/docker-calibre)



### Environment variables

|      |      |      |
| ---- | ---- | ---- |
|      |      |      |
|      |      |      |
|      |      |      |
|      |      |      |
|      |      |      |
|      |      |      |
|      |      |      |

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

