useradd -m test
passwd test

#---print results---
cat /etc/shadow
cat /etc/groups
cat /etc/passwd

#-----user,group list----
cat /etc/passwd | cut -d: -f1
cat /etc/group |cut -d: -f1