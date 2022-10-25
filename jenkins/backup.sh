#!/bin/bash
# define target server,target dir and database account info
targetuser="targetuser"
targetserver="1.1.1.1"
targetdir="/backup/jenkins"

rundir=$(cd "$(dirname "$0")";pwd)
currentdate=$(date +%Y%m%d)

function backup_tar {
    echo "Jenkins home dir: ${JENKINS_HOME}"
    cd ${JENKINS_HOME}|| exit

    if [ ! -d "../backup" ]; then
        mkdir ../backup
    fi

    tar -czvf ../backup/jenkins-backup-${currentdate}.tar.gz ./* --exclude-from=${rundir}/exclude.txt 
}

function test {
    echo "Jenkins home dir: ${JENKINS_HOME}"
    cd ${JENKINS_HOME}|| exit
    echo "test"
}

cd ${rundir}

## tar backup file
backup_tar
#test

# scp to bacup file
scp  ../backup/jenkins-backup-${currentdate}.tar.gz ${targetuser}@${targetserver}:${targetdir}/backup
scp  ../jenkins.war ${targetuser}@${targetserver}:${targetdir}

# clean temp file
rm -f ../backup/jenkins-backup-${currentdate}.tar.gz

$*
