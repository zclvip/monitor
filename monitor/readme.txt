说用说明：
  1.  可以更改tomcatId=$(ps -ef |grep java|grep -v grep |awk '{print $2}'); 为查找自己的进程id的方法
  2.调用./monitor.sh时候传入cpu预警值，如果不传默认是30，即cpu超过30%时候打印线程堆栈日志
  3.线程日志存在当天为单位的文件夹内，文件内容以jstack[cpu值]-[thread16位id]-[日期]_时分秒，如jstack0.0-2468-20160719_093714.txt
  4.crontab实现每隔一秒调用monitor.sh来监控进程的cpu情况