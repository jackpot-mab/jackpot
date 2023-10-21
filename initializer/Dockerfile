FROM debian

RUN apt-get update && \
    apt-get install -y default-mysql-client awscli


COPY . .

ENTRYPOINT ["/bin/sh", "./initialize.sh"]
