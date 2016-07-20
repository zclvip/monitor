step=1
 #间隔的秒数，不能大于60  
  
for (( i = 0; i < 6000; i=(i+step) )); do  
    sh monitor.sh  
    sleep $step  
done  
  
exit 0  
