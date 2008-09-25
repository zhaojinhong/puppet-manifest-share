
Exec { path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" }
File { 
	ignore => '.svn',
	ensure => present,
	mode => 0644, owner => root, group => root,
}
Package { provider => "apt" }
Service { provider => "debian" }

$puppetserver = "10.0.1.10"
$mirrorserver = "debian.cn99.com"



import "modules.pp"
import "nodes/*.pp"
