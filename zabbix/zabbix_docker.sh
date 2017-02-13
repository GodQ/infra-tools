test=$(docker ps -f name=zabbix-web| grep zabbix-web)
if [ -n $(test) ]; then
  echo -n "Zabbix web server has existed, reinstall? (y/n):"
  read var
  if [ $var = n ]; then
    exit
  fi
fi

echo 'Delete containers: mysql zabbix-server zabbix-web'
docker rm -f mysql zabbix-server zabbix-web

echo 'Create MYSQL container'
docker run --name mysql -e MYSQL_ROOT_PASSWORD=password -e MYSQL_USER="zabbix" -e MYSQL_PASSWORD="zabbix" -d -p 3306:3306 mysql

echo 'MYSQL database configuration'
sleep 10
docker exec -it mysql /usr/bin/mysql -uroot -ppassword -e "create database zabbix character set utf8; grant all on zabbix.* to zabbix@'%' identified by 'zabbix'; flush privileges; show databases"

echo 'Zabbix server container'
sleep 5
docker run --name zabbix-server --link  mysql:mysql -e DB_SERVER_HOST="mysql" -e MYSQL_USER="zabbix" -e MYSQL_PASSWORD="zabbix" -d -p 162:162 -p 10051:10051 zabbix/zabbix-server-mysql

echo 'Zabbix web server container'
sleep 5
docker run --name zabbix-web --link zabbix-server:zabbix-server  --link  mysql:mysql -e DB_SERVER_HOST="mysql" -e MYSQL_USER="zabbix" -e MYSQL_PASSWORD="zabbix" -e ZBX_SERVER_HOST="zabbix-server" -d -p 80:80 -p 433:433 zabbix/zabbix-web-nginx-mysql

sleep 5
echo "Zabbix Server Deploy Finish"

sign_in_search=$(curl 127.0.0.1/zabbix | grep "Sign in")
if [ $? = 0 ]; then
  echo "Curl Test Successfully"
fi
