#!/bin/bash

source components/common.sh

Print "Install Nginx\t\t"
yum install nginx -y &>>$LOG
Status_Check $?

Print "Download Frontend Archive"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
Status_Check $?

Print "Extract Frontend Archive"
rm -rf /usr/share/nginx/* && cd /usr/share/nginx && unzip -o /tmp/frontend.zip  &>>$LOG  && mv frontend-main/* .  &>>$LOG  &&   mv static/* .  &>>$LOG
Status_Check $?

# Print "Copy Nginx RoboShop Config"
# mv localhost.conf /etc/nginx/default.d/roboshop.conf  &>>$LOG
# Status_Check $?

Print "Update Nginx RoboShop Config"
sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' -e '/user/ s/localhost/user.roboshop.internal/' -e '/cart/ s/localhost/cart.roboshop.internal/' -e '/shipping/ s/localhost/shipping.roboshop.internal/' -e '/payment/ s/localhost/payment.roboshop.internal/' /etc/nginx/default.d/roboshop.conf  &>>$LOG
Status_Check $?

Print "Restart Nginx\t\t"
systemctl start nginx  &>>$LOG  && systemctl enable nginx   &>>$LOG
Status_Check $?