#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
 stty erase '^H'
# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install mysql cluster"
    exit 1
fi
clear
echo "=================================================================================="
echo "mysql cluster 7.3.5  xjq for centos/redhat linux !!!!!!!!!!!!!!!!"
echo "Send me email if you have any questions  : x.ue2008@163.com or 1362832155(qq) "
echo "Before installation,please read readme!!!! "
echo "=================================================================================="
my_dir=$(pwd)
long_bit=$(getconf LONG_BIT)
get_char()
	{
	SAVEDSTTY=`stty -g`
	stty -echo
	stty cbreak
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	stty -raw
	stty echo
	stty $SAVEDSTTY
	}
	echo ""
	echo "Press any key to start...or Press Ctrl+c to cancel"
	char=`get_char`

if [ -s ./mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz ]; then
	  echo "mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz  [found]"
	else
	  echo "mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz  not found!!!Now downloading .......... "
 	 wget  http://dev.mysql.com/get/Downloads/MySQL-Cluster-7.3/mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz	
fi
while :
do
read -p "Please enter the IP management node:" mgmIp	
	if [ ! -n "$mgmIp" ];then
		echo "The management node IP is null,please inputt again"
	else
	break 
	fi
done

while :
do
read -p "Please enter the IP data     node 1:" dataMIp1	
	if [ ! -n "$dataMIp1" ];then
		echo "The data node IP 1 is null ,please input again"
	else
	break
	fi
done

while :
do
read -p "Please enter the IP data     node 2:" dataMIp2	
	if [ ! -n "$dataMIp2" ];then
		echo "The data node IP 2 is null ,please input again"
	else
	break
	fi
done


while :
do
read -p "Please enter the IP sql     node 1:" sqlMIp1	
	if [ ! -n "$sqlMIp1" ];then
		echo "The sql node IP 1 is null ,please input again"
	else
	break
	fi
done
while :
do
read -p "Please enter the IP sql     node 2:" sqlMIp2	
	if [ ! -n "$sqlMIp2" ];then
		echo "The  sql node IP 2 is null ,please input again"
	else
	break
	fi
done
echo ""
echo ""

		echo "The management     node IP is: $mgmIp"
		echo "The  data        node IP 1 is: $dataMIp1" 
		echo "The  data        node IP 2 is: $dataMIp2" 
		echo "The  sql         node IP 1 is: $sqlMIp1" 
		echo "The  sql         node IP 2 is: $sqlMIp2" 

echo "The mysql_cluster  start install"
	get_char()
        {
        SAVEDSTTY=`stty -g`
        stty -echo
        stty cbreak
        dd if=/dev/tty bs=1 count=1 2> /dev/null
        stty -raw
        stty echo
        stty $SAVEDSTTY
        }
        echo ""
        echo "Press any key to start The mysql_cluster start install or Press Ctrl+c to cancel"
        char=`get_char`

function installInit()
{	echo "Generate the local public and private keys!!"
	echo "ssh-keygen -t rsa -b 2048"
	/usr/bin/ssh-keygen -t rsa -b 2048 		
	 ssh-copy-id -i  $mgmIp
	 ssh-copy-id -i  $dataMIp1
	 ssh-copy-id -i  $dataMIp2
	 ssh-copy-id -i  $sqlMIp1
	 ssh-copy-id -i	 $sqlMIp2	
		
	#mgm
	 ssh  $mgmIp "yum makecache"
	 ssh  $mgmIp "yum -y remove mysql mysql-devel"
	 ssh  $mgmIp "groupadd mysql && useradd -g mysql mysql && chkconfig iptables off && service iptables stop "
	 ssh  $mgmIp "sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config"
	 scp mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz  $mgmIp:/root/ 
	#date1
	 ssh  $dataMIp1 "yum makecache"
	 ssh  $dataMIp1 "yum -y remove mysql mysql-devel"
	 ssh  $dataMIp1 "groupadd mysql && useradd -g mysql mysql && chkconfig iptables off && service iptables stop "
	 ssh  $dataMIp1 "sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config"
	 scp mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz  $dataMIp1:/root/ 
	#date2
   	 ssh  $dataMIp2 "yum makecache"
         ssh  $dataMIp2 "yum -y remove mysql mysql-devel"
         ssh  $dataMIp2 "groupadd mysql && useradd -g mysql mysql && chkconfig iptables off && service iptables stop "
         ssh  $dataMIp2 "sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config"
         scp mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz  $dataMIp2:/root/
	#sql1
     	 ssh  $sqlMIp1 "yum makecache"
         ssh  $sqlMIp1 "yum -y remove mysql mysql-devel"
         ssh  $sqlMIp1 "groupadd mysql && useradd -g mysql mysql && chkconfig iptables off && service iptables stop "
         ssh  $sqlMIp1 "sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config"
         scp mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz  $sqlMIp1:/root/
	#sql2
	 ssh  $sqlMIp2 "yum makecache"
         ssh  $sqlMIp2 "yum -y remove mysql mysql-devel"
         ssh  $sqlMIp2 "groupadd mysql && useradd -g mysql mysql && chkconfig iptables off && service iptables stop "
         ssh  $sqlMIp2 "sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config"
         scp mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz  $sqlMIp2:/root/
}

function mysqlCluster()
{
  echo "======================================== install management start================================================================"
	 ssh  $mgmIp "cd /root && tar xvf mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz && mv mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64 /usr/local/mysql-cluster && chown -R mysql.mysql /usr/local/mysql-cluster/"
	 ssh  $mgmIp "cat >/usr/local/mysql-cluster/config.ini<<EOF
[ndbd default]
NoOfReplicas=2
DataMemory=512M
IndexMemory=256M

[ndb_mgmd]
NodeId=1
hostname=$mgmIp
datadir=/var/lib/mysql-cluster

[ndbd]
NodeId=2
hostname=$dataMIp1
datadir=/usr/local/mysql-cluster/ndbdata

[ndbd]
NodeId=3
hostname=$dataMIp2
datadir=/usr/local/mysql-cluster/ndbdata

[mysqld]
NodeId=4
hostname=$sqlMIp1

[mysqld]
NodeId=5
hostname=$sqlMIp2
EOF
"
  ssh  $mgmIp "mkdir /var/lib/mysql-cluster && mkdir -p /usr/local/mysql/mysql-cluster && ln -s /usr/local/mysql-cluster/bin/* /usr/bin/ "


 echo "======================================== install management end================================================================"
 echo "======================================== install date  start================================================================"
	 ssh  $dataMIp1 "cd /root && tar xvf mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz && mv mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64 /usr/local/mysql-cluster && chown -R mysql.mysql /usr/local/mysql-cluster/"
	 ssh  $dataMIp2 "cd /root && tar xvf mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz && mv mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64 /usr/local/mysql-cluster && chown -R mysql.mysql /usr/local/mysql-cluster/"
  ssh  $dataMIp1 "mv /etc/my.cnf /etc/my.cnf.bak"
  ssh  $dataMIp1 "cat >/etc/my.cnf<<EOF
[mysqld]
datadir=/usr/local/mysql-cluster/data
ndbcluster
ndb-connectstring=$mgmIp
user=mysql
[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
[mysql_cluster]
ndb-connectstring=$mgmIp
EOF
"
 ssh  $dataMIp1 "chown -R mysql:mysql /usr/local/mysql-cluster/ &&  ln -s /usr/local/mysql-cluster/bin/* /usr/bin/ "

  ssh  $dataMIp2 "mv /etc/my.cnf /etc/my.cnf.bak"
  ssh  $dataMIp2 "cat >/etc/my.cnf<<EOF
[mysqld]
datadir=/usr/local/mysql-cluster/data
ndbcluster
ndb-connectstring=$mgmIp
user=mysql
[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
[mysql_cluster]
ndb-connectstring=$mgmIp
EOF
"
 ssh  $dataMIp2 "chown -R mysql:mysql /usr/local/mysql-cluster/ &&  ln -s /usr/local/mysql-cluster/bin/* /usr/bin/ "

 echo "======================================== install date  end================================================================"
 echo "======================================== install sql  start================================================================"
	 ssh  $sqlMIp1 "cd /root && tar xvf mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz && mv mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64 /usr/local/mysql && chown -R mysql.mysql /usr/local/mysql/"
	 ssh  $sqlMIp2 "cd /root && tar xvf mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64.tar.gz && mv mysql-cluster-gpl-7.3.5-linux-glibc2.5-x86_64 /usr/local/mysql && chown -R mysql.mysql /usr/local/mysql/"
  ssh  $sqlMIp1 "mv /etc/my.cnf /etc/my.cnf.bak"
  ssh  $sqlMIp1 "cd /usr/local/mysql && ./scripts/mysql_install_db --user=mysql --explicit_defaults_for_timestamp && mv my.cnf my.cnf.bak &&  ln -s /usr/local/mysql/bin/* /usr/bin/ && \cp support-files/mysql.server  /etc/init.d/mysqld "
 ssh  $sqlMIp1 "cat >/usr/local/mysql/my.cnf<<EOF
[mysqld]
ndbcluster
ndb-connectstring=$mgmIp
[mysql_cluster]
ndb-connectstring=$mgmIp
EOF
"

  ssh  $sqlMIp2 "cd /usr/local/mysql && ./scripts/mysql_install_db --user=mysql --explicit_defaults_for_timestamp && mv my.cnf my.cnf.bak &&  ln -s /usr/local/mysql/bin/* /usr/bin/  && \cp support-files/mysql.server  /etc/init.d/mysqld"
 ssh  $sqlMIp2 "cat >/usr/local/mysql/my.cnf<<EOF
[mysqld]
ndbcluster
ndb-connectstring=$mgmIp
[mysql_cluster]
ndb-connectstring=$mgmIp
EOF
"
 echo "======================================== install sql  end================================================================"

}
function CheckInstall (){
echo "===================================== Check install ==================================="
echo "Checking..... "
 ssh  $mgmIp "if [ -s /usr/local/mysql-cluster ] && [ -s /usr/local/mysql-cluster/config.ini ];then 
	echo "mgm:OK";
	else 
		echo "Error: /usr/local/mysql-cluster  not found!!! mgm install failed.";
	fi
 "
 ssh $dataMIp1 "if [ -s /usr/local/mysql-cluster ] && [ -s /etc/my.cnf ];then echo "data1:OK";else 
	echo "data1 install failed"; fi	"

 ssh $dataMIp2 "if [ -s /usr/local/mysql-cluster ] && [ -s /etc/my.cnf ];then echo "data2:OK";else 
	echo "data2 install failed"; fi	"
 ssh $sqlMIp1 "if [ -s /usr/local/mysql ] && [ -s /usr/local/mysql/my.cnf ];then echo "sql1:OK";else
	echo "sql1 install failed"; fi "
 ssh $sqlMIp2 "if [ -s /usr/local/mysql ] && [ -s /usr/local/mysql/my.cnf ];then echo "sql2:OK";else
	echo "sql2 install failed"; fi "
echo "=============================Check end , startup mysqlcluster ==========================="
	 ssh  $mgmIp "cd  /usr/local/mysql-cluster && ./bin/ndb_mgmd -f config.ini && netstat -ntlp | grep 1186 ;if [ $? -eq 0 ];then echo "ndb_mgmd start OK \!\!";else echo "ndb_mgmd start failed \!\!" ;fi"
 ssh $dataMIp1 "/usr/local/mysql-cluster/bin/ndbd &&netstat -ntlp |grep ndbd;if [ $? -eq 0 ];then echo "ndbd start OK\!\!\!";else echo "ndbd start failed";fi"
 ssh $dataMIp2 "/usr/local/mysql-cluster/bin/ndbd &&netstat -ntlp |grep ndbd;if [ $? -eq 0 ];then echo "ndbd start OK\!\!\!";else echo "ndbd start failed";fi"
 ssh $sqlMIp1 "service mysqld restart && chkconfig mysqld on && netstat -ntlp | grep 3306 ;if [ $? -eq 0 ];then echo "mysqld start OK\!" ;else echo "mysqld start failed \!";fi"
 ssh $sqlMIp2 "service mysqld restart && chkconfig mysqld on && netstat -ntlp | grep 3306 ;if [ $? -eq 0 ];then echo "mysqld start OK\!" ;else echo "mysqld start failed \!";fi"
echo "===================================startup end===================================================="
echo "The ndb_mgm path : /usr/local/mysql-cluster "
echo "The data path:  /usr/local/mysql-cluster"
echo "The sql Path: /usr/local/mysql"
echo "startup ndb_mgm :/usr/local/mysql-cluster/bin/ndb_mgmd -f config.ini"	
echo "startup data : /usr/local/mysql-cluster/bin/ndbd"
echo "start mysql(sql): service mysqld start "
echo "Thank you for abeting me,I will insist on doing this \\!"
}
installInit    2>&1 | tee -a  $my_dir/log/mysqlCluster-init.log
mysqlCluster  2>&1 | tee -a  $my_dir/log/mysqlCluster-install.log
CheckInstall 2>&1 | tee -a  $my_dir/log/mysqlCluster-CheckInstall.log
