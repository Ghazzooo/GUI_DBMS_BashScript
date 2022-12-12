declare -a cnamearray 
declare -a ctypearray 
re='^[0-9]+$'

if tbname=$(zenity --entry \
--title="Create Table" \
--text="Enter Table name:" \
--entry-text "")
then
   while [[ -z $tbname ]] || [[ $tbname == *['!''*\ *@#/$\"*{^})(+_/|,;:~`.%&.=-]>[<?']* ]] || [[ $tbname =~ [0-9]  ]] || [[ $tbname == " " ]]
   do 
      tbname=$(zenity --entry \
            --title="It Must Be Only Characters" \
            --text="PLease Enter Database Name Again : " \ 
            --entry-text "" )
      exitstatus=$?
         if [ $exitstatus = 0 ]; then
            :
         else
            source ./Connect-Menu.sh
         fi
   done

   while [ -f ./database/$dbname/$tbname ] 
   do
      zenity --error \
         --text="Table Is Already Exists"
      source ./Connect-Menu.sh
   done
   #read column number from user
   cnumber=$(zenity --entry \
   --title="Create Table" \
   --text="Enter Number Of Columns : " \
   --entry-text "")

   exitstatus=$?
         if [ $exitstatus = 0 ]; then
            :
         else
         rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type 
            source ./Connect-Menu.sh
         fi
   # function to check validation of cnumber
   function valcnumber()
   {
   while [[ -z $cnumber ]] || [[ $cnumber == *['!''*\ *@#/$\"*{^})(+_/|,;:~`.%&.=-]>[<?']* ]] || [[ $cnumber =~ [a-zA-Z] ]] || [[ $tbname == " " ]]
   do 
      cnumber=$(zenity --entry \
            --title="Invalid Input It Must Be A Number" \
            --text="PLease Enter Number Of Columns Again : " \ 
            --entry-text "" )
      
   exitstatus=$?
         if [ $exitstatus = 0 ]; then
            :
         else
         rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
            source ./Connect-Menu.sh
         fi
   done

   }
   valcnumber                    #calling function
   export cnumber
   zenity --warning \
         --text="First Column Must Be Primary Key " 
   touch ./database/$dbname/$tbname ./database/$dbname/$tbname.Type 
   # to enter the columns name with input column numbers
   for (( i=0 ; i < $cnumber ; i++ ))
   do
   cname=$(zenity --entry \
         --title="Create Table" \
         --text="Enter Name Of Column $((i+1)): " \
         --entry-text "")
   #-------------------------------------------
   exitstatus=$?
         if [ $exitstatus = 0 ]; then
            :
         else
         rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
            source ./Connect-Menu.sh
         fi
   while [[ -z $cname ]] || [[ $cname == *['!''*\ *@#/$\"*{^})(+_/|,;:~`.%&=-]>[<?']* ]] || [[ $cname =~ $re ]] || [[ $tbname == " " ]]
   do 
      cname=$(zenity --entry \
            --title="Invalid Input" \
            --text="Enter Name Of Column Again : " \
            --entry-text "")
      #-------------------------------------------------
      exitstatus=$?
         if [ $exitstatus = 0 ]; then
            :
         else
         rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
            source ./Connect-Menu.sh
         fi
   done
   
   ##### check if the cname is exists or not 
   while [[ "${cnamearray[$tbname]}" =~ "$cname" ]]
   do
      cname=$(zenity --entry \
            --title="This Name Is Already Exists" \
            --text="Enter Name Of Column Again : " \
            --entry-text "")
      #-------------------------------------
      exitstatus=$?
         if [ $exitstatus = 0 ]; then
            :
         else
         rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
            source ./Connect-Menu.sh
         fi
   done
      #enter datatype 
      ctype=$(zenity --entry \
         --title="Create Table" \
         --text="Enter DataType Of Column $((i+1)): [string/int] " \
         --entry-text "")
      #----------------------------------------
      exitstatus=$?
         if [ $exitstatus = 0 ]; then
            :
         else
         rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
            source ./Connect-Menu.sh
         fi
   
   #check on datatype
   while [[ $ctype != int ]] && [[ $ctype != string ]] 
   do
   ctype=$(zenity --entry \
         --title="Invalid DataType" \
         --text="Enter DataType Of Column $((i+1)): [string/int] " \
         --entry-text "")
   #-----------------------------------------------------------
   exitstatus=$?
         if [ $exitstatus = 0 ]; then
            :
         else
         rm ./database/$dbname/$tbname ./database/$dbname/$tbname.Type
            source ./Connect-Menu.sh
         fi
   done
         
         cnamearray[$i]=$cname
         ctypearray[$i]=$ctype
   done
   #put delimeter
   for (( i=0 ; i < $cnumber ; i++ ))
   do
   echo -ne "${cnamearray[$i]}:" >> ./database/$dbname/$tbname
   done
   echo "" >> ./database/$dbname/$tbname
   ##Append data to table and tabletype
   echo ${ctypearray[@]} >> ./database/$dbname/$tbname.Type
   zenity --info \
         --text="Congratulations Your Table Is Created " 
   source ./Connect-Menu.sh


         
else echo "No name entered"
fi
#--------------------------------------------




