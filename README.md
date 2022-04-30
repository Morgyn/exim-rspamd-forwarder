# exim-rspamd-forwarder

Docker image with exim and rspamd for simple forwarding.

create a directory on your host, place files named with the domain you want to forward for. Alases are in the form `local_part:email.destination.com`

```
emailaliases
  `- morgyn.org
  `- otherdomain.org
```
  
emailaliases\morgyn.org:  
```
morgyn:my@realdomain.tld
bob:bob@otherdomain.tld
```

docker run
```
docker run --name exim -p 25:25 -v /full/path/to/emailaliases:/etc/exim/virtual morgyn/exim-rspamd-forwarder
```


docker-compose
```
version: '2'

services:
  email:
    image: morgyn/exim-rspamd-forwarder
    container_name: exim
    ports:
      - "25:25"
    volumes:
      - /full/path/to/emailaliases:/etc/exim/virtual
