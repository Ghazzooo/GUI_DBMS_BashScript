if [ ! -d "database" ]
then
    mkdir database
fi

 items=("Create Databas" "List Database" "Connect To Database" "Drop Database" "Exit")

while item=$(zenity --title="Welcome : $USER" --text="Main Menu" --list \
               --column="select" "${items[@]}")
do
    case "$item" in
        "${items[0]}")  source ./CreateDB.sh;;
        "${items[1]}")  source ./ListDB.sh;;
        "${items[2]}")  source ./ConnectDB.sh;;
        "${items[3]}")  source ./DropDB.sh;;
        "${items[4]}") exit;;
        *) echo "Ooops! Invalid option.";;
    esac
done
ret=$?

if (($ret==-1)); then
    :
else
    exit
fi



