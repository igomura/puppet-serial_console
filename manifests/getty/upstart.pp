class serial_console::getty::upstart (
  String  $ttys    = $serial_console::ttys,
  Integer $speed   = $serial_console::speed,
  Boolean $enabled = $serial_console::enabled
){

  service {'serial-getty':
    ensure    => $enabled,
    provider  => 'upstart',
    status    => "/sbin/initctl status serial DEV=${ttys} SPEED=${speed}",
    start     => "/sbin/initctl start serial DEV=${ttys} SPEED=${speed}",
    stop      => "/sbin/initctl stop serial DEV=${ttys} SPEED=${speed}",
    subscribe => Augeas['serial-bootloader']
  }
}