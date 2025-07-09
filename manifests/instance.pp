# @summary Configure an Anubis instance
#
# @param target
#   The target Anubis should forward to
#
# @param settings
#   A hash of settings to be set in the environment file
#
# @param ensure
#   What state of the instance should be ensured, present or absent.
#
# @param bot_policies
#   Content of the botPolicies file, if any.
#   If undef (the default) the default policies file is used.

define anubis::instance (
  Stdlib::HTTPUrl $target,
  Hash[String, String] $settings = {},
  Enum['present', 'absent'] $ensure = 'present',
  Optional[String[1]] $bot_policies = undef,
) {
  require anubis

  $env_file = "/etc/anubis/${title}.env"

  if $bot_policies {
    $bot_policies_file = "/etc/anubis/${title}.botPolicies.yaml"
    file { $bot_policies_file:
      ensure  => $ensure,
      content => $bot_policies,
      notify  => Service["anubis@${title}"],
    }
  } else {
    $bot_policies_file = undef
  }

  $context = {
    'target'            => $target,
    'bot_policies_file' => $bot_policies_file,
    'settings'          => $settings,
  }

  file { $env_file:
    ensure  => $ensure,
    content => epp("${module_name}/env.epp", $context),
    notify  => Service["anubis@${title}"],
  }

  $service_ensure = $ensure == 'present'

  service { "anubis@${title}":
    ensure => $service_ensure,
    enable => $service_ensure,
  }
}
