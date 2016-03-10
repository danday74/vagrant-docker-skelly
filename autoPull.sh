#!/bin/bash -eu

. ./tags.env >&/dev/null || . /vagrant/tags.env >&/dev/null;

echo "databaseTag:${databaseTag}";
echo "umbeTag:${umbeTag}";
echo "umfeTag:${umfeTag}";
echo "apiTag:${apiTag}";
echo "ldapTag:${ldapTag}";
echo "certsTag:${certsTag}";
echo "ditaTag:${ditaTag}";

echo "Pulling docker images";
docker pull centos:6;
docker pull ${srcRepo}/cr-database:${databaseTag};
docker pull ${srcRepo}/user-management-backend:${umbeTag};
docker pull ${srcRepo}/user-management-frontend:${umfeTag};
docker pull ${srcRepo}/investigation-api:${apiTag};
docker pull ${srcRepo}/openldap:${ldapTag};
docker pull ${srcRepo}/cr-certs:${certsTag};
docker pull ${srcRepo}/dita-documentation:${ditaTag};
