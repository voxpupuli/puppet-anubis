# @summary Install and configure Anubis
#
# @param package_version
#   The version to install
class anubis (
  String[1] $package_version = '1.22.0'
) {
  $package_url = "https://github.com/TecharoHQ/anubis/releases/download/v${package_version}/anubis-${package_version}-1.${facts['os']['architecture']}.rpm"

  package { 'anubis':
    source => $package_url,
  }
}
