# docker-ssh-tunnel
A docker way to setup an SSH tunnel

***Note***: this container is designed for key-based auth only

## Usage (build)

```
$git clone https://github.com/ShellAddicted/docker-ssh-tunnel

$docker build -t docker-ssh-tunnel:v1
```

### Docker
```
$docker create \
  --name=ssh_tunnel \
  -e USER_SSH_ALLOWED=ssh-rsa AA....
  -p 443:443 \
  --restart unless-stopped \
  docker-ssh-tunnel:v1
```


### docker-compose

```
version: "3"
services:
  ssh_tunnel:
    image: docker-ssh-tunnel:v1
    environment:
      - USER_SSH_ALLOWED=ssh-rsa AA....
    ports:
      - 443:443
    restart: unless-stopped
```

## Connect to the tunnel
```
ssh -p 443 -D 1337 -N tunusr@yourhost
```
Now the SOCKSv5 Proxy is available @ 127.0.0.1:1337