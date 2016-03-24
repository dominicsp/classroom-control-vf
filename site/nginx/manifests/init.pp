class nginx (
  
  $root =undef,
) {
case $::osfamily {
  'redhat','debian': {
  $package = 'nginx'
  $owner = 'root'
  $group = 'root'
  $docroot = '/var/www'
  $confdir = '/etc/nginx'
  $logdir = '/var/log/nginx'
  
  $default_docroot ='/var/www'
  }
  'windows' :(
  $package = 'nginx-service'
  $owner = 'Administrator'
  $group = 'Administrators'
  $docroot = 'C:/ProgramData/nginx/html'
  $confdir = 'C:/ProgramData/nginx'
  $logdir = 'C:/ProgramData/nginx/logs'
  
  $default_docroot ='C:/ProgramData/nginx/html'
  }
  default :{
    fail ("module ${module_name} is not supported on ${::osfamily}")
  }
}
  
  # package nginx
  
  package {'nginx' :
    ensure => present,
  }
  
  # document root/var/www
  
  file { '/var/www':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0775',
  }
  
  file {'var/www/index1.html':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/nginx/index1.html',
  }
  
  file {'/etc/nginx/nginx.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/nginx/nginx.conf',
    required => Package['nginx'],
    notify => Service['nginx'],
    }
  
  file {'etc/nginx/conf.d':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0644',
    }
  # fixed syntax error 
  
   file {'etc/nginx/conf.d/default.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/nginx/default.conf',
    required => Package['nginx'],
    notify => Service['nginx'],
    }
  
  service {'nginx'
  ensure => running,
  enable => true,
  
  }



}
