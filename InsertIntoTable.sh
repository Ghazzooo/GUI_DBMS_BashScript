if [ `ls ./database/$dbname | wc -l` == 0 ]
then
    zenity --error \
        --text="No Table Found"
      source ./Connect-Menu.sh
      
fi      
if tablename=$(zenity --entry \
--title="Insert Into Table" \
--text="Enter Table You Want To Insert :" \
--entry-text "")
then 
    #-----------------------------
   ret=$?
        if (($ret == 0 )); then
            :
        else
            source ./Connect-Menu.sh
        fi
    re='^[0-9]+$'
    while [[ -z $tablename ]] || [[ $tablename == *['!''*\ *@#/$\"*{^})(+_/|,;:~`.%&.=-]>[<?']* ]] || [[ $tablename == " " ]] || [[ $tablename =~ [0-9] ]]
    do 
        tablename=$(zenity --entry \
        --title="Invaled Input Must Be Characters" \
        --text="Please Enter Table Name Again:" \
        --entry-text "")
        #====================================
        ret=$?
        if (($ret == 0 )); then
            :
        else
            source ./Connect-Menu.sh
        fi

    done
    declare -a valueofcnamearray
    ##export dbname
    if [ -f ./database/$dbname/$tablename ]
    then
        zenity --warning \
         --text="Primary Key Must Be Unique " 
        #iterate on tablename.type to know the number of fields to insert in it
    
        for (( j=0 ; j < `cat ./database/$dbname/$tablename.Type | wc -w` ; j++ ))
        do
            valueofcname=$(zenity --entry \
                                    --title="Insert Into Table" \
                                    --text=" Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column : " \
                                    --entry-text "")

#==========================================================================
            
        ## check datatype of record
        function checkdatatype()
        {
            #know the datatype of the column in the table type
                datatype=`cut -f $((j+1)) -d " " ./database/$dbname/$tablename.Type`
        ###check if value is integer

        if [[ "$datatype" == "int" ]] 
        then 
            while ! [[ $valueofcname =~ $re ]]
            do
                valueofcname=$(zenity --entry \
                                    --title="Column Must Be Intger" \
                                    --text=" Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column : " \
                                    --entry-text "")
                
        
            done
        fi
        ###check if value is string
        if [[ "$datatype" == "string" ]] 
        then 
            while  [[ $valueofcname =~ $re ]] || [[ -z $valueofcname ]] || [[ $valueofcname == *['!''@#/$\"*{^})(+_/=-]>[<?']* ]]
                do
                    valueofcname=$(zenity --entry \
                                    --title="Column Must Be String" \
                                    --text=" Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column : " \
                                    --entry-text "")
                   
                done
            fi
            }
            ###########check primary key
            function checkpk()
            {
            pkvalue=`cut -f 1 -d ":" ./database/$dbname/$tablename | grep -w $valueofcname`
            #check that pkvalue = input value of colname ,,&&,, check that it belong in the first column onlyyyyy
            while [[ $pkvalue == $valueofcname ]] && [[ $j == 0 ]]
            do 
                valueofcname=$(zenity --entry \
                                    --title="This Value Is Already Exists" \
                                    --text=" Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column : " \
                                    --entry-text "")
            done 

            }
            checkdatatype
            checkpk
                #insert values of array
            valueofcnamearray[$j]=$valueofcname
        done

    #take the array and pass it to the file
        for (( j=0 ; j < `cat ./database/$dbname/$tablename.Type | wc -w` ; j++ ))
        do
            echo -ne "${valueofcnamearray[$j]}:" >> ./database/$dbname/$tablename
        done
            echo "" >> ./database/$dbname/$tablename
    else    
            zenity --error \
                --text="Table Not Exists "
            
            source ./InsertIntoTable.sh
    fi

   zenity --info \
                --text="Insertion Complete "
    source ./Connect-Menu.sh
    
else echo "No name entered"
fi



    
