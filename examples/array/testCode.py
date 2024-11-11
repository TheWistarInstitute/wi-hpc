import os, sys
from string import *
import datetime

cnt=sys.argv[1] # Iteration 
n=sys.argv[2] # which array set
pth=sys.argv[3] # Output path
n1=sys.argv[4] # Array id

fw=open(pth+"/results.txt","a")
now = datetime.datetime.now()
fw.write("Started Running Array "+str(n)+" "+n1+"  "+now.strftime("%Y-%m-%d %H:%M:%S")+"\n")
j=0
for i in range(0,int(cnt)):
    j+=1
now = datetime.datetime.now()
fw.write("Completed Running Array "+str(n)+" "+n1+" "+now.strftime("%Y-%m-%d %H:%M:%S")+"\n")
fw.close()





