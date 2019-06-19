# Setup getty process to start
class serial_console::getty (
  String  $ttys     = $serial_console::ttys,
  Integer $speed    = $serial_console::speed,
  Boolean $enabled  = $serial_console::enabled
) {

  case $::sys_init {
    'init': {
      service {'serial-getty':
        ensure    => $enabled,
        provider  => 'upstart',
        status    => "/sbin/initctl status serial DEV=${ttys} SPEED=${speed}",
        start     => "/sbin/initctl start serial DEV=${ttys} SPEED=${speed}",
        stop      => "/sbin/initctl stop serial DEV=${ttys} SPEED=${speed}",
        subscribe => Augeas['serial-bootloader']
      }
    }
    'systemd': {
      service { 'serial-getty':
        ensure    => $enabled,
        enable    => $enabled,
        name      => "serial-getty@${ttys}",
        subscribe => Augeas['serial-bootloader']
      }
    }
    default: {
      fail("Serial console has no support for service provider XX")
    }
  }
}
