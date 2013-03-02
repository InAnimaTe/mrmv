#!/bin/bash
source /home/"$(id -un)"/.mrmv


#declare our function
pickme ()
{
cd "$stordir"
echo ""
echo "Contents existing in your home directory:"

declare -a ARRAY
        let index=0

IFS=$'\n'
for file in $( ls ); do
        ARRAY[$index]="$file"
        echo "$index :: ${ARRAY[$index]}"
        ((index++))
        done

echo ""
echo "What would you like to move?"
read thing
echo "$thing :: ${ARRAY[$thing]}"
id=$(echo -n $RANDOM)
nohup "$cur"/spawn.sh "$(pwd)/${ARRAY[$thing]}" "$mvto" $id "$webdir" > "$webdir/nohup" 2> "$webdir/nohup" &
echo "${ARRAY[$thing]} has been started with an ID of $id" > "$webdir"/$id
echo "${ARRAY[$thing]} has been started with an ID of $id"
#gosh, I just love my variable names
echo ""
echo "Would you like to move other files? y|n"
read dec
if  [ "$dec" == "y" ]; then
        pickme
else
        exit
fi

}



#run function

pickme


#this is super simple...
