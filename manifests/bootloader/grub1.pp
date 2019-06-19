# Configuration for grub version below 2.0
class serial_console::bootloader::grub1 (
  String  $ttys    = $serial_console::ttys,
  String  $tty     = $serial_console::tty,
  Integer $speed   = $serial_console::speed,
  Integer $word    = $serial_console::word,
  String  $parity  = $serial_console::parity,
  Integer $stop    = $serial_console::stop,
  Integer $timeout = $serial_console::timeout,
  Boolean $enabled = $serial_console::enabled
){

  $_unit = regsubst($ttys,'^ttyS(\d+)$','\1')
  $_parity = regsubst($parity, '(.).*', '\1')

  if $enabled {
    augeas {'serial-bootloader':
      context => '/files/boot/grub/grub.conf',
      onlyif  => 'match serial/unit size == 0',
      changes => [
        'rm hiddenmenu',
        'rm splashimage',
        'rm serial',
        'rm terminal',
        'rm title/kernel/rhgb',
        'rm title/kernel/quiet',

        'ins serial after default',
        "set serial/unit ${_unit}",
        "set serial/speed ${speed}",
        "set serial/word ${word}",
        "set serial/parity ${parity}",
        "set serial/stop ${stop}",

        'ins terminal after serial',
        "set terminal/timeout ${timeout}",
        "set terminal/serial \"\"",
        "set terminal/console \"\"",

        "setm title/kernel console[1] ${tty}",
        "setm title/kernel console[2] ${ttys},${speed}${_parity}${word}"
      ]
    }
  }
  else {
    augeas {'serial-bootloader':
      context => '/files/boot/grub/grub.conf',
      changes => [
        'rm serial',
        'rm terminal',
        'rm title/kernel/console'
      ]
    }
  }
}
