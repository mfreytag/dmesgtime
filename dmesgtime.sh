#!/bin/bash

# change Internal Field Separator variable from " " to "\n"
# to store whole lines instead of fields in an array

OLDIFS=$IFS
IFS=$'\n'

# only whole seconds since boot from dmesg
arraytime=(`dmesg | cut -f1 -d\. | tr -d "[" | tr -d " "`)

# whole lines from dmesg
arrayline=(`dmesg`) 

# UNIX date in seconds (seconds since 1970-1-1)
dateins=`date +%s`

# get uptime in seconds
uptimeins=`cat /proc/uptime | cut -f1 -d\.`

# boot time in seconds since 1970
let bootins=$dateins-$uptimeins

# define integer for loop (probably not needed)
typeset -i i=0
# loop while 
while (( i < ${#arraytime[*]}))
do
# j so amount starts counting at 1
typeset -i j=0
let j=$i+1
# let event be time of event since 1970 in seconds
let event=0
let event=$bootins+${arraytime[$i]}
# print result as formatted date
echo "line #$j: `date -d @$event` ${arrayline[$i]}"
# counter
i=i+1
# done looping
done

# reset input field separator
IFS=$OLDIFS
