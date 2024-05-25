#Declare a Function

SAMPLE() {
  a=100
  echo I am a function
  echo "Value of a in function = $a"
  b=20
  echo "First Argument in Function = $1"
}

##Main Program
#Access a function
a=10
SAMPLE xyz
b=200
echo "Value of b in Main program = $b"

echo "First Argument in Main program = $1"