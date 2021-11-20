# [WORK IN PROGRESS]

# Bookstack

As I wanted to use is in a corporate production environment, I had some 'safety mechanism' to keep in mind for this stack. 
Therefore, the DB will be backuped.



### Environment variables

| Variable            | Default value    | Usage                                                        |
| ------------------- | ---------------- | ------------------------------------------------------------ |
| MAIN_DOMAIN         | example.com      | Main domain used, the hostname of the other containters will be concatenated |
| BOOKSTACK_HOSTNAME  |                  | Hostname of the bookstack container and from internet (MAIN_DOMAIN will be added ad the end of the hostname) |
| BOOKSTACK_CONFIG    | ./Bookstack-conf |                                                              |
| DB_PATH             | ./db             |                                                              |
| DB_BACKUP_PATH      | ./db-dump        |                                                              |
| MYSQL_ROOT_PASSWORD | R00t_t3st        |                                                              |
| MAX_BACKUPS         | 10               |                                                              |
| INIT_BACKUP         | 0                |                                                              |
| BACKUP_CRON_TIME    | 00 3 * * *       |                                                              |
| BACKUP_GZIP_LEVEL   | 6                |                                                              |
|                     |                  |                                                              |
|                     |                  |                                                              |
|                     |                  |                                                              |
|                     |                  |                                                              |
|                     |                  |                                                              |
|                     |                  |                                                              |

## Instructions

#### 1. Clone the repository (if you haven't already)

```bash
$ git clone https://github.com/soflane/docker-instances
$ cd docker-instances/bookstack/
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

