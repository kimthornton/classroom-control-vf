class nginx::params {
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
  $user = $::osfamily ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
  }
}
