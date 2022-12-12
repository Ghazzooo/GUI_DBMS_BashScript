if [ `ls ./database/ | wc -l` == 0 ]
then
       zenity --error \
        --text="Could not find Database"
      source ./main.sh
fi      
if name=$(zenity --entry \
      --title="Drop Database" \
      --text="Which Database Do You Want To Drop ?" \
      --entry-text "")
then
   ret=$?
      if (($ret == 0 )); then
         :
      else
         source ./main.sh
      fi
   while [[ ! -d ./database/$name ]] || [[ -z $name ]] || [[ $name == *['!''*\ *@#/$\"*{^})(+_/|,;:~`.%&.=-]>[<?']* ]] || [[ $tablename == " " ]] || [[ $tablename =~ [0-9] ]]
   do
         name=$(zenity --entry \
         --title="Invalid Input" \
         --text="PLease Enter Database Name Again :" \
         --entry-text "")
         
      ret=$?
      if (($ret == 0 )); then
         :
      else
         source ./main.sh
      fi
   done
   while [[ -d ./database/$name ]]
   do  
      
      if zenity --question \
         --text="Are you sure you wish to proceed?"; 
      then
         rm -r ./database/$name 
         zenity --info \
        --text="Database Is Droped " 
         source ./main.sh
      else
         zenity --error \
        --text="Database Not Exists"
         source ./main.sh
      fi 
   done
else echo "No name entered"
fi