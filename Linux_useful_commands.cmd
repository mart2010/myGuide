


####################### Tar command ###############################
#(tar being an old command, it also work without the hyphen)

# Create a new compressed Tar from all data found in dirX
tar -czvf archive.tar.gz ./dirX/*

# Extract from an existing tar archives
tar -xvf archive.tar

# View only what's in the archive
tar -tvf archive.tar

####################### Grep command ##############################
# Search a given string "str" in a file
grep -i "str" fileX

# Print the matched line along with 3 lines after it
grep -A 3 -i "str" fileX

# Search for a given string in all files recursively
grep -r "str" *




####################### Find command ##############################

# find exact file name, case  insensitive
find . -iname "myfile.txt"

# Execute some commands on all files found 
# will remove only files with given pattern (safer to include -type f to avoid removing dir..)
find . -type f -name "file*.jpg" -exec rm -f {} \;
   
# find all empty files in home dir
find ~ -empty

#find all files but only in current dir, that were modified in the past 2 days
find . -type f -maxdepth 0 -mtime -2

#find all *.txt files that were modified over 1 year ago or more (under current dir)
find . -name "*.txt" -mtime +365


####################### SSH command ##############################
# login to remote host
ssh -l login_name remotehost.example.com
# probably same as?:
ssh login_name@remotehost.example.com

# debug ssh client
ssh -v -l login_name@remotehost.example.com

# display ssh client version 
ssh -V



####################### sed command ##############################
# sed is a stream editor to perform basic text transfo (from file or input pipeline)
#display only a range of lines in file (ex. line 300 to 400)
sed -n  300,400p file.txt

# delete line 1-10 and 15 from file and create backup (.bak)
sed -i.bak -e '1,10d;15d' file.txt

# convert DOS text filename to Unix (carefule this uses: $ and not S)
sed 's/.$//' filename.txt

# print file content in reverse order
sed -n '1!G;h;$p' filename.txt

# add  line number to all non-empty lines in a file
sed '/./=' filename.txt | sed 'N; s/\n/ /'



####################### awk command ##############################
# awk is a utility/language designed for data extraction
# remove all duplicate line 
awk '!($0 in array) { array[$0]; print }' temp.txt

# print all lines from /etc/password that has same uid and gid
awk -F ':' '$3==$4' passwd.txt

# print only the specified field from file
awk '{print $2,$5;}' employee.txt



####################### vim command ##############################

# go to line 333 in file.txt
vim +333 file.txt

# go to the first match of search-term in file.txt
vim +/search-term file.txt

# open in read-only mode
vim -R /etc/passwd



####################### diff command ##############################
# compare file and ignore white space
diff -w name1.txt name2.txt




####################### sort command ##############################

# sort a file in descending order
sort -r names.txt

# sort by 3rd field
sort -t: -k 3n /etc/passwd | more




####################### export command ##############################

# to view oracle related env variables
export | grep ORACLE

# export one env variable
export ORACLE_HOME="path..."



####################### xargs command ##############################
# copy all images to external drive
ls *.jpg | xargs -n1 -i cp {} /external/drive/dir

# search all jpg images in system and archive it
find / -name *.jpg -type f print | xargs tar -cvzf images.tar.hz

#download all URLs listed in file
cat url-list.txt | xargs wget -c


####################### cd command ##############################

#to toggle between two directories
cd -


####################### shutdown command ##############################
#shutdown immediately
shutdown -h now

#shotdown in 10minutes
shutdown -h +10

#reboot the system now
shutdown -r now

#force filesystem check during reboot
shutdown -Fr now

####################### service command ##############################
# service cmd used to run the system V init scripts (instead of executing /etc/init.d scripts explicitely)
#check status of a service (ex. ssh)
service ssh status

#of all sercices
service --status-all

#restart a service
service ssh restart


####################### ps, top and other process command ##############################
#show all process hierarchically
ps -efH | more

# to see top (CPU usage) process running
top 
(press O) to sort by other columns
# displays only processes belonging to one user
top -u oracle

#kill a particular process immediately (send signal)
kill -9 7243

#kill all processes sharing same name
killall -9 firefox

#kill process by name (no need to get pid prior)
pkill sample


####################### df command ##############################
# show filesystem disk usage in human readable format and type
df -hT


####################### cp and mv command ##############################
# cp file1 while keeping its mode, ownership and timestamp
cp - p file1 file2

#move (rename if same loc) file interactively (will prompt before overwrite existing)
mv -i file1 file2


####################### cat command ##############################
#display multiple files content 
cat file1 file2 

#display file content with line number
cat -n file1


####################### mount command ##############################
#first create a new dir, and mount a file system to it 
mkdir newdir
mount /dev/sdb1 /newdir

# add this line into the fstab for automatic mounting at system restart

/dev/sdb1 /u01 ext2 defaults 0 2


####################### chmod & chown commands ##############################
#give/revoke full access to user & group
chmod ug+rwx file
chmod ug-rwx file

#apply the file permission change recursively to all files in sub-dirs
chmod -R ug+r dir1

#change owner to oracle and group to dba
chown oracle:dba file

#change ownership recursively
chown -R oracle:dba dir


####################### getting information  ##############################
#shows important info: kernel name, kernel release number, host name, processor type 
uname -a

#to know where is located a specific command
whereis ls

#to search for an executable from other path than the one given by whereis (or which)
#use the -B option to provide this other potentiel alternative
#this searches for the executable lsmk in the /tmp and display if found
whereis -u -B /tmp -f lsmk

#to display a single line description of a command
whatis ls

####################### locate command ##############################
#search for location of specific files using database 'updateddb'
#show all files in the system contaning the word crontab in it
locate crontab


###################### /etc/hosts #########################
#useful to alias an IP host 
123.13.33.3 desktop


