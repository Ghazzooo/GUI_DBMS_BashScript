#! /bin/bash

if [ `ls ./database/$dbname | wc -l` == 0 ]
then
    zenity --error \
                --text="Table Not Found"
      source ./Connect-Menu.sh
fi      
tablename=$(zenity --entry \
        --title="Delete From Table" \
        --text="Please Enter Table You Want To Delete :" \
        --entry-text "")
ret=$?

    if (($ret==0)); then
        :
    else
        source ./Connect-Menu.sh
    fi
export tablename
while [[ -z $tablename ]] || [[ $tablebname == *['!''*\ *@#/$\"*{^})(+_/=-]>[<?']* ]] || [[ $tablename == " " ]]
do 
tablename=$(zenity --entry \
        --title="Invaled Input" \
        --text="Please Enter Table You Want To Delete Again :" \
        --entry-text "")

ret=$?

    if (($ret==0)); then
        :
    else
        source ./Connect-Menu.sh
    fi
done

if [ -f ./database/$dbname/$tablename ]
then
    items=("Delete All Records" "Delete Records" "Back To Menu")

while item=$(zenity --title="Welcome : $USER" --text="Delete_Menu" --list \
               --column="select" "${items[@]}")
do
    case "$item" in
        "${items[0]}")  source ./DeleteAllRecord.sh;;
        "${items[1]}")  source ./DeleteRecord.sh;;
        "${items[2]}")  source ./Connect-Menu.sh;;
        *) echo "Ooops! Invalid option.";;
    esac
done
   
else
    zenity --error \
                --text="Table Not Exists"
    source ./Delete_menu.sh
fi	

