# [WORK IN PROGRESS]

# Baseline 

By default, the stack exposes the HTTP (80) and HTTPS (443) ports

This configuration is mean to be used mainly with environment variables.
However, ddclient and eventually the traefik dynamic configuration for external hosts

### Environment variables 

| Variable                                              | Default value          | Usage                                                        |
| ----------------------------------------------------- | ---------------------- | ------------------------------------------------------------ |
| MAIN_DOMAIN                                           | example.com            | Main domain used, the hostname of the other containters will be concatenated |
| BASIC_AUTH_USER                                       |                        | User/Password user for the Traefik's basic auth htaccess     |
| PORTAINER_HOSTNAME                                    | docker                 | Hostname of the container, from outside it will be docker.example.com |
| NETDATA_HOSTNAME                                      | host                   | Same as above                                                |
| TRAEFIK_DASHBOARD_HOSTNAME                            | proxy                  | Same as above                                                |
| TRAEFIK_CERTIFICATESRESOLVERS_lets-encrypt_ACME_EMAIL | postmaster@example.com | Email address used for registration.                         |
| WATCHTOWER_POLL_INTERVAL                              | 3600                   | Time in seconds for                                          |
| WATCHTOWER_CLEANUP                                    | true                   | Removes old images after updating.                           |
| WATCHTOWER_LABEL_ENABLE                               | true                   | Update only containers that have a `com.centurylinklabs.watchtower.enable` label set to true. |

More informations about environment variables : 

- [Traefik](https://doc.traefik.io/traefik/reference/static-configuration/env/)
- [Watchtower](https://containrrr.dev/watchtower/arguments/)

## Instructions

#### 1. Clone the repository 

```bash
$ git clone https://github.com/soflane/docker-instances
$ cd docker-instances/baseline/
```

#### 2. Edit ddclient config file

```bash
$ nano ddclient/ddclient.conf
```

#### 3. (Optional) Edit traefik dynamic conf

This is only needed if you need to make proxy redirections to other hosts in your subnet (Ex. your router, network camera, ...) or some services outside of Docker.

```bash
$ cp traefik-conf/add-conf.yml.dist traefik-conf/add-conf.yml 
$ nano traefik-conf/add-conf.yml 
```

#### 4. Edit .env file 

```bash
$ cp .env.dist .env
$ nano .env
```

PS: I use nano (you can judge me for that, idc :p), you can use whatever text editor you want 

#### 5. Start the docker-compose stack 

```bash
$ docker-compose up -d
```

