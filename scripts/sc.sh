#!/bin/bash

DIRS=($(ls -d */))
CUR=$(pwd)

for i in ${DIRS[@]}; do
   
   cd $i
   echo sync_push.sh >> .gitignore
   cat << EOF > sync_push.sh
#!/bin/bash

HOME_BRANCH=\$1
REMOTE_WORK=origin
REMOTE_HOME=gh

git fetch --all
git checkout master
git pull
git branch --track \$HOME_BRANCH \$REMOTE_HOME/\$HOME_BRANCH
git checkout \$HOME_BRANCH
git pull \$REMOTE_HOME \$HOME_BRANCH:\$HOME_BRANCH
git push -u \$REMOTE_WORK \$HOME_BRANCH
EOF
   chmod +x sync_push.sh

   git fetch --all
   git switch refactor
   
   name=${i%/}
   git remote add gh git@github.com:alexandr170288/$name.git
   cd $CUR
done
