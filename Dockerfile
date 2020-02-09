
FROM alpine:latest

RUN apk add --no-cache openssh \
    && adduser -D -s /bin/false tunusr \
    && mkdir -p /home/tunusr/.ssh \
    && touch /home/tunusr/.ssh/authorized_keys \
    && chown -R tunusr:tunusr /home/tunusr/.ssh \
    && chmod -R 0700 /home/tunusr/.ssh \
    && sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication no/g' /etc/ssh/sshd_config \
    && sed -i "s/.*PermitRootLogin.*/PermitRootLogin no/g" /etc/ssh/sshd_config

ADD entrypoint.sh /entrypoint.sh
ADD extra.conf /tmp/

RUN cat /tmp/extra.conf >> /etc/ssh/sshd_config \
    && rm -rf /tmp/*

CMD ["sh", "/entrypoint.sh"]