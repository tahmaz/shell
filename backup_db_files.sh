#!/bin/bash
#Set Variables
DATE=`date +%Y%m%d`
FILENAME=cacti_database_$DATE.sql;
FILENAME1=cno_database_$DATE.sql;
BACKUPDIR=/backup/;
TGZFILENAME=cacti_files_$DATE.tgz;
TGZFILENAME1=webapps_files_$DATE.tgz;
TGZFILENAME2=scripts_$DATE.tgz;
DBUSER=testuser;
DBPWD=test;
DBNAME=test;
DBNAME2=test2;
GZIP=/bin/gzip;
cd /

#Remove files older than 7 days
find /backup/cacti_*gz -mtime +7 -exec rm {} \;
#Remove files older than 7 days
find /backup/webapps_files_*tgz -mtime +7 -exec rm {} \;
#Remove files older than 7 days
find /backup/cno_database_*gz -mtime +7 -exec rm {} \;
#Remove files older than 7 days
find /backup/scripts_*tgz -mtime +7 -exec rm {} \;

#Backup Cacti Database
mysqldump -utestuser -ptest $DBNAME > $BACKUPDIR$FILENAME
$GZIP $BACKUPDIR$FILENAME

#Backup Important Files
tar -csvpf $BACKUPDIR$TGZFILENAME ./etc/cron.d/cacti ./usr/share/cacti ./var/lib/cacti/rra

#Backup Cacti Database
mysqldump -uroot -pmysqlroot $DBNAME2 > $BACKUPDIR$FILENAME1
$GZIP $BACKUPDIR$FILENAME1

#Backup apache webapps folder
tar -csvpf $BACKUPDIR$TGZFILENAME1 ./home/tomcat/apache-tomcat-8.0.5/webapps --exclude=./home/tomcat/apache-tomcat-8.0.5/webapps/os_images/images 

#Backup scripts folder
tar -csvpf $BACKUPDIR$TGZFILENAME2 ./home/scripts
