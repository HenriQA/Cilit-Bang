init.pp 
class bamboo(

$installer_location = '/tmp/shared/',
$bamboo_archive = 'atlassian-bamboo-5.13.2.tar.gz',
$bamboo_home = '/opt/atlassian-bamboo-5.13.2',
$bamboo_folder = 'bamboo',
$install_location  ='/opt/'){

Exec {
path => ['/usr/bin', '/usr/sbin', '/bin'],
}

file { "/opt/${bamboo_archive}":
ensure => present,
source => "puppet:///modules/bamboo/${bamboo_archive}",
owner => vagrant,
mode => 755,
}

exec { 'extract bamboo':
cwd => '/opt',
command => "sudo tar zxvf ${bamboo_archive}",
# require => File["/opt/${bamboo_archive}"],
}

exec { 'start bamboo':
command => 'sudo /opt/atlassian-bamboo-5.13.2/bin/start-bamboo.sh',
require => Exec['extract bamboo'],
}


}
