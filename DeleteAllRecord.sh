#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    zenity --error \
                --text="Table Is Empty"
    source ./Connect-Menu.sh
fi    

#get first line in the table (columns name) then append it to the file

echo `head -n 1 ./database/$dbname/$tablename` > ./database/$dbname/$tablename
zenity --info \
                --text="Table Record Successfully Deleted"
source ./Connect-Menu.sh