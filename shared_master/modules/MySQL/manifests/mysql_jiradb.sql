CREATE USER 'jiradbuser'@'192.168.1.26' IDENTIFIED BY 'r4Pt0r';
CREATE DATABASE jiradb CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL PRIVILEGES ON jiradb.* TO 'jiradbuser'@'192.168.1.26' IDENTIFIED BY 'r4Pt0r';
FLUSH PRIVILEGES;