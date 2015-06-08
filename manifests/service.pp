# Class: nexus::service
#
# This module manages nexus service
#
# Parameters:
# $jsw:: directory under <tt>/opt/nexus/bin/jsw</tt> where the java wrapper for the platform resides
#
# Actions: sets up Nexus OSS as a startup service
#
# Requires: see Modulefile
#
# Sample Usage:
#
class nexus::service ($jsw) {
  service { 'nexus':
    ensure    => running,
    enable    => true,
    hasstatus => false,
    pattern   => "/opt/nexus/bin/jsw/${jsw}/wrapper",
    path      => '/etc/init.d',
  }
}
