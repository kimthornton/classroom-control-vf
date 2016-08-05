class nginx {
  case $::os['family'] {
  'redhat','debian':{
    $package  = 'nginx'
    $owner    = 'root'
    $group    = 'root'
    $docroot  = '/var/www'
    $confdir  = '/etc/nginx'
    $logdir   = '/var/log/nginx'
  }
  'windows' : {
    $package  = 'nginx-service'
    $owner    = 'Administrator'
    $group    = 'Administrators'
    $docroot  = 'C:/ProgramData/nginx/html'
    $confdir  = 'C:/ProgramData/nginx'
    $logdir   = 'C:/ProgramData/nginx/logs'
  }
  default : {
    fail("Module ${module_name} is not supported on ${::os['family']}")
  }
  }
  $user = $::os['family'] ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
  }
  
  
  File {
    owner => 'root',
    group => 'root',
    }
  
    package {$package:
      ensure => present,
    }
    
  file { [$docroot, "${confdir/conf.d"]:
    ensure  => directory,
    mode    => '0775'
  }
  
  file { "${docroot}/index.html":
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file { "${confdir}/nginx.conf":
   ensure   => file,
    mode    => '0664',
    content => template('nginx/nginx.conf.erb'),
    notify  => Service['nginx'],
  }
  
  file { "${confdir}/conf.d/default.conf" :
    ensure  => file,
    mode    => '0664',
    content => template('nginx/default.conf.erb'),
    notify  => Service['nginx'],
  }
  
  service {'nginx':
    ensure => running,
    enable => true,
  }

}
