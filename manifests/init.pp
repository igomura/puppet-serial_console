class serial_console (
  String  $ttys,
  String  $tty,
  Integer $speed,
  Integer $word,
  String  $parity,
  Integer $stop,
  Integer $timeout,
  Boolean $enabled
) {

  contain serial_console::securetty
  contain serial_console::bootloader
  contain serial_console::getty

  Class['serial_console::bootloader'] -> Class['serial_console::getty']
}
