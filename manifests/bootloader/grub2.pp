# Configuration for grub v2 and higher
class serial_console::bootloader::grub2 (
  String  $ttys    = $serial_console::ttys,
  String  $tty     = $serial_console::tty,
  Integer $speed   = $serial_console::speed,
  Integer $word    = $serial_console::word,
  String  $parity  = $serial_console::parity,
  Integer $stop    = $serial_console::stop,
  Boolean $enabled = $serial_console::enabled
) {

  $_unit = regsubst($ttys,'^ttyS(\d+)$', '\1')
  $_parity = regsubst($ttys, '(.).*', '\1')

  if $enabled {
    augeas {'serial-bootloader':
      context => '/files/etc/default/grub',
      changes => [
        "set GRUB_TERMINAL_OUTPUT '\"console serial\"'",
        "set GRUB_SERIAL_COMMAND '\"serial --speed=${speed} --unit=${_unit} --word=${word} --parity=${parity} --stop=${stop}\"'",
        "set GRUB_CMDLINE_LINUX_DEFAULT '\"console=${tty} console=${ttys},${speed}${_parity}${word}\"'"
      ]
    }
  }
  else {
    augeas {'serial-bootloader':
      context => '/files/etc/default/grub',
      changes => [
        'set GRUB_TERMINAL_OUTPUT console',
        'rm GRUB_SERIAL_COMMAND',
        'rm GRUB_CMDLINE_LINUX_DEFAULT'
      ]
    }
  }

  exec {'grub2-mkconfig':
    command     => '/usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg',
    subscribe   => Augeas['serial-bootloader'],
    refreshonly => true,
  }
}
