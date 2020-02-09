#! /bin/sh

if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    /usr/bin/ssh-keygen -A
    # Set a random password to make SSH happy, but this container is designed to use key auth only
    echo "tunusr:$(cat /dev/urandom | head -c 64 | base64 | head -c 64)" | chpasswd
    echo "$USER_SSH_ALLOWED" > /home/tunusr/.ssh/authorized_keys
fi

if [[ -z "${USER_SSH_ALLOWED}" ]]; then
    echo "USER_SSH_ALLOWED is not defined, exiting..."
    return 1
else
    exec /usr/sbin/sshd -p 443 -D -e
fi