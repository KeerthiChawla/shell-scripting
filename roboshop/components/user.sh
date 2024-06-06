#!/bin/bash

source components/common.sh

Print "Install NodeJS"
yum install nodejs make gcc-c++ -y &>>$LOG
Status_Check $?


# useradd roboshop
So let's switch to the roboshop user and run the following commands.

$ curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip"
$ cd /home/roboshop
$ unzip /tmp/user.zip
$ mv user-main user
$ cd /home/roboshop/user
$ npm install 
Now, lets set up the service with systemctl.

# mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
# systemctl daemon-reload
# systemctl start user
# systemctl enable user