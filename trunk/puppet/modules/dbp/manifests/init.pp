#
# debian.pp - debian base config 
# Copyrit (C) 2007 huangmingyou <huangmingyou@gmail.com>
#



class dbp {

	
	# remove no use packages
	package {
		[ nvi,lpr,ppp,pppconfig,pppoe,pppoeconf ]:
		ensure => present;
		[ rsync,ntpdate,curl,nload,tcpick,tcpdump,subversion,iproute,vim,lsb-release,rcconf,most ]:
		ensure => installed;
	}

	
	# file
	file {
		"/etc/localtime":
		mode => 0644,owner => root, group => root,
		source => "/usr/share/zoneinfo/Asia/Shanghai";
		"/etc/timezone":
		mode => 0644,owner => root, group => root,
		content => "Asia/Shanghai\n";
		"/root/.vimrc":
		mode => 0644,owner => root, group => root,
		source => "puppet://$fileserver/dbp/vimrc";
		"/root/.bashrc":
		mode => 0644,owner => root, group => root,
		source => "puppet://$fileserver/dbp/bashrc";
		"/root/.ssh/":
		mode => 0755,owner => root, group => root,
		ensure => directory;
		"/root/.ssh/authorized_keys2":
		source => "puppet://$fileserver/dbp/authorized_keys2";
		"/root/.ssh/authorized_keys":
		ensure => authorized_keys2;
		# add at 2008-01-07 for vmx-start ,Ticket #11 #
		"/etc/sysctl.conf":
		source => "puppet://$fileserver/dbp/sysctl.conf";
		
	}	
	host { "luna.hmy.uupark.com":
		ip => "192.168.2.10";
	}

}

