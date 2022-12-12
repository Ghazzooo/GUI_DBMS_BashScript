#! /bin/bash

#check if the table empty
if [[ `cat ./database/$dbname/$tablename | wc -l` == 1 ]]
then 
    zenity --info \
                --text="Table Is Empty"
    source ./Connect-Menu.sh
fi    
function delete()
{
    record=$(zenity --entry \
        --title="Delete Record" \
        --text="Please Enter Primary Key :" \
        --entry-text "")
   ret=$?

      if (($ret==0)); then
        :
      else
         source ./Delete_menu.sh
      fi

    while [[ -z $record ]]
    do 
    Record=$(zenity --entry \
        --title="Invaled Input" \
        --text="Please Enter Primary Key Again:" \
        --entry-text "")
    
      ret=$?
      if (($ret==0)); then
        :
      else
         source ./Delete_menu.sh
      fi
    done   
    ##check that the input pk exists       
    ## if input record = cut first column from the table then search for input pk record  
    if [[ $record =~ [`cut -d':' -f1 ./database/$dbname/$tablename | grep -x $record`] ]] 
    then
    #then,(recordnumber = NR) we search in all rows using awk, if the first column field matches the record 
    #then prints number of records 
    #like 1- /n 2- /n 3- ......
            recordnumber=`awk -F":" '{if ($1=="'$record'") print NR}' ./database/$dbname/$tablename`
    #delete the recordnumber .. line 1 .or 2 .....
            sed -i ''$recordnumber'd' ./database/$dbname/$tablename  
            zenity --info \
                --text="Record Deleted Successfuly"
            source ./Connect-Menu.sh
     else
      zenity --error \
                --text="Invalid Record"            
        #call delete function
        delete
    fi
}
delete