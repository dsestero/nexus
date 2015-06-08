# Class: nexus
#
# This module manages nexus
#
# Parameters:
#
# $bundle::      String. Name of the nexus distribution.
#                Defaults to <tt>nexus-2.11.1-01-bundle.tar.gz</tt>
#
# $package::     String. Name of the nexus package.
#                Defaults to <tt>undef</tt>
#
# $port::        Integer. Port where the nexus web app will be listening. Defaults to <tt>8081</tt>
#
# $storage_loc:: String. Path of the root directory where Nexus will store the Maven repositories.
#                Defaults to <tt>/var/lib/sonatype-work</tt>
#
# Actions: manages Nexus OSS
#
# Requires: see Modulefile
#
# Sample Usage:
# include nexus
# class { nexus: nexus_bundle => 'nexus-2.11.3-01-bundle.tar.gz', }
class nexus (
  $bundle      = $nexus::params::bundle,
  $package     = undef,
  $port        = $nexus::params::port,
  $storage_loc = $nexus::params::storage_loc) inherits nexus::params {
  class { 'nexus::install':
    nexus_bundle  => $bundle,
    nexus_package => $package,
    storage_loc   => $storage_loc,
  } -> class { 'nexus::config':
    nexus_port => $port,
    java_home  => $nexus::params::java_home,
  } ~> class { 'nexus::service':
    jsw => $nexus::params::jsw,
  }
}
