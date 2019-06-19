# Configuration for grub v2 and higher
class serial_console::grub2 (
  String  $port    = $serial_console::port,
  String  $console = $serial_console::console,
  String  $speed   = $serial_console::speed,
  String  $word    = $serial_console::word,
  String  $parity  = $serial_console::parity,
  String  $stop    = $serial_console::stop,
  Boolean $enabled = $serial_console::enabled
) {

  $unit = regsubst($port,'^ttyS(\d+)$','\1')

  if $enabled {
    augeas {'serial-grub':
      context => '/files/etc/default/grub',
      changes => [
        "set GRUB_TERMINAL_OUTPUT '\"console serial\"'",
        "set GRUB_SERIAL_COMMAND '\"serial --speed=${speed} --unit=${unit} --word=${word} --parity=${parity} --stop=${stop}\"'",
        "set GRUB_CMDLINE_LINUX '\"crashkernel=auto rd.lvm.lv=vgroot/root rd.lvm.lv=vgroot/swap biosdevname=1 audit=1\"'",
        "set GRUB_CMDLINE_LINUX_DEFAULT '\"console=${console} console=${port},${speed}n${word}\"'"
      ]
    }
  }
  else {
    augeas {'serial-grub':
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
    subscribe   => Augeas['serial-grub'],
    refreshonly => true,
  }
}
