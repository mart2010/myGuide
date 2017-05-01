
start ipython with notebook
ipython notebook
#start with inline graphs
ipython notebook --pylab inline

#getting help, or more help from notebook
obj?, obj??  (?obj works as well)

#list name in foo contaning 'abc' in them
?foo.*abc*

#get info no ipython *magic* functions
%magic

#magic function typcially takes argument without parenthesis, quotes or evens commas 
#a single line magic function
%funct 
#a cell magic 
%%funct
other commands...

#ex of magic functions calls
%alias d ls -F  (d is now alias for 'ls -F'

#cd works directly 
cd /usr/share 
#to choose from drop-down visited dirs
cd -<tab> 

#time some commands to execute
%timeit x=10
#time with excluding the set-up execution time
%%timeit x=setupcpde
x**100

#system commands
!cp a.txt b/
#can even do variable expansion from python var
!cp ${varx}.txt $bar
#even capture system cmd output
files = !ls /usr


#TAB auto-completion
#Will work for many contexts like file names, python names, etc..  just try it!

