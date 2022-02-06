#!/bin/bash
upurl=`git config -l | grep "remote.origin.url=" | sed "s|remote.origin.url=https://|@|g"`
git clone https://${1}${upurl} uploaddir
cd uploaddir
git config --global user.name "$2"
git config --global user.email "$3"
pl=`ls -d */ | grep -v ".git" | sed "s/  / /g"|sed "s/\///g" | sed 's/^/          - "/g' | sed 's/$/"/g'`
cd ../
for file in uploaddir/.github/workflows/*.yml
do
if [ -f "$file" ]
then
  if [ "${file##*/}" == "update_auto.yml" ]
  then
    echo ""
  elif [ "${file##*/}" == "update_manual.yml" ]
  then
    echo ""
  elif [ "${file##*/}" == "buildOpenWRT_custom.yml" ]
  then
    b=`sed -n "/        description: '路由器资源目录'/{=;}" $file` && head -n ${b} $file > tmp.yml
    echo "$b"
    cat tmp.yml
    echo -e "        options:\n$pl" >> tmp.yml
    sed -n '/repo_.*:/,$p' $file >> tmp.yml
    o=`cat tmp.yml | grep "#  update for"`
    t=$(date "+%Y/%m/%d %H:%M:%S")
    n=`echo "#  update for $t  #"`
    sed -i "s|$o|$n|" tmp.yml
    rm -f uploaddir/.github/workflows/${file##*/}
    cp tmp.yml uploaddir/.github/workflows/${file##*/}
    rm -f tmp.yml
  elif [ -f "$file" ]
  then
    repourl=`cat $file | grep "REPO_URL:" | sed 's/REPO_URL://g' | sed 's/ //g'`
    git clone $repourl branchdir
    cd branchdir
    bl=`git branch -r | grep -v "\->"|grep -v "*"|sed "s|remote/||g"|sed "s|origin/|        - \"|g"|sed "s/$/\"/"` >../tmp.yml
    cd ../
    rm -rf branchdir
    b=`sed -n "/        description: '版本分支'/{=;}" $file` && head -n ${b} $file > tmp.yml
    echo -e "        options:\n$bl" >> tmp.yml
    sed -n '/feeds_file:/,$p' $file >> tmp.yml
    rm -f uploaddir/.github/workflows/${file##*/}
    cp tmp.yml uploaddir/.github/workflows/${file##*/}
    rm -f tmp.yml
    b=`sed -n "/        description: '路由器资源目录'/{=;}" $file` && head -n ${b} $file > tmp.yml
    echo -e "        options:\n$pl" >> tmp.yml
    sed -n '/repo_.*:/,$p' $file >> tmp.yml
    o=`cat tmp.yml | grep "#  update for"`
    t=$(date "+%Y/%m/%d %H:%M:%S")
    n=`echo "#  update for $t  #"`
    sed -i "s|$o|$n|" tmp.yml
    rm -f uploaddir/.github/workflows/${file##*/}
    cp tmp.yml uploaddir/.github/workflows/${file##*/}
    rm -f tmp.yml
    
  fi
fi
done
cd uploaddir
git status && git add . && git commit -m "$4 for $(date "+%Y/%m/%d %H:%M:%S")" && git push
cd ../
rm -rf uploaddir
 
