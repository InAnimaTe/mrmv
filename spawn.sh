#!/bin/bash
source /home/"$(id -un)"/.mrmv
basename=$(echo $1 | awk -F "/" '{print $(NF)}')

echo "#" >> "$4"/$3
echo "# Starting migration @ $(date +"%m-%d-%y.%H-%M")" >> "$4"/$3
echo "#" >> "$4"/$3

/usr/bin/rsync -e "/usr/bin/ssh -p $port" "$rsyncops" "$1" "$2" >> "$4"/$3 2>> "$4"/$3
ret="$?"

	if [ $ret == 0 ]; then

echo "###########################################" >> "$4"/$3
echo "########### The Move Completed Successfully" >> "$4"/$3
echo "###########################################" >> "$4"/$3
#the following line only showed the ID. the one following it cats the entire log file for reading in email
#echo "unique ID: $3" | mail -s "$emtag Yay! $basename has been moved" "$email"
cat "$4/$3" | mail -s "$emtag Yay! $basename has been moved" "$email"

	else

echo "###########################################" >> "$4"/$3
echo "########### The Move Generated an ERROR! Run Halted." >> "$4"/$3
echo "###########################################" >> "$4"/$3
#echo "$3 - OHH NOEES!! $1 has NOT been moved to $hostname" | mail -s "$emtag Uh ohh..There was problem moving $basename" "$email"
cat "$4/$3" | mail -s "$emtag Uh ohh..There was problem moving $basename with error code $ret" "$email"

	fi
