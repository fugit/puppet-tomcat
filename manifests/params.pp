# Class: tomcat::params
#
# This class defines default parameters used by the main module class tomcat
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to tomcat class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class tomcat::params {

  ### Application related parameters

  # Let's deal with versions madness
  $pkgver = $::operatingsystem ? {
    ubuntu                          => 'tomcat6',
    debian                          => $::lsbmajdistrelease ? {
      5       => 'tomcat5.5',
      6       => 'tomcat6',
      7       => 'tomcat7',
      default => 'tomcat6',
    },
    /(?i:CentOS|RedHat|Scientific)/ => $::lsbmajdistrelease ? {
      5       => 'tomcat5',
      6       => 'tomcat6',
      default => 'tomcat6',
    },
    /(?i:Amazon)/ => $::lsbmajdistrelease ? {
      3       => 'tomcat6',
      default => 'tomcat6',
    },
    /(?i:SLES|OpenSuSe)/            => 'tomcat6',
    default                         => 'tomcat',
  }

  # Todo: What to do when $pkgver = 'tomcat' without any number?
  $version = inline_template("<%= '${pkgver}'.scan(/\d/).first %>")

  ### Application related parameters
  $manager_package = $::operatingsystem ? {
    /(?i:Debian|Ubuntu)/            => "tomcat${version}-admin",
    /(?i:CentOS|RedHat|Scientific)/ => "tomcat${version}-admin-webapps",
    default                         => undef,
  }

  $manager_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu)/            => "/usr/share/${pkgver}-admin/manager",
    /(?i:CentOS|RedHat|Scientific)/ => "/var/lib/${pkgver}/webapps/manager",
    default                         => undef,
  }

  $package = $tomcat::params::pkgver

  $service = $tomcat::params::pkgver

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'java',
  }

  $process_args = $::operatingsystem ? {
    default => $tomcat::params::pkgver,
  }

  $process_user = $::operatingsystem ? {
    /(?i:Debian)/ => $::lsbmajdistrelease ? {
      6       => 'tomcat6',
      7       => 'tomcat7',
      default => 'tomcat',
    },
    default       => 'tomcat',
  }

  $config_dir = $::operatingsystem ? {
    default => "/etc/${tomcat::params::pkgver}",
  }

  $config_file = $::operatingsystem ? {
    default => "/etc/${tomcat::params::pkgver}/server.xml",
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = "/etc/init.d/${tomcat::params::pkgver}"

  $pid_file = $::operatingsystem ? {
    default => "/var/run/${tomcat::params::pkgver}.pid",
  }

  $data_dir = $::operatingsystem ? {
    default => "/var/lib/${tomcat::params::pkgver}/webapps",
  }

  $log_dir = $::operatingsystem ? {
    default => "/var/log/${tomcat::params::pkgver}",
  }

  $log_file = $::operatingsystem ? {
    default => "/var/log/${tomcat::params::pkgver}/catalina.out",
  }

  $port = '8080'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
