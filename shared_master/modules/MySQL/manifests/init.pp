#parameterised for future change/updates
class mysql(
	$installer_location	= '/tmp/shared/bin',
	$sql_location		= '/tmp/shared/puppet',
	$mysql_archive		= 'mysql-server_5.7.16-1ubuntu14.04_amd64.deb-bundle.tar',
	$mysql_folder		= '/mysql',
	$extract_location	= '/tmp'){
	
	Exec {
		path		=>	['/usr/bin', '/usr/sbin', '/bin'],
		returns 	=>	[0, 2, 14, 100],
		environment =>  [ "DEBIAN_FRONTEND=noninteractive" ]
		
	}
	
	exec { "install_dep" : 
		command	=>	'sudo apt-get install -y libaio1',
	}
	
	exec { "install_dep2" : 
		command	=>	'sudo apt-get install -y libmecab2',
		require	=> Exec['install_dep'],
	}
	
	exec { "mk_dir" : 
		command	=>	"mkdir ${extract_location}${mysql_folder}",
		require	=> Exec['install_dep2'],
	}
	
	exec { "copy_mysql" : 
		command	=> "sudo cp ${installer_location}/${mysql_archive} ${extract_location}${mysql_folder}",
		require	=> Exec['mk_dir'],
	}
	
	exec { "extract_mysql" :
		cwd		=> "${extract_location}${mysql_folder}",
		command	=> "sudo tar xvf ${mysql_archive}",
		require	=> Exec['copy_mysql'],
	}
	
	exec { "set_ans" : 
		cwd			=> "/${extract_location}/${mysql_folder}",
		command	=> 'sudo debconf-set-selections <<< "mysql-community-server  mysql-community-server/root-pass password root"',
		require		=> Exec['extract_mysql'],
	}
	
	exec { "set_ans2" :
		cwd			=> "/${extract_location}/${mysql_folder}",
		command		=> 'sudo debconf-set-selections <<< "mysql-community-server  mysql-community-server/re-root-pass password root"',
		require		=> Exec['set_ans'],
	}
	
	exec { "install_sql" : 
		cwd		=> "${extract_location}",
		command	=> "sudo dpkg -R --install mysql/",
		require	=> Exec['set_ans2'],
	}
	
	exec { "sql_install_dep" : 
		command	=> 'sudo apt-get install -f',
		#require	=> Exec['reset_env'],
		require	=> Exec['install_sql'],
	}
	
	exec { "jira_db" : 
		cwd		=> "${sql_location}${mysql_folder}",
		command	=> 'mysql -sfu root --password=root < "mysql_jiradb.sql"',
		require	=> Exec['sql_install_dep'],
	}
	
	exec { "bamboo_db" : 
		cwd		=> "//${sql_location}${mysql_folder}",
		command	=> 'mysql -sfu root --password=root < "mysql_bamboodb.sql"',
		require	=> Exec['jira_db'],
	}
	
	exec { "secure_db" : 
		cwd		=> "/${sql_location}${mysql_folder}",
		command	=> 'mysql -sfu root --password=root < "mysql_secure_installation.sql"',
		require	=> Exec['bamboo_db'],
	}
}