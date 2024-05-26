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