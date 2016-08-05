class nginx (
  $owner    = $nginx::params::owner,
  $group    = $nginx::params::group,
  $package  = $nginx::params::package,
  $docroot  = $nginx::params::docroot,
  $blockdir = $nginx::params::blockdir,
  $logdir   = $nginx::params::logdir,
  $user     = $nginx::params::user,
  ) inherits nginx::params {
  
  File {
    ensure => file,
    owner => $owner,
    group => $group,
    mode  =>  '0664',
    }
  
    package { $package:
      ensure => present,
    }
    
  file { $docroot:
    ensure  => directory,
  }
  
  file { "${docroot}/index.html":
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file { "${confdir}/nginx.conf":
    content => template('nginx/nginx.conf.erb'),
    notify  => Service['nginx'],
  }
  
  file { "${confdir}/conf.d/default.conf" :
    content => template('nginx/default.conf.erb'),
    notify  => Service['nginx'],
  }
  
  service {'nginx':
    ensure => running,
    enable => true,
  }

}
