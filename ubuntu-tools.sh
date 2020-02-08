#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo '  - UPDATE & UPGRADE'
echo '  - GIT'
echo '  - OPENSSH-SERVER'
echo '  - CURL'
echo '  - DOCKER'
echo '  - DOCKER-COMPOSE'

echo  ''
echo -n 'Use Defaults [Y/N]: '
echo -en "${YELLOW}"
read -r opcion
echo -en "${NC}"

if [ $opcion == "Y" ] || [ $opcion == "y" ] 
then
    echo ""
    echo "Updating OS..."
    output=`eval "apt-get -y update"`
    echo "OS updated"
    echo ""

    #echo "Upgrading OS..."
    #output=`eval "apt-get -y upgrade"`
    #echo "OS upgraded"
    #echo ""

    echo "Installing openssh-server ..."
    output=`eval "apt-get install -y openssh-server"`
    echo "openssh-server installed"
    echo ""

    echo "Installing git ..."
    output=`eval "apt-get install -y git"`
    echo "git installed"
    echo ""

    echo "Installing curl ..."
    output=`eval "apt-get install -y curl"`
    echo "curl installed"
    echo ""

    echo "Installing docker ..."
    output=`eval "docker --version"`
    status=$?
    if [ $status -eq 0 ]
    then
        echo "docker already installed"
        echo "skipping docker installation"
    else
        output=`eval "wget -qO- https://get.docker.com/ | sh"`
        output=`eval "groupadd docker"`
        output=`eval "gpasswd -a $USER docker"`
        output=`eval "service docker restart"`
        eval "docker --version"
        echo "docker installed"
    fi
    echo ""

    echo "Installing docker-compose..."
    output=`eval "docker-compose --version"`
    status=$?
    if [ $status -eq 0 ]
    then
        echo "docker-compose already installed"
        echo "skipping docker-compose installation"
    else
        CMD="curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`\uname -s`-`uname -m` -o /usr/local/bin/docker-compose"
        output=`eval "$CMD"`
        output=`eval "chmod +x /usr/local/bin/docker-compose"`
        eval "docker-compose --version"
        echo "docker-compose installed"
    fi
    echo ""

echo -e "${YELLOW}Log out (i.e restart SSH connection) in order to run docker without sudo${NC}"
fi