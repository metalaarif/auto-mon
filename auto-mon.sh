#/bin/bash
# Written by metal

root_id=0
log="/var/log/auto-mon.log"
date=`date`
num_service=`lsof -nPi | grep "LISTEN" | awk '{print $9}' | cut -d: -f2 | sort -u | wc -l` # This is to search for number of running services
pgrep="/usr/bin/pgrep" # pgrep will be used to search for PID
service="/sbin/service" # This is to run system V init script
apache_start="$service httpd start" # Apache or HTTPD will start, in debian and ubuntu user apache2 instead of httpd
mysql_start="$service mysqld start" # mysql will start
ssh_start="$service sshd start" # ssh will start
varnish_start="$service varnish start" # varnish server will start
nrpe_start="$service nrpe start" # nrpe service will start
munin_node_start="$service munin-node start" # munin node will start
memcached_start="$service memcached start" # memcachsed will start
tomcat_start="$service tomcat start" # apache tomcat server will start
postfix_start="$service postfix start" # it will start postfix server

if [ $UID != $root_id ]; then
        echo "You need to be root in order to run this script."
        exit
fi

/bin/touch $log

echo "#################################################################"
echo Currently, it seems like $num_service services are running.
echo "#################################################################"

$pgrep httpd > /dev/null
if [ $? == 0 ]; then
        echo "Congrats! Apache Server is Running"
else
        echo "Apache Server is down"
        $apache_start
        logger -s "[$date] Apache Server was Started.." 2>> $log
fi

$pgrep mysqld > /dev/null
if [ $? == 0 ]; then
        echo "Congrats! MySQL Server is Running"
else
        echo It looks liks mysql down
        $mysql_start
        logger -s "[$date] MySQL Server was Started.." 2>> $log
fi

$pgrep sshd > /dev/null
if [ $? == 0 ]; then
        echo "Congrats! SSH Server is Running"
else
        echo It looks liks ssh down
        $ssh_start
        logger -s "[$date] SSH Server was Started.." 2>> $log
fi

$pgrep varnishd > /dev/null
if [ $? == 0 ]; then
        echo "Congrats! Varnish Server is Running and it has 2 services"
else
        echo "varnish server is down"
        $varnish_start
        logger -s "[$date] Varnish Server was Started.." 2>> $log
fi

$pgrep nrpe > /dev/null
if [ $? == 0 ]; then
        echo "Congrats! NRPE Service is Running"
else
        echo NRPE is down
        $nrpe_start
        logger -s "[$date] NRPE Service was Started.." 2>> $log
fi

$pgrep munin-node > /dev/null
if [ $? == 0 ]; then
        echo "Congrats! Munin-Node is running"
else
        echo munin-node is down
        $munin_node_start
        logger -s "[$date] Munin-Node was Started.." 2>> $log
fi

$pgrep memcached > /dev/null
if [ $? == 0 ]; then
        echo "Congrats! Memcached Server is Running"
else
        echo memcached server is down
        $memcached_start
        logger -s "[$date] Memcached Server was Started.." 2>> $log
fi

$pgrep java > /dev/null # it is infact tomcat but it requires java to work
if [ $? == 0 ]; then
        echo "Congrats! Tomcat Server is Running and it has 3 services"
else
        echo Tomcat server is down
        $tomcat_start
        logger -s "[$date] Tomcat Server was Started" 2>> $log
fi

$pgrep master > /dev/null # Postfix server is known as master
if [ $? == 0 ]; then
       echo "Congrats! Postfix (SMTP) Server is Running"
else
       echo "Postfix Server is down"
       $postfix_start
       logger -s "[$date] Postfix Server was Started.." 2>> $log
fi
