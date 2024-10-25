FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y wget gnupg2 lsb-release && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y postgresql-17 postgresql-client-17 postgresql-contrib && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY postgresql.conf /etc/postgresql/postgresql.conf

USER postgres

RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER postgresuser WITH SUPERUSER PASSWORD 'postgres';" && \
    createdb -O postgresuser timemanager_dev

EXPOSE 5432

VOLUME ["/var/lib/postgresql/data"]

CMD ["/usr/lib/postgresql/17/bin/postgres", "-D", "/var/lib/postgresql/data", "-c", "config_file=/etc/postgresql/postgresql.conf"]
