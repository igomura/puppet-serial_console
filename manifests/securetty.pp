# Configuration for grub v2 and higher
class serial_console::securetty (
  String  $ttys    = $serial_console::ttys,
  Boolean $enabled = $serial_console::enabled
) {

  if $enabled {
    augeas {'console_securetty':
      context => '/files/etc/securetty',
      onlyif  => "match *[.=\'${ttys}\'] size == 0",
      changes => [
        'ins 0 before 1',
        "set 0 ${ttys}"
      ]
    }
  }
}
