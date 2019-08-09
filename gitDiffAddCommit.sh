#/bin/bash
#usage : gitDiffAddCommit file

#MODIFIED_FILES_LIST=`git ls-files -m`
#echo $MODIFIED_FILES_LIST

printMsg () {
    echo '##################################################'
    echo $1
    echo '##################################################'
}

gitAddCommit () {
    echo '##################################################'
    echo 'You see the diff ;-), give me your commit message within quotes "msg"'
    echo '##################################################'
    read -r -p "Your message :" msg
    echo '##################################################'
    echo 'Nice thank you, I add your commit with the given message '
    echo '##################################################'
    git add $1
    git commit -m "$msg"
    echo 'done'
}





mapfile -t my_array < <( git ls-files -m )
Length=${#my_array[@]}


if [ $Length -eq 0 ] ;then
    echo There is no modified files in your repo.
    exit
fi

echo '##################################################'
echo "Here is the list  of modified files in your repo ($Length files) :"
echo '##################################################'

COUNTER=0
for oneFile in "${my_array[@]}"
do
    echo File name $COUNTER : $oneFile
    ((COUNTER++))
done


echo '##################################################'
echo 'Now, you can choose one file (enter the number it is easier) '
echo 'or we will loop for each file, enter "l" for the loop '
echo '##################################################'
read rep
if [ "$rep" != "${rep#[lL]}" ] ;then
    for oneFile in "${my_array[@]}"
    do
        echo '##################################################'
        echo "Do you want to see the diff of $oneFile (y/n)?"
        echo '##################################################'
        read answer
        if [ "$answer" != "${answer#[Yy]}" ] ;then
            git diff $oneFile
            echo '##################################################'
            echo "Do you want to add commit this file (y/n)?"
            echo '##################################################'
            read stillYes
            if [ "$stillYes" != "${stillYes#[Yy]}" ] ;then
                gitAddCommit $oneFile
            fi
        fi
    done
else
    if [ "$rep" -gt "$Length" ] ;then
        echo Wrong number, I am furious
        exit
    fi
    echo '##################################################'
    echo you choose ${my_array[$rep]}, here is the diff
    echo '##################################################'
    git diff ${my_array[$rep]}
    echo '##################################################'
    echo "Do you want to add commit this file (y/n)?"
    echo '##################################################'
    read stillYes
    if [ "$stillYes" != "${stillYes#[Yy]}" ] ;then
        gitAddCommit ${my_array[$rep]}
        
    fi
fi


exit



exit




if [ $# -lt 1 ]
then
    echo "usage: ./gitDiffAddCommit.sh file1 "
    exit 0
fi
TO_PRINT="TRUE"

print () {
    if [ $TO_PRINT = "TRUE" ]
    then
        echo $1
    fi
}



git diff $1

echo '##################################################'
echo 'You see the diff ;-), give me your commit message as "message ..." '
echo '##################################################'
read msg
echo '##################################################'
echo 'Nice thank you, I add your commit with the given message '
echo '##################################################'
#git add $1
#git commit -m $msg
