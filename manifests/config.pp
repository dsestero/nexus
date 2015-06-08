# Class: nexus::config
#
# This module manages nexus config
#
# Parameters:
# $nexus_port:: the port on which the nexus web app will be listening
# $java_home::  java_home directory
#
# Actions: configures Nexus OSS
#
# Requires: see Modulefile
#
# Sample Usage:
#
class nexus::config ($nexus_port, $java_home) {
  File {
    owner => nexus,
    group => nogroup,
  }

  file { '/var/log/nexus':
    ensure => directory,
  }

  file { '/var/cache/nexus':
    ensure => directory,
  }

  file { '/opt/nexus/logs':
    ensure => link,
    force  => true,
    target => '/var/log/nexus',
    owner  => root,
    group  => root,
  }

  file { '/opt/nexus/tmp':
    ensure => link,
    force  => true,
    target => '/var/cache/nexus',
    owner  => root,
    group  => root,
  }

  file { '/opt/nexus/conf/nexus.properties':
    ensure  => present,
    content => template("${module_name}/nexus.properties.erb"),
    mode    => '0644',
    owner   => root,
    group   => root,
  }

  file { '/opt/nexus/bin/nexus':
    ensure  => present,
    content => template("${module_name}/nexus.erb"),
    mode    => '0755',
    owner   => root,
    group   => root,
  }

  file { '/etc/init.d/nexus':
    ensure => present,
    source => "puppet:///modules/${module_name}/nexus-init",
    mode   => '0755',
    owner  => root,
    group  => root,
  }

}
