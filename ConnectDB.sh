if [ `ls ./database/ | wc -l` == 0 ]
then
       zenity --error \
        --text="Database Not Found"
      source ./main.sh
fi     
dbname=$(zenity --entry \
   --title="Connect Database" \
   --text="Enter Database You Want To Connect: " \
   --entry-text "")
ret=$?

if (($ret==0)); then
   :
else
   source ./main.sh
fi
export dbname
if [[ ! -d ./database/$dbname ]] || [[ -z $dbname ]]
then  
      zenity --error \
        --text="Database Not Exists"
      ret=$?

     

      

else
      zenity --info \
        --text="Database Exists "
      source ./Connect-Menu.sh
      
fi

 