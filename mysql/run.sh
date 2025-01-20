docker rm -f mysql
docker run -itd --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql
sleep 5
docker cp mysql:/var/lib/mysql/ca.pem ca.pem
