#!/bin/bash
# define target server,target dir and database account info
targetuser="targetuser"
targetserver="1.1.1.1"
targetdir="/backup/sonarqube"
sonaruser="user"
sonarpwd="pwd"

# cd work dir
workdir=$(cd "$(dirname "$0")";pwd) 
cd ${workdir}

# create sql backup file
currentdate=$(date +%Y%m%d) 
pg_dump -U ${sonaruser}  -d ${sonarpwd} -Z 9 > sonarqube-data-${currentdate}

# scp file to bacup server
scp -r extensions ${targetuser}@${targetserver}:${targetdir}
scp  sonarqube-data-${currentdate} ${targetuser}@${targetserver}:${targetdir}

# clean temp file
rm  -f  sonarqube-data-${currentdate}
