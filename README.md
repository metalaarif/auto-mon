This is a Linux Server services monitor called auto-mon. auto-mon is a very basic service monitoring script for Apache(httpd), mysqld, sshd, varnishd, nrpe, memcached, tomcat and munin-node. Currently, it has been customised for my requirements and it will easily work in RHEL, CentOS, Scientific Linux etc. In order to make it work for Debian, Ubuntu based OS, you would need to make minor changes.

###Installation is piece of cake

    Download and Save it in your directory which suits you.
    Before editing your crontab, best you test it ==> # sh auto-mon.sh
    Edit your crontab ==> */3 * * * * root /path of the directory/auto-mon.sh > /dev/null 2>&1
    And you're done.

I will be updating and putting a log file soon enough with date and message. 
