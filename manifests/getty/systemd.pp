class serial_console::getty::systemd (
  String  $ttys    = $serial_console::ttys,
  Boolean $enabled = $serial_console::enabled
){

  service { 'serial-getty':
    ensure    => $enabled,
    enable    => $enabled,
    name      => "serial-getty@${ttys}",
    subscribe => Augeas['serial-bootloader']
  }
}
