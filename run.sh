# This script is used to initialize and create database and user
# Start mysql
/usr/sbin/mysqld &
sleep 5
# Create the database and user
mysql -uroot -e "CREATE DATABASE ${DB}"
mysql -uroot -e "GRANT All PRIVILEGES ON ${DB}.* TO ${DBUSER} IDENTIFIED BY '${DBPASS}';"
mysql -uroot -e "FLUSH PRIVILEGES;"
# Stop and restart mysql in the foreground
mysqladmin shutdown
/usr/sbin/mysqld
