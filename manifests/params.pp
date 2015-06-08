# Class: nexus::params
#
# This module manages nexus parameters
#
# Parameters: none
#
# Actions: sets the value of some variables for the specified platforms
#
# Requires: see Modulefile
#
# Sample Usage:
#
class nexus::params {
  case $::operatingsystem {
    'Ubuntu' : {
      case $::operatingsystemrelease {
        '12.04' : {
          case $::architecture {
            'amd64' : {
              $java_home = '/usr/lib/jvm/java-7-openjdk-amd64'
              $jsw = 'linux-x86-64'
            }
            default : {
              fail("The ${module_name} module is not supported on ${::operatingsystem} release ${::operatingsystemrelease} ${::architecture}"
              )
            }
          }
        }
        default : {
          fail("The ${module_name} module is not supported on ${::operatingsystem} release ${::operatingsystemrelease}")
        }
      }
    }
    default  : {
      fail("The ${module_name} module is not supported on an ${::operatingsystem} distribution.")
    }
  }
  $port = 8081
  $bundle = 'nexus-2.11.1-01-bundle.tar.gz'
  $storage_loc = '/var/lib/sonatype-work'
}
