#check if there is no tables in database 
if [ `ls ./database/$dbname | wc -l` == 0 ]
then
       zenity --error \
        --text="No Table Found"
      source ./Connect-Menu.sh
fi      
tablename=$(zenity --entry \
        --title="Select Table" \
        --text="Enter Table You Want To Select :" \
        --entry-text "")
#----------------------------------------------------
ret=$?

if (($ret==0)); then
    :
else
    source ./Connect-Menu.sh
fi

while [[ -z $tablename ]]
do 
  tablename=$(zenity --entry \
        --title="Invalid Input" \
        --text="Please Enter Table You Want To Select Again :" \
        --entry-text "")
#=================================================================
    ret=$?

    if (($ret==0)); then
        :
    else
        source ./Connect-Menu.sh
    fi
done

export tablename

if [ -f ./database/$dbname/$tablename ]
then
    items=("Select All Records" "Select Record" "Back To Table Menu" )

while item=$(zenity --title="Welcome : $USER" --text="Select Menu" --list \
               --column="select" "${items[@]}")
do
    case "$item" in
        "${items[0]}")  source ./SelectAllRecords.sh;;
        "${items[1]}")  source ./SelectRecord.sh;;
        "${items[2]}")  source ./Connect-Menu.sh;;
        *) echo "Ooops! Invalid option.";;
    esac
done
ret=$?

if (($ret==0)); then
    :
else
    source ./Connect-Menu.sh
fi
else
    zenity --error \
                --text="Table Not Exists "
   source ./SelectIntoTable.sh
fi	
