#!/bin/bash -eu

. ./tags.env >&/dev/null || . /vagrant/tags.env >&/dev/null;

echo "ldapTag:${ldapTag}";
echo "databaseTag:${databaseTag}";
echo "apiTag:${apiTag}";

imageName="openldap";
src="${srcRepo}/${imageName}:${ldapTag}";
dest="${destRepo}/${imageName}:${ldapTag}";
imageId=`docker inspect --format='{{.Id}}' "${src}"`;
docker tag -f "${imageId}" "${dest}";
docker push "${dest}";

imageName="cr-database";
src="${srcRepo}/${imageName}:${databaseTag}";
dest="${destRepo}/${imageName}:${databaseTag}";
imageId=`docker inspect --format='{{.Id}}' "${src}"`;
docker tag -f "${imageId}" "${dest}";
docker push "${dest}";

imageName="investigation-api";
src="${srcRepo}/${imageName}:${apiTag}";
dest="${destRepo}/${imageName}:${apiTag}";
imageId=`docker inspect --format='{{.Id}}' "${src}"`;
docker tag -f "${imageId}" "${dest}";
docker push "${dest}";
