#!/bin/bash

#defaults
cur_date=`date +%Y-%m-%d -d "1 day ago"`

#read config file
script_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
[ ! -f $script_directory/$1.config ] && exit
source $script_directory/$1.config

#dump db
mysqldump -u $mysql_user -p$mysql_password $mysql_database | gzip > $working_folder/sql."$cur_date".gz


# delete old backups
for backup_file in `find $working_folder -mtime +30 -type f`
do
  echo $backup_file
  if [[ $backup_file != *"-01.gz" ]]
  then
    rm $backup_file
  fi
done