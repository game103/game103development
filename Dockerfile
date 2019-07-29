FROM debian:stretch

COPY game103 /var/www/game103

RUN /bin/bash /var/www/game103/setup/setup.sh