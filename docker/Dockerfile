FROM postgres

ENV POSTGRES_DB govdata
ENV POSTGRES_USER dbuser
ENV POSTGRES_PASSWORD dbpassword

# install curl so you can ETL the CMS data from original source
RUN sed -i -e 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install curl

COPY ./etl/scripts/schema.load.sh /docker-entrypoint-initdb.d/schema.load.sh
COPY ./etl /etl