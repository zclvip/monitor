
tomcatId=$(ps -ef |grep tomcat |grep -v grep |awk '{print $2}');
echo 'tomcatid:'$tomcatId


filename=$(date -d "today" +"%Y%m%d_%H%M%S").txt;
echo $filename;
today2=`date --date='0 days ago' +%Y-%m-%d`;

echo 'today:'$today2;

if [ ! -d "$today2" ]; then
 echo 'need to make'
 mkdir $today2; 
fi 
chmod -R 755 $today2;


top_filename='top_'$filename.log;
top_filename=$today2'/'$top_filename;
echo 'top_filename:'$top_filename
top -b -d 1 -n 1 -Hp $tomcatId|grep java >> $top_filename;
sort -n -r -k9 $top_filename |awk 'NR==1{print $9}'
cpu=$(sort -n -r -k9 $top_filename |awk 'NR==1{print $9}');
echo 'cpu:'$cpu;
threadid=$(sort -n -r -k9 $top_filename |awk 'NR==1{print $1}');
echo 'threadid'$threadid;

thread_16=$(echo 'ibase=10;obase=16;'$threadid|bc);
echo $thread_16


echo 'threadid'$thread_16;
 

jstackfilename=jstack$cpu'-'$thread_16'-'$filename;
jstackfilename=$today2'/'$jstackfilename;
echo 'jstackfilename:'$jstackfilename

touch $jstackfilename;
chmod -R 755 $jstackfilename;

echo "threadid:"$thread_16;

if [ ! -n "$1" ] ;then
    echo "you have not input a word!"
    cpuMax=30;  
else
    echo "the word you input is $1";
    cpuMax=$1;
fi
#cpuMax=$1;
#cpu=20;
#cpuMax=10;

echo 'cpuMax:'$cpuMax;
echo 'cpu:'$cpu;


echo|awk '{if("'$cpuMax'"<="'$cpu'")system("/usr/local/java/jdk1.7.0_79/bin/jstack "'$tomcatId'" | grep -A 10 -B 10 '$thread_16' >> \"'$jstackfilename'\"");else print "no data"}';




rm -rf $top_filename;
jstackSize=$(ls -l $jstackfilename|awk '{print $5}');
echo 'size'$jstackSize;
 if [ $jstackSize -eq 0 ] ; then
 echo 'remove:'$jstackfilename
  rm -rf $jstackfilename
fi


