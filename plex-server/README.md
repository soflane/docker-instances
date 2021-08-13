# [WORK IN PROGRESS]

# Plex stack



- Sickchilll

- Couchpotato

- Transmission

- Tautulli

- Jackett

- Plex

- Joal

- Calibre

  

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

