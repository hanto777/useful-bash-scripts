#/bin/bash
#usage : gitAddCommit file

#MODIFIED_FILES_LIST=`git ls-files -m`
#echo $MODIFIED_FILES_LIST

if [ $# -lt 1 ]
then
    echo "usage: ./gitAddCommit.sh file1 "
    exit 0
fi

gitAddCommit () {
    echo '##################################################'
    echo 'You see the content ;-), give me your commit message within quotes "msg"'
    echo '##################################################'
    read -r -p "Your message :" msg
    echo '##################################################'
    echo 'Nice thank you, I add your commit with the given message '
    echo '##################################################'
    echo "$msg"
    git add $1
    git commit -m "$msg"
    echo 'done'
}


more $1
echo '##################################################'
echo "Do you want to add commit $1 (y/n)?"
echo '##################################################'
read stillYes
if [ "$stillYes" != "${stillYes#[Yy]}" ] ;then
    gitAddCommit $1
fi

