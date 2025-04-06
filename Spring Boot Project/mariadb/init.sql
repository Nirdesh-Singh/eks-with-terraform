-- Create database
CREATE DATABASE IF NOT EXISTS userdb;

-- Create user and grant privileges
CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON userdb.* TO 'user'@'%';

-- Ensure root has a password (just in case)
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;
