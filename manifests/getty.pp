# Setup getty process to start
class serial_console::getty (
  String  $port     = $serial_console::port,
  String  $speed    = $serial_console::speed,
  Boolean $enabled  = $serial_console::enabled
) {

  case $::sys_init {
    'init': {
      service {'serial-getty':
        ensure    => $enabled,
        provider  => 'upstart',
        status    => "/sbin/initctl status serial DEV=${port} SPEED=${speed}",
        start     => "/sbin/initctl start serial DEV=${port} SPEED=${speed}",
        stop      => "/sbin/initctl stop serial DEV=${port} SPEED=${speed}",
        subscribe => Augeas['serial-grub']
      }
    }
    'systemd': {
      service { 'serial-getty':
        ensure    => $enabled,
        enable    => $enabled,
        name      => "serial-getty@${port}",
        subscribe => Augeas['serial-grub']
      }
    }
    default: {
      fail("Serial console has no support for service provider XX")
    }
  }
}
