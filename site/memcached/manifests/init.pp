class memcached {
  package { 'memchached':
    ensure => present,
}
file { '/etc/sysconfig/memcached':
  ensure => file,
  owner => 'root',
  group => 'root',
  mode => '0644',
  source => 'puppet:///modules/memcached/memcached',
  required => package ['memcached'],
  }
  
  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => file ['/etc/sysconfig/memcached'],
  
  }
}
