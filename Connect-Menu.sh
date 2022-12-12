
items=("Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table"
    "Delete From Table" "update From Table" "Back to menu")

while item=$(zenity --title="Welcome : $USER" --text="Connect Menu" --list \
               --column="select" "${items[@]}")
do
    case "$item" in
        "${items[0]}")  source ./CreateTable.sh;;
        "${items[1]}")  source ./ListTable.sh;;
        "${items[2]}")  source ./DropTable.sh;;
        "${items[3]}")  source ./InsertIntoTable.sh;;
        "${items[4]}")  source ./SelectIntoTable.sh;;
        "${items[5]}")  source ./Delete_menu.sh;;
        "${items[6]}")  source ./UpdateTable.sh;;
        "${items[7]}")  source ./main.sh;;
        *) echo "Ooops! Invalid option.";;
    esac
done


ret=$?

if (($ret==-1)); then
    :
else
    source ./main.sh
fi

