# Class: nexus::install
#
# This module manages nexus install
#
# Parameters:
#
# $nexus_bundle::  String. Name of the nexus distribution.
#                  Defaults to <tt>nexus-2.11.1-01-bundle.tar.gz</tt>
#
# $nexus_package:: String. Name of the nexus package.
#                  Defaults to <tt>undef</tt>
#
# $storage_loc::   String. Path of the root directory where Nexus will store the Maven repositories.
#                  Defaults to <tt>/var/lib/sonatype-work</tt>
#
# Actions: download and uncompress the distribution and sets up the link to the repository storage
#
# Requires: see Modulefile
#
# Sample Usage:
#
class nexus::install ($nexus_bundle, $nexus_package, $storage_loc) {
  require java::java_7

  if $nexus_package == undef {
    $nexus_splitted = split($nexus_bundle, '-')

    if $nexus_splitted[2] == 'bundle.tar.gz' {
      $nexus_package = "${nexus_splitted[0]}-${nexus_splitted[1]}"
    } else {
      $nexus_package = "${nexus_splitted[0]}-${nexus_splitted[1]}-${nexus_splitted[2]}"
    }
  }

  user { 'nexus':
    ensure  => present,
    comment => 'Nexus system user',
    gid     => 'nogroup',
    shell   => '/bin/bash',
    system  => true,
    home    => $storage_loc,
  }

  file { $storage_loc:
    ensure => directory,
    owner  => nexus,
    group  => nogroup,
  }

  file { '/opt/nexus':
    ensure => link,
    target => "/opt/${nexus_package}",
    owner  => root,
    group  => root,
  }

  download_uncompress { 'install_nexus':
    distribution_name => $nexus_bundle,
    dest_folder       => '/opt',
    creates           => "/opt/${nexus_package}",
    uncompress        => 'tar.gz',
    user              => root,
    group             => root,
  } ->
  file { '/opt/sonatype-work':
    ensure => link,
    force  => true,
    target => $storage_loc,
    owner  => root,
    group  => root,
  }

}