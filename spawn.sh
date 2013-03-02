#!/bin/bash
source /home/"$(id -un)"/.mrmv

echo "#" >> "$4"/$3
echo "# Starting migration @ $(date +"%m-%d-%y.%H-%M")" >> "$4"/$3
echo "#" >> "$4"/$3

/usr/bin/rsync -e "/usr/bin/ssh -p $port" "$rsyncops" "$1" "$2" >> "$4"/$3 2>> "$4"/$3

basename=$(echo $1 | awk -F "/" '{print $(NF)}')

	if [ $? == 0 ]; then

echo "###########################################" >> "$4"/$3
echo "########### The Move Completed Successfully" >> "$4"/$3
echo "###########################################" >> "$4"/$3
echo "unique ID: $3" | mail -s "$emtag Yay! $basename has been moved" "$email"

	else

echo "###########################################" >> "$4"/$3
echo "########### The Move Generated an ERROR! Run Halted." >> "$4"/$3
echo "###########################################" >> "$4"/$3
echo "$3 - OHH NOEES!! $1 has NOT been moved to $hostname" | mail -s "$emtag Uh ohh..There was problem moving $basename" "$email"

	fi
