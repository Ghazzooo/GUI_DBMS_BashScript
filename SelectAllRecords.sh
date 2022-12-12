#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    zenity --error \
        --text="Table Empty"
    source ./Connect-Menu.sh
fi    

 
##echo -e "All Records\n"

#value of $1 is assigned to field $1, 
#awk actually rebuilds its $0 by concatenating them with default field delimiter(or OFS) space.


#New Delimeter
ALLRECORD=$(awk '$1=$1' FS=":" OFS="    " ./database/$dbname/$tablename)
zenity --info \
         --text="$ALLRECORD"
#cat ./database/$dbname/$tablename
source ./Connect-Menu.sh




