#!/bin/bash -eu

. ./tags.env >&/dev/null || . /vagrant/tags.env >&/dev/null;

echo "umbeTag:${umbeTag}";
echo "umfeTag:${umfeTag}";
echo "certsTag:${certsTag}";
echo "ditaTag:${ditaTag}";

imageName="user-management-backend";
src="${srcRepo}/${imageName}:${umbeTag}";
dest="${destRepo}/${imageName}:${umbeTag}";
imageId=`docker inspect --format='{{.Id}}' "${src}"`;
docker tag -f "${imageId}" "${dest}";
docker push "${dest}";

imageName="user-management-frontend";
src="${srcRepo}/${imageName}:${umfeTag}";
dest="${destRepo}/${imageName}:${umfeTag}";
imageId=`docker inspect --format='{{.Id}}' "${src}"`;
docker tag -f "${imageId}" "${dest}";
docker push "${dest}";

imageName="cr-certs";
src="${srcRepo}/${imageName}:${certsTag}";
dest="${destRepo}/${imageName}:${certsTag}";
imageId=`docker inspect --format='{{.Id}}' "${src}"`;
docker tag -f "${imageId}" "${dest}";
docker push "${dest}";

imageName="dita-documentation";
src="${srcRepo}/${imageName}:${ditaTag}";
dest="${destRepo}/${imageName}:${ditaTag}";
imageId=`docker inspect --format='{{.Id}}' "${src}"`;
docker tag -f "${imageId}" "${dest}";
docker push "${dest}";
