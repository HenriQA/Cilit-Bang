-- UPDATE mysql.user SET Password=PASSWORD('V1p3r') WHERE User='root';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'V1p3r';
ALTER USER 'root'@'127.0.0.1' IDENTIFIED BY 'V1p3r';
ALTER USER 'root'@'::1' IDENTIFIED BY 'V1p3r';

DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
