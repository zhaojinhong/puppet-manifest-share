#!/bin/bash 
#$Id$
#http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest 
#
WD="/tmp/work"
URL="http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest"
FILE=${WD}/ip_apnic
LOGFILE=${WD}/logfile

[ -d $WD ]||mkdir $WD

log(){
	echo Run at `date` >>$LOGFILE
	}
checknew(){
	oldmd5sum=`cat ${WD}/ip_md5sum 2>/dev/null`
	wget -t 5 --timeout=60 ${URL} -O $FILE 2>>$LOGFILE||exit 1
	md5sum=`grep 'apnic|CN|ipv4|' $FILE | cut -f 4,5 -d'|'|sed -e 's/|/ /g' |md5sum|awk '{print $1}'`
	[ ${oldmd5sum-123} == ${md5sum} ] 2>/dev/null&&exit 0
	echo $md5sum > ${WD}/ip_md5sum
	}
update(){
	>${WD}/all
	grep 'apnic|CN|ipv4|' $FILE | cut -f 4,5 -d'|'|sed -e 's/|/ /g' | while read ip cnt
do
	echo $ip:$cnt
        mask=$(cat << EOF | bc | tail -1
pow=32;
define log2(x) {
if (x<=1) return (pow);
pow--;
return(log2(x/2));
}
log2($cnt)
EOF)
        NETNAME=`whois -T inetnum -r $ip/$mask -h whois.apnic.net 2>>$LOGFILE  |grep ^netname|sed -e 's/netname://'`
	echo $NETNAME $ip/$mask >>/${WD}/all

done
	}
upload(){
	:
	}
	
###main###
checknew||exit 1
update
exit 0



