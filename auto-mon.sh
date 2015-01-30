#/bin/bash
# Written by metalaarif

service="/sbin/service" # This is to run system V init script
pgrep="/usr/bin/pgrep" # pgrep will be used to search for PID
num_service=`lsof -nPi | grep "LISTEN" | awk '{print $9}' | cut -d: -f2 | sort -u | wc -l` # Searching for number of running services
apache_start="$service httpd start" # Apache or HTTPD will start, in debian and ubuntu user apache2 instead of httpd
mysql_start="$service mysqld start" # mysql will start
ssh_start="$service sshd start" # ssh will start
varnish_start="$service varnish start" # varnish server will start
nrpe_start="$service nrpe start" # nrpe service will start
memcached_start="$service memcached start" # memcachsed will start
tomcat_start="$service tomcat start" # apache tomcat server will start
munin_node_start="$service munin-node start" # starting munin-node server will start

echo "#################################################################"
echo Seems like $num_service services are running.
echo "#################################################################"

$pgrep httpd
if [ $? != 0 ]; then
        echo "It looks like Apache Server is down"
        $apache_start
fi

$pgrep mysqld
if [ $? != 0 ]; then
        echo "It looks liks Mysql Server is down"
        $mysql_start
fi

$pgrep sshd
if [ $? != 0 ]; then
        echo "It looks liks SSH Server down"
        $ssh_start
fi

$pgrep varnishd
if [ $? != 0 ]; then
        echo "It looks like Varnish Server is down"
        $varnish_start
fi

$pgrep nrpe
if [ $? != 0 ]; then
        echo "It looks like NRPE service is down"
        $nrpe_start
fi

$pgrep memcached
if [ $? != 0 ]; then
        echo "It looks like Memcached Server is down"
        $memcached_start
fi

$pgrep java # it is infact tomcat but it requires java to work
if [ $? != 0 ]; then
        echo "It looks like Tomcat Server is down"
        $tomcat
fi

$pgrep munin-node
if [ $? != 0 ]; then
        echo "It looks like Munin-node is down"
        $munin_node_start
fi
