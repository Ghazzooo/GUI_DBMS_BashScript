if [ `ls ./database/ | wc -l` == 0 ]
then  
    zenity --error \
        --text="Could not find Database"
    source ./main.sh
else
    zenity --info \
        --text="$(ls -I "*Type" ./database)"
     source ./main.sh
fi