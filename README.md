# Owncloud container

Owncloud can be run as other user than www-data if you set USER_ID environment
variable

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

