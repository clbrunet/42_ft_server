CREATE DATABASE wp_database;
CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'wp_password';
GRANT ALL PRIVILEGES ON * . * TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
