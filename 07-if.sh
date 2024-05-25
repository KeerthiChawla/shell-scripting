read -p "Enter some input: " input
if [ -z $input ]; then
echo "Hey,You have not provided any input"
exit 1
fi

if [ $input == "ABC" ];then
echo "Input you provided is ABC"
fi

echo "Input - $input"
if [ $? -eq 0 ];then
    echo Success
else
    echo Failure
fi

read -p "Enter your FileName: " file
if [ -e $file ]; then
echo "File exists"
else
echo "file doesn't exists"
fi