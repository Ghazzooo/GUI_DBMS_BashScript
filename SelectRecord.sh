#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    zenity --error \
                --text="Table Empty"
    source ./Connect-Menu.sh
fi    



function selectrecord()
{
    record=$(zenity --entry \
    --title="Select Record" \
    --text="Enter Primary Key :" \
    --entry-text "")
    ret=$?

    if (($ret==0)); then
        :
    else
        source ./Connect-Menu.sh
    fi
    while [[ -z $record ]]
    do 
        record=$(zenity --entry \
            --title="Invalid Input" \
            --text="Enter Primary Key Record Again" \ 
            --entry-text "" )
        ret=$?
        if (($ret==0)); then
            :
        else
            source ./Connect-Menu.sh
        fi
    done   
    ##check that the input pk exists       
    ## if input record = cut first column from the table then search for input pk record  
    if [[ $record =~ [`cut -d':' -f1 ./database/$dbname/$tablename | grep -x $record`] ]]; then
        #then,(recordnumber = NR) we search in all rows using awk, if the first column field matches the record 
        #then prints number of records 
    
        recordnumber=`awk -F":" '{if ($1=="'$record'") print NR}' ./database/$dbname/$tablename `
    #select the recordnumber
        #print columns name
        SELECTHEAD=$(head -n 1 ./database/$dbname/$tablename)
        #sed (print) the line of given NR
        SELECTRECORD=$(sed -n ''$recordnumber'p' ./database/$dbname/$tablename)
        zenity --info \
                    --text="$SELECTHEAD\n$SELECTRECORD"
        source ./Connect-Menu.sh                  
    else              
        zenity --error \
                    --text="Record Not Exists "  
        selectrecord             
    fi
}
selectrecord