#!/usr/bin/awk  -f
BEGIN { system("/usr/sbin/ntpdate -t 10 pool.ntp.org") }
$0 !~ /^#|^$/ {
	system("/opt/shell/backup-site.sh -h "$1" -r "$2" -d "$3" -c "$4" -e "$5)
}
