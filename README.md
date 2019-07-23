[![](https://images.microbadger.com/badges/image/cagataygurturk/docker-ssh-tunnel.svg)](https://microbadger.com/images/cagataygurturk/docker-ssh-tunnel)

# Docker SSH Tunnel

This Docker creates a simple SSH tunnel over a server. It is very useful when your container needs to access to an external protected resource. In this case this container might behave like a proxy to outer space inside your Docker network.

## Usage

This container requires some environmental variables and a private key mounted as a volume.

### Env vars

`TUNNEL_HOST` is the domain or IP of the server that you want to tunnel through.
`TUNNEL_USERNAME` is the ssh user which will be used to connect to the host
`REMOTE_HOST` is the tunnel endpoint after it comes out through TUNNEL\_HOST. This will be 127.0.0.1 if you want to connect to the TUNNEL_HOST itself.
`LOCAL_PORT` is the local port inside this container
`REMOTE_PORT` is the port to connect to on the other end of the tunnel.

### Private Key
The private key should be mounted into `/root/ssh/`.

### Example docker-compose.yml

```
    version: '2'
    services:
      mysql:
        image: cagataygurturk/docker-ssh-tunnel:latest
        volumes:
          - $HOME/.ssh/id_rsa:/root/ssh/id_rsa:ro
        environment:
          TUNNEL_HOST: <IP>
          TUNNEL_USERNAME: me
          REMOTE_HOST: 127.0.0.1
          LOCAL_PORT: 3306
          REMOTE_PORT: 3306
```

Run `docker-compose up -d`

After you start up docker containers, any container in the same network will be able to access to tunneled mysql instance using ```tcp://<container-name>:3306```. Of course you can also expose port 3306 on the host to be able to access to tunneled resource from your host machine.
