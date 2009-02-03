#! /bin/bash

export PATH=/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/root/bin


while getopts 'h:r:d:e:c:' OPT; do
    case $OPT in
        h)
            host="$OPTARG";;
        r)
            repo="$OPTARG";;
        d)
            days="$OPTARG";;
        c)
            cycle="$OPTARG";;
        e)
            ex="$OPTARG";;
        ?)
            echo "Usage: `basename $0` [options]"
    esac
done


mail1="huangmy.9991.com@gmail.com"
backupno=$((($(date +%s)/86400)%${days}))
backuppre=$(((($(date +%s)/86400)-1)%${days}))
realbackup=$((($(date +%s)/86400)%${cycle}))
[ $realbackup -ne 0 ]&&exit 0
rsynccmd="/opt/app/rsync/bin/rsync -vzrtopg --progress --delete --password-file=/opt/app/rsync/rsyncd.pas --port=3334 --exclude=${ex}"


#check dir
[ -d /backup/program/$repo ]||mkdir /backup/program/$repo 
[ $? -ne 0 ]&&exit 2

#backup,if file no change ,use hard link.
$rsynccmd  --link-dest=/backup/program/$repo/backup${backuppre} ${host}::${repo} /backup/program/$repo/backup${backupno}
rsyncstat=$?

#log to syslog
/usr/bin/logger -p  local0.notice -t backupsite "backup ${host}:${repo} ,rsync retun  $rsyncstat"

#mail me when get error
[ $rsyncstat -ne 0 ]&&( echo "get rsync errorcode $rsyncstat when backup ${host}:${repo} at `date`"|mail $mail1 -s "rsync error" )

#make timestamp
/bin/touch /backup/program/$repo/backup${backupno}
