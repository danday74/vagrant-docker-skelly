#!/bin/bash

myhost=`hostname`;
defaultenvfile=./defaults.env;
overridingenvfile=${1:-./${myhost}.env};

if [[ -f ${defaultenvfile} ]]; then
  echo "##### sourcing envvars from ${defaultenvfile} #####";
  . ${defaultenvfile};
else
  echo "no default envvars available @ ${defaultenvfile} - aborting";
  exit 1;
fi

if [[ -f ${overridingenvfile} ]]; then
  echo "##### sourcing overriding envvars from ${overridingenvfile} #####";
  . ${overridingenvfile};
else
  echo "no overriding envvars available @ ${overridingenvfile}";
fi



echo "certsTag:${certsTag}";
echo "databaseTag:${databaseTag}";
echo "apiTag:${apiTag}";
echo "umbeTag:${umbeTag}";
echo "umfeTag:${umfeTag}";

echo "deploymentDir:${deploymentDir}";
echo "serverName:${serverName}";
echo "httpsForwardPortInvestigator:${httpsForwardPortInvestigator}";
echo "httpsActualPortAdmin:${httpsActualPortAdmin}";
echo "httpsForwardPortAdmin:${httpsForwardPortAdmin}";



echo "##### removing containers #####";
docker-compose kill;
docker-compose rm -f;
docker rm -f $(docker ps -a -q) >/dev/null 2>&1 || :;



echo "##### removing mounts #####";
# rm -rf ${deploymentDir}/volume-certs;
# rm -rf ${deploymentDir}/volume-umfe-apache-conf;
# rm -rf ${deploymentDir}/volume-umfe-apache-logs;

if [[ ! -d ${deploymentDir}/volume-certs ]]; then
  echo "##### pulling certs #####";
  docker pull dandocker777/cr-certs:${certsTag};
  echo "##### running certs #####";
  docker run --name certs -e SUBJECT_ALT_NAME="DNS.1:localhost,DNS.2:api,DNS.3:daniellewis777.com,DNS.4:www.daniellewis777.com" -e PARENT_PASSWORD="parent777" -e CHILD_PASSWORD="child777" -e KEYSTORE_PASSWORD="keystore777" -v ${deploymentDir}/volume-certs:/etc/ssl/certs/cyberreveal dandocker777/cr-certs:${certsTag};
else
  echo "##### using existing certs #####";
fi

echo "##### pulling latest images #####";
docker-compose pull;
echo "##### running containers #####";
docker-compose up -d;

# Logs
echo "##### compose logs #####" && docker-compose logs;
