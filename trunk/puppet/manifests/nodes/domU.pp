node 'd11.hmy.piao6.net' {
	include dbp
	package {
                ["dpatch","dupload","dpkg-dev","file","gcc","g++","libc6-dev","make","patch","perl","automake","autoconf","dh-make","debhelper","devscripts","fakeroot","gnupg","g77","lintian","xutils","pbuilder"]:
                ensure => installed;
        }
}
