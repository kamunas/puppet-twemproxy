class twemproxy::server(
    $bind     = "localhost",
    $port     = 6379,
    $hash_function = "fnv1a_64",
    $hash_tag ="{}",
    $distribution="ketama",
    $time_out  = 400,
    $redis    = true,
    $servers  = [ "redis2.ss", "redis3.ss" ],
    $cluster_name = 'beta'
  ) {

  package {
       'twemproxy':
          ensure => latest,
          require => [Class['apt-basic']]
  }
  file { "/etc/twemproxy/":
    ensure => directory
  }
  file { "/etc/twemproxy/nutcracker.yml":
    ensure  => present,
    content => template("twemproxy/nutcracker.yml.erb"),
    require => [ Package["twemproxy"], File["/etc/twemproxy"] ],
    notify  => Service["twemproxy"],
  }
  group { "twemproxy":
    ensure    => present,
    allowdupe => false,
  }
  user { "twemproxy":
    ensure  => present,
    allowdupe => false,
    gid     => "twemproxy",
    shell   => "/bin/true",
    comment => "twemproxy server",
    require => Group["twemproxy"],
  }
  file { "/etc/init.d/twemproxy":
      ensure => present,
      source => "puppet:///modules/twemproxy/twemproxy.init",
      mode   => 744,
  }
  service { "twemproxy":
    ensure => running,
    require => Package["twemproxy"],
  }
}
