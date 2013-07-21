class vbox(
  $doc_root        = '/vagrant/web',
  $php_modules     = [ 'imagick', 'xdebug', 'curl', 'mysql', 'cli', 'intl', 'mcrypt', 'memcache'],
  $sys_packages    = [ 'build-essential', 'curl', 'vim'],
  $mysql_host      = 'localhost',
  $mysql_db        = 'default',
  $mysql_user      = 'default',
  $mysql_pass      = 'password'
) {

  Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

  exec { 'apt-get update':
    command => 'apt-get update',
  }

  class { 'apt':
    always_apt_update => true,
  }

  class { 'git': }

  package { ['python-software-properties']:
    ensure  => 'installed',
    require => Exec['apt-get update'],
  }

  package { $sys_packages:
    ensure => 'installed',
    require => Exec['apt-get update'],
  }

  class { "apache": }

  apache::module { 'rewrite': }

  apache::vhost { 'default':
    docroot             => $doc_root,
    server_name         => false,
    priority            => '',
  }

  apt::ppa { 'ppa:ondrej/php5':
    before  => Class['php'],
  }

  class { 'php': }

  php::module { $php_modules: }

  php::ini { 'php':
    value   => ['date.timezone = "Europe/Belgrade"','upload_max_filesize = 12M', 'short_open_tag = 0'],
    target  => 'php.ini',
    service => 'apache',
  }

  class { 'mysql':
    root_password => 'root',
    require       => Exec['apt-get update'],
  }

  mysql::grant { 'default_db':
    mysql_privileges     => 'ALL',
    mysql_db             => $mysql_db,
    mysql_user           => $mysql_user,
    mysql_password       => $mysql_pass,
    mysql_host           => $mysql_host,
    mysql_grant_filepath => '/home/vagrant/puppet-mysql',
  }

  package { 'phpmyadmin':
    require => Class[ 'mysql' ],
  }

  apache::vhost { 'phpmyadmin':
    server_name => false,
    docroot     => '/usr/share/phpmyadmin',
    priority    => '10',
    require     => Package['phpmyadmin'],
  }

  exec { '/vagrant/web/phpmyadmin':
    command => 'ln -s /usr/share/phpmyadmin /vagrant/web/phpmyadmin',
    onlyif => 'grep -c /vagrant/web/phpmyadmin',
  }

  class { 'composer':
    require => [ Class[ 'php' ], Package[ 'curl' ] ]
  }
}

include vbox
