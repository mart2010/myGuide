#getting help:
git help <verb> (or git <verb> --help)

#git config is located in these places with each level overwriting previous
1. /etc/gitconfig (may not be present)
2. ~/.gitconfig (or ~/.config/git/config) 
3. .git/config in a Git repo dir (config specific to this repo) 

#list current config (based on current dir.., would show overwritten param at current proj dir)
git config --list

#most important config is your identity, and it can be set with (use --local for current locallrep ):
git config --global user.name "John Smith"
git config --global user.email j@ex.com

#chaning the default editor (used, for ex, when editing commit message) 
git config --global core.editor emacs 

# initial command to create a git repo to track current dir as project (will create the db repo under /.git)
git init


#init a new repo from a server (mylibgit is optional when you want target dir to be named differently)

git clone https://github.com/libgit2/libgit2 mylibgit



# adding files to index (more precisely staging specified file(s) or dir for upcoming commit) 
git add *.c
git add readme.txt
git add 

#getting current status of working dir
git status


#exluding file from repo is done by editing .gitignore file
cat .gitignore
*.[oa]    (ignore all files terminating by o or a)
*~        (all files terminating by ~)
!lib.a    (but do track lib.a  ... ! is used to negate a pattern)
build/    (ignore all files under build dir)


# git diff



# lifecycle of files under a git repo is:  
'Untracked'  (files not yet considered in repo but found un working dir.. must git add to change this state)
'Unmodified' (files tracked down but with no changes in woring dir)
'Modified' (files tracked down with changes not yet staged)
'Staged' (files tracked down indexed and ready for next commit)


# give the current changes in working dir not yet staged
git diff

# gives what are the changes staged (compared to most recent commit), i.e. what will go into the next commit
git diff --staged (or --cached which is the same as --staged)


# commit all that is staged
git commit (will promt with editor to edit the commit message)
git commit -m "inline commit message"

# convenient commit that also 'git add' all changes files before committing
git commit -m -a "commit with -a is a way to avoid doing explicit 'git add'"

# remove the file both from repo and from working dir"
git rm filetoremove

#remove the file from staged repo but leave it in working dir 
#useful when file was added before being exluded with .gitignore (was indexed accidently)
git rm --cached README


#renaming file
git mv readme.md README
#this is equivalent to:
mv readme.md README
git rm readme.md
git add README

#viewing the commit history
git log  (use -p showing the diff introduced in each commit, use -2 to only show 2 last changes)


#UNDOING things

#to modify previous commit (in this case because we forgot to stage a file)
# we use --amend (could be used to change commit message, more interestingly to combine new staged stages with previous commit..instead of commiting enire new snapshot ) 
git add forgotFile
git commit --amend

#Git reset changes the snapshot history, so should only be aplied locally:  NEVER use git reset <commit> after <commit> have been pushed to a public repository

#reset the staging area to match the most recent commit while leaving working dir unchanged
#this gives the opportunity to re-build the staged snapshot from scratch
git reset 

#same but only remove specified file from staging area...  
git reset specifiedFile


#if you want to reset as well working dir to match most recent commit (WILL OVERWRITE ALL uncommitted CHANGES IN WORKIND DIR)
git reset --hard


#to unstage a file (to avoid including it in the next commit)
git reset HEAD fileToDestage

#to abandon completely your local changes with commits and replace by latest commit on origin for branch dev.
git reset --hard origin/dev


# move the current branch backward (at the <commitNo>) while leaving unchanged working dir, so you can re-commit project history with cleaner/simpler snapshot
git reset <commitNo> 

#same but combined with a new commmit, resulting in "squashing" last 4 commits into a single new commit (only possible when staged/index files are at latest state as reset leaves the stage in the desired state for your new commit (i.e. it already has all the changes from the commits that you are about to “throw away”).
git reset --soft HEAD~4 &&
git commit -m "networkw message"




#to discard local changes (a modified file in working-dir) and revert it to the last commit
#to be used cautiously as any changes done on local file are lost permanently
git checkout -- FileToRevert

#Working with Remotes
(remote repos are version of the project hosted outside in diff network. ) 

#Listing which servers are configured (-v shows the url as wel, otherwise give the shortname given by GIT 
git remote -v

origin https://address.of.origin.repos.com

#by default Git uses shortname 'origin' for the url used to download a new repos project with 'git clone..'
#a local repo can have multiple remotes, so that your project can use different collaborators works (ex. diff libs)
#you may have diff push privilege on each of these remotes

#ex. add a new remote Git repo with shortname 'pb' 
git remote add pb https://....

#go fecth all data from this 'pb' repo that you dont have yet in your repo
git fetch pb
#will be stored under 'pb' dir
#when you clone a project, it automatically adds the remote repos under the name 'origin'
#to refresh the project with any new work that has been pushed to that server (but will not merge your work if you have
#modified files..this needs to be merged manually by you 
git fetch origin

#if you have a branch set up to track a remote branch use 'pull' to fetch and then merge the remote branch to your local 
git pull

#by default git pull does a 'merge' (after git fetch), so this will create a superflous "merge commit" node to the
#history.  For simple workflow, where you want to push your changes, best is to avoid this use a git --rebase which will
#merge your changes by "appending" your commit to the master branch. Then you can push ..
git pull --rebase origin master


#another useful feature of rebase is to reorganize your commits history...
#for ex. if you want to group your last 4 commits done locally into 1 commit:
git rebase -i HEAD~4

#you'll get the chance to either pick (choose wich to keep), squash (group other commits to the one 
#chose) or edit each commts
#once you flagged each of these you will also be able to edit the commit message.
#to manage conflict of your squash: correct the conflict, use git add, and then git rebase --continue to resume
#you can always abort your rebase with
git rebase --abort



#pushing to remote allows you to share your project. You can push your master branch to your origin server 
#cloning will have set these two names automatically), assuming you have the rights and nobody has pushed works meantime
git push origin master

#to get more info about a particular remote ('origin' in that case).  Will give the HEAD branch name and others
git remote show origin


#Branch
#Git knows which branch you're currently on using the HEAD special pointer (HEAD is just a pointer to the local branch
# yuo are currenlty on

#to create a new branch (this DOES not switch HEAD to that branch) at the same commit you are currently on
git branch testing

#to see branch pointers are pointing which log (ie. which commit)
git log --oneline --decorate

#to switch to a different existing branch (HEAD will now point to testing branch) 
git checkout testing

#to swicth back to Master (HEAD pointer) and revert local files in working dir to Master current snapshot 
git checkout master
#Important: when switching branches, Git resets working dir to look like it did last time you committed on that branch

#to delete a branch, ex. after having it merged with Master, so it is no longer used
git branch -d hotfix
`

#Merging branch can be done in two ways: Merge or Rebase 
#1- Merge does a 3-way merge betweem two branch (latest snapshot) and the common ancestor of the two



#2- Rebase work by applying all the changes done on branch 'experiment' on top of 'master' (the one you're rebasing onto))
git checkout experiment
git rebase master

#with that git will go to a common ancestor to both branch, getting the diff introduced by each commit of the branch you’re on,
#saving those diffs to temporary files, resetting the current branch to the same commit as the branch you are
#rebasing onto, and finally applying each change in turn

#Now you can go back to Master and do a fast-forward merging
git checkout master
git merge experiment

###todo: merge ex.   and discuss differences



#to delete the remote reference by origin from local repoy
git remote remove origin
#to remove the server-side repo, you need to ssh on the server:
ssh bbpgit.epfl.ch delete rm user/mouellet/notebook-experiment




###################### the NPI process with code Review ########################

# edit my files locally
...
#commit
git commit -m "msg"

# reorganizing the commits and messages
git rebase -i origin/dev

# push for review
git review -R

# correct code after review
...
# adding all modifications
git add . --all

# commiting and sending back for review again
git commit -a --amend
git review

################################################################################




  




