#!/bin/sh
#
# The intention of this script is to initiate a loop that will check for Starbound's server status. 
# If Starbound's server is found to be not running, then it will start Starbound.
#
# 
#
# specify your starbound server folder here, starting from /home/username, etc, if necessary
starbound_dir="/full/path/to/starbound/linux64or32"

# the file may be called something else in your install. make sure there are no similarly named extra scripts running or this will not work. 
#ie if a match can be obtained on more than one running process using this name, it will not recognize when the main server goes down.
starbound_file="starbound_server"

# this will be the directory you get your logfile in. full path necessary. 
restarter_log_dir="/full/path"

#the function that will do the leg work when Starbound is found to not be running....
restarter () {
  timestamp=`date +%Y_%m_%d_%H%M`
  cd $restarter_log_dir
  touch restarter.log
  echo "restarter caught $starbound_file at $timestamp"|tee -a restarter.log
  echo "starbound-restarter is restarting Starbound...."
  cd $starbound_dir
  ./$starbound_file
  return
}


#the core loop of the restarter that checks for downages every 30 secs...
while true
do

ps -ag|grep -v "grep"|grep $starbound_file

if [ $? -eq 1 ]
then restarter
else echo "Starbound server looks okay.... "
fi

echo "starbound-restarter heart beat...."

sleep 30
done


exit 2