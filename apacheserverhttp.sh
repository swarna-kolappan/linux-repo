#!/bin/bash
export ctl=/home/programs/httpd-2.0.63/bin/apachectl
if test -f $ctl; then
 case "$1" in
 start|restart|graceful|stop)
 $ctl $1
 if [ `ps auxwwww|grep httpd|grep -v grep|wc -l` -gt 0 ]
 then
 echo Apache is running.
 else
 echo Apache is not running.
 fi
 ;;
 status)
 if [ `ps auxwwww|grep httpd|grep -v grep|wc -l` -gt 0 ]
 then
 echo Apache is running.
 else
 echo Apache is not running.
 fi
 ;;
 *)
 echo "Usage: apache start|restart|graceful|stop"
 esac
else
 echo Apache is not installed;
fi