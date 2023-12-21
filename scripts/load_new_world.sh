#!/bin/bash

world="/home/mcuser/serverfolder/world/"

if [ -d "$world" ]; then

# 	Uncomment the line below for the script to work
#	find $world -mindepth 1 -maxdepth 1 ! -name 'serverconfig' -exec rm -rf {} +

	if [ $? = 0 ]; then
		echo "World data deleted succesfully!"
	else
		echo "Couldn't delete the contents of $world properly!"
	fi

else
	echo "Couldn't locate $world"
fi

exit 0
