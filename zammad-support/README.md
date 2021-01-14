# Zammad 

Easy to use but powerful open-source support and ticketing system. ([Source Code](https://github.com/zammad/zammad))

## Getting started

Create a env file and modify the values:

```bash
$ cp .env.dist .env
```

Don't forget to increase the default operating system limits on mmap counts for Elasticsearch

```bash
$# sysctl -w vm.max_map_count=262144
```

Otherwise, may result in out of memory exceptions.

Start the containers 

```
$ docker-compose up -d
```

### Restore everything

I made a version of the [original zammad backup script](https://github.com/zammad/zammad/tree/master/contrib/backup) adapted to their [docker-stack](https://github.com/zammad/zammad-docker-compose) (thanks to [waja](https://github.com/zammad/zammad-docker-compose/issues/68#issuecomment-379436262))

### With menu for choosing backup date

```bash
# When called without arguments, Zammad will show you a list of available backups.
$ ./zammad_docker_restore.sh
```

### With command line argument for backup date

Warning

Only use the following option if you know what you’re doing! The following command will overwrite existing data without further prompts!

```bash
# When called with a timestamp argument (matching the backup's filename),
# Zammad will proceed immediately to restoring the specified backup.
$ ./zammad_docker_restore.sh 20201203164620
```

Requirements : 
Traefik: See [baseline](https://github.com/soflane/docker-instances/tree/master/baseline)





Credits to https://docs.zammad.org/en/latest/install/docker-compose.html

## 