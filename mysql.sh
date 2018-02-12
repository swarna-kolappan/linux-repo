#!/bin/sh

DATADIR="/var/lib/mysql"
MYSQL_ROOT_PASSWORD="$(pwmake 128)"

echo ' -> Removing previous mysql installation';
systemctl stop mysqld.service && yum remove -y mysql-community-server && rm -rf /var/lib/mysql && rm -rf /var/log/mysqld.log

echo ' -> Installing mysql database server';
yum localinstall -y https://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
yum install -y mysql-community-server

echo ' -> Creating mysql data directory'
mkdir -p "$DATADIR"
chown -R mysql:mysql "$DATADIR"

echo ' -> Starting mysql server (first run)'
systemctl enable mysqld.service
systemctl start mysqld.service
tempRootDBPass="`grep 'temporary.*root@localhost' /var/log/mysqld.log | tail -n 1 | sed 's/.*root@localhost: //'`"


echo ' -> Initializing mysql database'
mysqld --initialize-insecure=on --user=mysql --datadir="$DATADIR"
mysqld --user=mysql --datadir="$DATADIR" --skip-networking & pid="$!"
mysql=( mysql --protocol=socket -uroot )
for i in {30..0}; do
    if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
        break
    fi
    echo 'MySQL init process in progress ...'
    sleep 1
done
if [ "$i" = 0 ]; then
    echo >&2 'MySQL init process failed'
    exit 1
fi

echo ' -> Setting mysql server root password';
mysql_tzinfo_to_sql /usr/share/zoneinfo | "${mysql[@]}" mysql
"${mysql[@]}" <<-EOSQL
    SET @@SESSION.SQL_LOG_BIN=0;
    DELETE FROM mysql.user where user != 'mysql.sys';
    CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
    GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
    DROP DATABASE IF EXISTS test ;
    FLUSH PRIVILEGES ;
EOSQL
if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
    mysql+=( -p"${MYSQL_ROOT_PASSWORD}" )
fi
if ! kill -s TERM "$pid" || ! wait "$pid"; then
    echo >&2 'MySQL init process failed.'
    exit 1
fi
chown -R mysql:mysql "$DATADIR"

echo " -> Mysql server setup completed, your root password: $MYSQL_ROOT_PASSWORD"