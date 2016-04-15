#!/bin/bash
# Stop web server

SHUTDOWN_WAIT=5

tomcat_pid() {
  echo `ps aux | grep org.apache.catalina.startup.Bootstrap | grep -v grep | awk '{ print $2 }'`
}

pid=$(tomcat_pid)
  if [ -n "$pid" ]
  then
    echo "Stoping Tomcat"
    sudo service tomcat8 stop

    let kwait=$SHUTDOWN_WAIT
    count=0;
    until [ `ps -p $pid | grep -c $pid` = '0' ] || [ $count -gt $kwait ]
    do
      echo -n -e "\nwaiting for processes to exit";
      sleep 1
      let count=$count+1;
    done

    if [ $count -gt $kwait ]; then
      echo -n -e "\nkilling processes which didn't stop after $SHUTDOWN_WAIT seconds"
      kill -9 $pid
      echo  " \nprocess killed manually"
    fi
  else
    echo "Tomcat is not running"
  fi


# Remove existing html pages
#sudo chmod 777 /var/lib/tomcat8/webapps/
sudo rm -rf /var/lib/tomcat8/webapps/*