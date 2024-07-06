#!/bin/bash

Status_Check() {
if [ $1 -eq 0 ]; then 
  echo -e "\e[32mSuccess\e[0m"
else
  echo -e "\e[31mFailure\e[0m"
  exit 2
fi
}

Print() {
    echo -e "\n\t\t\e[36m----------- $1 --------------\e[0m\n" >>$LOG
    echo -n -e "$1 \t- "
}

if [ $UID -ne 0 ]; then
    echo -e "\n\e[1;33mYou should execute this script as root user\e[0m\n"
    exit 1
fi

LOG=/tmp/roboshop.log
rm -f $LOG   #Removes the previous log

ADD_APP_USER() {
  Print "Adding Roboshop User\t"
id roboshop &>>$LOG
if [ $? -eq 0 ]; then
  echo "User already there, So skipping" &>>$LOG
else
  useradd roboshop &>>$LOG
fi
Status_Check $?
}

DOWNLOAD() {
  Print "Downloading ${COMPONENT} Content"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG
Status_Check $?
Print "Extracting ${COMPONENT}\t"
cd /home/roboshop
rm -rf ${COMPONENT} && unzip -o /tmp/${COMPONENT}.zip &>>$LOG && mv ${COMPONENT}-main ${COMPONENT}
Status_Check $?
}

SystemD_Setup() {
  Print "Update SystemD Service\t"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGODB_ENDPOINT/mongodb.roboshop.internal/' /home/roboshop/${COMPONENT}/systemd.service
Status_Check $?

Print "SetUp SystemD Service\t"
mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service && systemctl daemon-reload && systemctl restart ${COMPONENT} &>>$LOG && systemctl enable ${COMPONENT}
Status_Check $?
}

NODEJS() {
  Print "Installing NodeJS\t"
yum install nodejs make gcc-c++ -y &>>$LOG
Status_Check $?

ADD_APP_USER

DOWNLOAD

Print "Download NodeJS Dependencies"
cd /home/roboshop/${COMPONENT}
npm install --unsafe-perm &>>$LOG 
Status_Check $?

chown roboshop:roboshop -R /home/roboshop
SystemD_Setup

}

