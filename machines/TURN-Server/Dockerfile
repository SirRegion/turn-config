FROM coturn/coturn:latest

COPY turnserver.conf /etc/coturn/turnserver.conf

CMD ["--log-file=stdout", "-c /etc/turnserver.conf"]