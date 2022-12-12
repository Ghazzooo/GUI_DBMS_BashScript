      if [ `ls ./database/$dbname | wc -l` == 0 ]
      then
      zenity --error \
        --text="Could not find Table"
      source ./Connect-Menu.sh
fi      
if tbname=$(zenity --entry \
   --title="Drop Tables" \
   --text="Which Table Do You Want To Drop ?" \
   --entry-text "")
then
   #========================================
   exitstatus=$?
         if [ $exitstatus = 0 ]; then
            :
         else
            source ./Connect-Menu.sh
         fi
   while [[ ! -f ./database/$dbname/$tbname ]] || [[ -z $tbname ]]
   do
   tbname=$(zenity --entry \
         --title="Invalid Input" \
         --text="PLease Enter Valid Name Of Table : " \ 
         --entry-text "" )
         #=====================
   exitstatus=$?
         if [ $exitstatus = 0 ]; then
            :
         else
            source ./Connect-Menu.sh
         fi
   done

   while [[ -f ./database/$dbname/$tbname ]]
   do   
   if zenity --question \
         --text="Are you sure you wish to proceed?"; 
      then
         rm ./database/$dbname/$tbname 
         rm ./database/$dbname/$tbname.Type
          zenity --info \
        --text="Table Is Droped "
         source ./Connect-Menu.sh
   else
          zenity --error \
        --text="Table Not Exist "
         source ./Connect-Menu.sh
   fi
   done
else echo "No name entered"
fi