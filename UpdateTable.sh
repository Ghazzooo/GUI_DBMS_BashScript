if [ `ls ./database/$dbname | wc -l` == 0 ]
then
zenity --error \
                --text="Table Not Exist"
      source ./Connect-Menu.sh
fi      

function update()
{
    re='^[0-9]+$'
    tablename=$(zenity --entry \
        --title="Update Tables" \
        --text=" Enter Table Name You Want To Update:" \
        --entry-text "")
    ret=$?
      if (($ret==0)); then
        :
      else
         source ./Connect-Menu.sh
      fi
    #export tablename
    while [[ -z $tablename ]] || [[ $tablebname == *['!''*\ *@#/$\"*{^})(+_/=|,;:~`.%&-]>[<?']* ]] || [[ $tablename == " " ]]
    do 
    tablename=$(zenity --entry \
        --title="Invaled Inpute" \
        --text=" Enter Table Name You Want To Update Again:" \
        --entry-text "")
    
    ret=$?
      if (($ret==0)); then
        :
      else
         source ./Connect-Menu.sh
      fi
    done

    declare -a valueofcnamearray

    if [ -f ./database/$dbname/$tablename ]
    then
     colname=$(zenity --entry \
        --title="You Shouldn't Change Primary Key " \
        --text=" Enter Primary Key Column :" \
        --entry-text "")
        ret=$?
        if (($ret==0)); then
            :
        else
            update
        fi
        #print record number of the pk row
        colno=`awk -F":" '{if ($1=="'$colname'") print NR}' ./database/$dbname/$tablename`
       
        #check that is integer
        if [ -n "$colno" ]
        then 
            record=$(zenity --entry \
            --title="Update Comf" \
            --text=" Enter  Value Of Primary Key :" \
            --entry-text "")
        ret=$?
        if (($ret==0)); then
            :
        else
            update
        fi
            #check if pk exists
            if [[ $record =~ [`cut -d':' -f1 ./database/$dbname/$tablename | grep -x $record`] ]]  
                then              
                #take the new value from user in array
                    for (( j=1 ; j < `cat ./database/$dbname/$tablename.Type | wc -w` ; j++ ))
                    do
                        #put value of pk in first position[0]
                        valueofcnamearray[0]=$record
                        valueofcname=$(zenity --entry \
                                    --title="Update Conf" \
                                    --text=" Enter Value Of `head -n 1 ./database/$dbname/$tablename | cut -f $((j+1)) -d ":"` column: " \
                                    --entry-text "")
                        ret=$?
                        if (($ret==0)); then
                            :
                        else
                            update
                        fi
                        ## check datatype of record
                        function checkdatatype()
                        {
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
                                ret=$?
                                if (($ret==0)); then
                                    :
                                else
                                    update
                                fi
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
                                ret=$?
                                if (($ret==0)); then
                                    :
                                else
                                    update
                                fi
                            done
                        fi
                        }
                        checkdatatype                        
                        valueofcnamearray[$j]=${valueofcname}       
                    done  
                    #delete the old record then insert the new one
                    recordnumber=`awk -F":" '{if ($1=="'$record'") print NR}' ./database/$dbname/$tablename`  
                    sed -i ''$recordnumber'd' ./database/$dbname/$tablename            
                     
                     #take the array and pass it to the file
                     #Array to count number of columns
                     for (( j=0 ; j < `cat ./database/$dbname/$tablename.Type | wc -w` ; j++ ))
                     do
                        echo -ne "${valueofcnamearray[$j]}:" >> ./database/$dbname/$tablename
                     done
                     echo "" >> ./database/$dbname/$tablename   
                     zenity --info \
                                    --text="Value Changes Successfully"             
                     source ./Connect-Menu.sh
            else
                zenity --error \
                                --text="Value Not Exist" 
                update 
            fi   
        else
        zenity --error \
                        --text="Wrong Column"
            update
        fi

    else
        zenity --error \
                        --text="Table Not Exist"
        update
    fi
    }
update    #calling update function
