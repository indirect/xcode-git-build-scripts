# Xcode git autocommit script by Andre Arko
#   This script will automatically commit any changed files to the project's
#   git repository, in the branch "builds"

# If you use this script, you can create more typical commits in the master
# branch with the commands:
#   git checkout master
#   git checkout builds .
#   git commit -m "Description of changes since last commit to master"

if [ -z "`git branch | grep builds`" ]; then
  git co -b builds
else
  git co builds
fi

git add .
git commit -a -m "`date +'Build on %F at %r'`"
# ignore git-commit exiting >0, since nothing to commit is fine
exit 0