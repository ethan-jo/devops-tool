#!/bin/bash
# define target server,target dir and database account info
targetuser="targetuser"
targetserver="1.1.1.1"
targetdir="/backup/jenkins"

currentdate=$(date +%Y%m%d)

function backup_tar {
    echo "Jenkins home dir: ${JENKINS_HOME}"
    cd ${JENKINS_HOME}|| exit

    if [ ! -d "../backup" ]; then
        mkdir ../backup
    fi

    tar -czvf ../backup/jenkins-backup-${currentdate}.tar.gz ./* --exclude-from=${JENKINS_HOME}/../exclude.txt 
}

## tar backup file
backup_tar
#test

# scp to bacup file
scp  ../backup/jenkins-backup-${currentdate}.tar.gz ${targetuser}@${targetserver}:${targetdir}
scp  ../jenkins.war ${targetuser}@${targetserver}:${targetdir}

# clean temp file
rm -f ../backup/jenkins-backup-${currentdate}.tar.gz

$*