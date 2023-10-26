FROM python:3.11

RUN apt-get update && \
    apt-get install -y default-mysql-client awscli

RUN /usr/local/bin/python -m pip install --upgrade pip \
    && pip3 install cqlsh

COPY . .

ENTRYPOINT ["/bin/sh", "./initialize.sh"]
