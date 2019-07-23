#!/bin/ash

set -e

rm -rf /root/.ssh
mkdir -p /root/.ssh
cp -R /root/ssh/* /root/.ssh/
cat >> /root/.ssh/config << EOL
Host $TUNNEL_HOST 
        IdentityFile ~/.ssh/id_rsa
        User $TUNNEL_USERNAME
        ForwardAgent yes
        TCPKeepAlive yes
        ConnectTimeout 5
        ServerAliveCountMax 10
        ServerAliveInterval 15
EOL
chmod -R 600 /root/.ssh/*

cat /root/.ssh/config
ls -la /root/.ssh/id_rsa

ssh -vv -o StrictHostKeyChecking=no \
    -N $TUNNEL_HOST \
    -L *:$LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT \
    && while true; do sleep 30; done;
