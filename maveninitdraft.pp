class maven (
  $maven_home = "/opt/maven",
  $maven_archive = "apache-maven-3.3.9-bin.tar.gz",
  $maven_folder = "apache-maven-3.3.9") {
  
  Exec {
      path => [ "/usr/bin", "/bin", "/usr/sbin"]
  }
  
  file { "/tmp/shared/${maven_archive}":
      ensure => present,
      source => "puppet:///modules/maven/${maven_archive}",
      owner => vagrant,
      mode => 755,
  }
  
  exec { "extract maven":
      command => "tar xfv ${maven_archive}",
      cwd => "/tmp/shared",
      creates => "${maven_home}",
      require => File["/tmp/shared/${maven_archive}"]
  }

  exec { "move maven":
      command => "mv ${maven_folder} ${maven_home}",
      creates => "${maven_home}",
      cwd => "/tmp/shared",
      require => Exec["extract maven"]
  }
  
  file { "/etc/profile.d/maven.sh":
      content =>   "export MAVEN_HOME=${maven_home}
                   export M2=\$MAVEN_HOME/bin
                   export PATH=\$PATH:\$M2
                   export MAVEN_OPTS=\"-Xmx512m -Xms512m\""
  }
}