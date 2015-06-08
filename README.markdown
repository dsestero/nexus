# nexus #

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nexus](#setup)
    * [What nexus affects](#what-nexus-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nexus](#beginning-with-nexus)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This is the nexus module. It manages Nexus OSS Maven repository. Nexus is the reference software for Maven repository management (see http://www.sonatype.org/nexus/).

##Module Description

The module installs the distribution of Nexus OSS by extracting the tarball and setting up the file system and the system user running the nexus service.

##Setup

###What nexus affects

The module creates the nexus system user, installs the nexus distribution under `/opt`, creates (if not existing) a directory to host the repositories (by default it is `/var/lib/sonatype-work`), creates a directory for Nexus logs under `/var/log/nexus` and one for Nexus cache under `/var/cache/nexus`. Furthermore, it sets up the scripts for managing Nexus as a service.

###Setup Requirements

This modules requires the following other modules to be installed:

* dsestero/download_uncompress

    to provide the basic capability to download and unzip the Nexus distribution
    
* dsestero/java

    to install a suitable java development environment

###Beginning with nexus	

To install nexus as a service with default configuration, it is possible to use a declaration as the following:

```
include nexus
```

##Usage

To install the nexus service listening on port 9090 and hosting the Maven repositories
under /srv/nexus the declaration would be:
```
  class nexus { 'install_nexus':
    port             => '9090',
    nexus_home     => '/srv/nexus',
  }
```

##Reference

###Public Classes

* [`nexus::nexus`](#nexusnexus): Manages nexus

###Private Classes

* [`nexus::params`](#nexusparams): Specifies the module defaults
* [`nexus::install`](#nexusinstall): Installs the module artifacts
* [`nexus::config`](#nexusconfig): Configures the module artifacts
* [`nexus::service`](#nexusservice): Sets up the service

###`nexus::nexus`
Installs, configure and sets up a nexus service.

####Parameters

#####`bundle`
String. Name of the Nexus distribution which will be downloaded from the `distributions_base_url` key defined in hiera (see the README of the download_uncompress module) or full URL of the Nexus distribution; in the latter case the value of the key `distributions_base_url` is ignored. Defaults to `nexus-2.11.1-01-bundle.tar.gz`

#####`package`
String. Name of the Nexus directory inside the bundle. Defaults to `undef` so that, if not specified, will be taken from the bundle name stripped from the `-bundle.tar.gz` part. This parameter is necessary because some versions have a bundle name like `nexus-2.9.2-bundle.tar.gz` yet have a package name (after extraction) like `nexus-2.9.2-01`.

#####`port`
Integer. Port where the Nexus web app will be listening. Defaults to `8081`.

#####`storage_loc`
String. Path of the root directory where Nexus OSS will store the Maven repositories.
Defaults to `/var/lib/sonatype-work`.

##Limitations

At the moment the module targets only OpenJDK on Ubuntu platforms. Specifically, it is tested only on Ubuntu 12.04 distributions, although probably it will work also on more recent versions.

If a full url is specified as the bundle parameter it is necessary to have the module download_uncompress version 1.1.0 or above.

The file name of the distribution is expected to be in the standard form: nexus-XX.YY.ZZ-INC-bundle.tar.gz where -INC is optional.

##Development

If you need some feature please send me a (pull) request or send me an email at: dsestero 'at' gmail 'dot' com.
