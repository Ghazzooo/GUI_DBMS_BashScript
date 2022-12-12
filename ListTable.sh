 if [ `ls ./database/$dbname/ | wc -l` == 0 ]
    then     
    zenity --error \
        --text="Could not find Tables"
    source ./Connect-Menu.sh   
else
    zenity --info \
        --text="$(ls -I "*Type" ./database/$dbname)"
    source ./Connect-Menu.sh
fi

