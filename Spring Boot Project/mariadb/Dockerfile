FROM mariadb:latest

ENV MYSQL_ROOT_PASSWORD=root

# Copy the SQL file into the container
COPY init.sql /docker-entrypoint-initdb.d/
