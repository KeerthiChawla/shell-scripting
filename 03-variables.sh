a=10
b=xyz

echo $a
echo ${b}

DATE=$(date +%F)
echo Welcome, Today date is $DATE

ADD=$((2+3))
echo add=$ADD

a1=100
a1=200
echo val of ABC = ${ABC}

b2=(100 101.0 true abc)
echo ${b2[0]}
echo ${b2[1]}

declare -A arr=( [class]=Devops [trainer]=John )
echo ${arr[class]}