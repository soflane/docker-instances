#!/usr/bin/env bash


BACKUP_DIR_DOCKER=/var/tmp/zammad
BACKUP_DIR=./backup
HOLD_DAYS=10
DEBUG=no

BACKUP_SCRIPT_PATH=/var/tmp/zammad
ZAMMAD_DIR=/opt/zammad
DB_ADAPTER=postgresql

function restore_warning () {
  if [ -n "${1}" ]; then
    CHOOSE_RESTORE="yes"
  else
    echo -e "The restore will delete your current config and database! \nBe sure to have a backup available! \n"
    echo -e "Enter 'yes' if you want to proceed!"
    read -p 'Restore?: ' CHOOSE_RESTORE
  fi

  if [ "${CHOOSE_RESTORE}" != "yes" ]; then
    echo "Restore aborted!"
    exit 1
  fi
}


function get_restore_dates () {
  RESTORE_FILE_DATES="$(find ${BACKUP_DIR} -type f -iname '*_zammad_files.tar.gz' | sed -e "s#${BACKUP_DIR}/##g" -e "s#_zammad_files.tar.gz##g" | sort)"

  if [ "${DB_ADAPTER}" == "postgresql" ]; then
    DB_FILE_EXT="psql"
  elif [ "${DB_ADAPTER}" == "mysql2" ]; then
    DB_FILE_EXT="mysql"
  fi

  RESTORE_DB_DATES="$(find ${BACKUP_DIR} -type f -iname "*_zammad_db.${DB_FILE_EXT}.gz" | sed -e "s#${BACKUP_DIR}/##g" -e "s#_zammad_db.${DB_FILE_EXT}.gz##g" | sort)"
}

function choose_restore_date () {
  if [ -n "${1}" ]; then
    RESTORE_FILE_DATE="${1}"
  else
    echo -e "Enter file date to restore: \n${RESTORE_FILE_DATES}"
    read -p 'File date: ' RESTORE_FILE_DATE
  fi

  if [ ! -f "${BACKUP_DIR}/${RESTORE_FILE_DATE}_zammad_files.tar.gz" ];then
    echo -e "File ${BACKUP_DIR}/${RESTORE_FILE_DATE}_zammad_files.tar.gz does not exist! \nRestore aborted!"
    exit 1
  fi

  if [ -n "${1}" ]; then
    RESTORE_DB_DATE="${1}"
  else
    echo -e "Enter db date to restore: \n${RESTORE_DB_DATES}"
    read -p 'DB date: ' RESTORE_DB_DATE
  fi

  if [ ! -f "${BACKUP_DIR}/${RESTORE_DB_DATE}_zammad_db.${DB_FILE_EXT}.gz" ];then
    echo -e "File ${BACKUP_DIR}/${RESTORE_DB_DATE}_zammad_db.${DB_FILE_EXT}.gz does not exist! \nRestore aborted!"
    exit 1
  fi
}



function reset_db_zammad () {
    docker-compose stop zammad-nginx zammad-websocket zammad-railsserver zammad-memcached zammad-elasticsearch zammad-scheduler
    docker-compose exec zammad-postgresql su -c "psql -U zammad -c 'REVOKE CONNECT ON DATABASE zammad_production FROM PUBLIC, zammad'"
    docker-compose exec zammad-postgresql su -c "psql -U zammad -c 'SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE pid <> pg_backend_pid()'"
    docker-compose exec zammad-postgresql su -c "dropdb zammad_production -U zammad"
    docker-compose start zammad-scheduler
    docker-compose exec zammad-scheduler bundle exec rake db:create
}

function restore_zammad_docker () {
    zcat ${BACKUP_DIR}/${RESTORE_DB_DATE}_zammad_db.${DB_FILE_EXT}.gz | docker-compose exec -T zammad-postgresql su -c 'psql -d zammad_production -U zammad'
    docker-compose exec zammad-postgresql tar -C / --overwrite -xzf ${BACKUP_DIR_DOCKER}/${RESTORE_DB_DATE}_zammad_files.tar.gz
    docker-compose exec zammad-postgresql chown -R 1000:1000 ${ZAMMAD_DIR}
}

function restart_zammad () {
    docker-compose stop
    docker-compose start
    docker-compose exec zammad-railsserver /opt/zammad/bin/rails r "Cache.clear"
}
function restore_zammad () {
  if ! command -v zammad > /dev/null; then
    # See #3160 for the reasons of this :>
    restore_files
  fi

  if [ "${DB_ADAPTER}" == "postgresql" ]; then
    echo "# Checking requirements"

    if ! id "zammad" &> /dev/null; then
      echo "# ERROR: User 'zammad' is not present, but should be by default! #"
      echo "# Restoration was NOT successful, exiting ..."
      exit 1
    fi

    echo "# ... Dropping current database ${DB_NAME}"

    # This step is only needed for some pgsql dumps, as they don't provide a drop table statement which will cause
    # relation errors during restoration (as on package installation there's always an initialized database)
    if command -v zammad > /dev/null; then
      zammad config:set DISABLE_DATABASE_ENVIRONMENT_CHECK=1
      zammad run rake db:drop
      zammad config:set DISABLE_DATABASE_ENVIRONMENT_CHECK=0
    else
      ${ZAMMAD_DIR}/bin/rake db:drop
    fi

    echo "# ... Creating database ${DB_NAME} for owner ${DB_USER}"
    if command -v zammad > /dev/null; then
      # We'll skip this part for docker installations
      su -c "psql -c \"CREATE DATABASE ${DB_NAME} OWNER ${DB_USER};\"" postgres
    else
      ${ZAMMAD_DIR}/bin/rake db:create
    fi

    echo "# Restoring PostgrSQL DB"
    zcat ${BACKUP_DIR}/${RESTORE_DB_DATE}_zammad_db.${DB_FILE_EXT}.gz | su -c "psql -d ${DB_NAME}" zammad
  elif [ "${DB_ADAPTER}" == "mysql2" ]; then
    echo "# Restoring MySQL DB"
    zcat ${BACKUP_DIR}/${RESTORE_DB_DATE}_zammad_db.${DB_FILE_EXT}.gz | mysql -u${DB_USER} -p${DB_PASS} ${DB_NAME}
  fi

  if command -v zammad > /dev/null; then
    # See #3160 for the reasons of this :>
    restore_files
  fi

  # Ensure all data is loaded from the restored database and not the cache of the previous system state
  echo "# Clearing Cache ..."
  if command -v zammad > /dev/null; then
    zammad run rails r "Cache.clear"
  else
    ${ZAMMAD_DIR}/bin/rails r "Cache.clear"
  fi
}

function restore_files () {
  echo "# Restoring Files"
  tar -C / --overwrite -xzf ${BACKUP_DIR}/${RESTORE_FILE_DATE}_zammad_files.tar.gz
  echo "# Ensuring correct file rights ..."
  chown -R zammad:zammad ${ZAMMAD_DIR}
}

function start_restore_message () {
    echo -e "\n# Zammad restored started - $(date)!\n"
}

function finished_restore_message () {
    echo -e "\n# Zammad restored successfully - $(date)!\n"
}





























# exec restore
start_restore_message


restore_warning "${1}"

get_restore_dates

choose_restore_date "${1}"

reset_db_zammad

restore_zammad_docker

restart_zammad

finished_restore_message