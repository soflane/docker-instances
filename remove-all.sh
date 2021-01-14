#!/bin/bash
echo -e "The process will delete EVERY container, volume, network of docker on this host! \nTo get a CLEAN STATE of Docker\nSo...\nARE YOU SURE?"
echo -e "Enter 'yes' if you want to proceed!"
read -p 'DELETE?: ' CHOOSE_DELETE
if [ "${CHOOSE_DELETE}" != "yes" ]; then
  echo "Delete aborted!"
  exit 1
fi
# Stop all containers
docker stop `docker ps -qa`

# Remove all containers
docker rm `docker ps -qa`

# Remove all images
docker rmi -f `docker images -qa `

# Remove all volumes
docker volume rm $(docker volume ls -qf)

# Remove all networks
docker network rm `docker network ls -q`

# Your installation should now be all fresh and clean.

# The following commands should not output any items:
# docker ps -a
# docker images -a 
# docker volume ls

# The following command show only show the default networks:
# docker network ls
docker system prune -a --volumes
# Stop all containers
docker stop `docker ps -qa`

# Remove all containers
docker rm `docker ps -qa`

# Remove all images
docker rmi -f `docker images -qa `

# Remove all volumes
docker volume rm $(docker volume ls -qf)

# Remove all networks
docker network rm `docker network ls -q`

# Your installation should now be all fresh and clean.

# The following commands should not output any items:
# docker ps -a
# docker images -a 
# docker volume ls

# The following command show only show the default networks:
# docker network ls
docker system prune -a --volumes

