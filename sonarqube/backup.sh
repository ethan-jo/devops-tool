#!/bin/bash
# define target server,target dir and database account info
backup_user="targetuser"
backup_server="1.1.1.1"
backup_dir="/backup/sonarqube"

soanr_dir="home/local/sonarqube"
sonar_user="user"
sonar_pwd="pwd"

pg_dump="/home/local/pgsql/bin/pg_dumpl"

# cd sonarqube dir
cd ${soanr_dir}

# create sql backup file
currentdate=$(date +%Y%m%d) 
${pg_dump} -U ${sonar_user}  -d ${sonar_pwd} -Z 9 > sonarqube-data-${currentdate}

# scp file to bacup server
scp -r extensions ${targetuser}@${backup_server}:${backup_dir}
scp  sonarqube-data-${currentdate} ${targetuser}@${backup_server}:${backup_dir}

# clean temp file
rm  -f  sonarqube-data-${currentdate}