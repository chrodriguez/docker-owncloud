# Owncloud container

## Example

```
docker run -e USER_ID=`id -u` \
  -p 8000:80 \
  -v `pwd`/config:/etc/owncloud \
  -v `pwd`/data:/var/www/owncloud/data \
  -d \
  --name=owncloud \
  chrodriguez/owncloud

```

