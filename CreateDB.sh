if name=$(zenity --entry \
    --title="Create Database" \
    --text="Enter Database name:" \
    --entry-text "")
then
    while [[ -z $name ]] || [[ $name == *['!''*\ *@#/$\"*{^})(+|,;:~`._%&/=-]>[<?']* ]] || [[ $name =~ [0-9] ]]
    do 
      name=$(zenity --entry \
    --title="Invalid Name" \
    --text="Enter Database name Again:" \
    --entry-text "")
    ret=$?

    if (($ret==0))
    then
      :
    else
      source ./main.sh
    fi      
   done
  
   if [ -d ./database/$name ]
   then
      zenity --error \
        --text="Database Already Exists"
      source ./CreateDB.sh
   fi
      mkdir ./database/$name  
       zenity --info \
        --text="Database Is Created Succuflly "
      source ./main.sh 

      
else echo "No name entered"
fi

          