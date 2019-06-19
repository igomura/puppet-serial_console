# Configuration for grub version below 2.0
class serial_console::grub1 (
  String  $port    = $serial_console::port,
  String  $console = $serial_console::console,
  String  $speed   = $serial_console::speed,
  String  $word    = $serial_console::word,
  String  $parity  = $serial_console::parity,
  String  $stop    = $serial_console::stop,
  String  $timeout = $serial_console::timeout,
  Boolean $enabled = $serial_console::enabled
){

  $unit = regsubst($port,'^ttyS(\d+)$','\1')

  if $enabled {
    augeas {'serial-grub':
      context => '/files/boot/grub/grub.conf',
      onlyif  => 'match serial/unit size == 0',
      changes => [
        'rm hiddenmenu',
        'rm splashimage',
        'rm serial',
        'rm terminal',

        'ins serial after default',
        "set serial/unit ${unit}",
        "set serial/speed ${speed}",
        "set serial/word ${word}",
        "set serial/parity ${parity}",
        "set serial/stop ${stop}",

        'ins terminal after serial',
        "set terminal/timeout ${timeout}",
        "set terminal/serial \"\"",
        "set terminal/console \"\"",

        'rm title/kernel/rhgb',
        'rm title/kernel/quiet',

        "setm title/kernel console[1] ${console}",
        "setm title/kernel console[2] ${port},${speed}n${word}"
      ]
    }
  }
  else {
    augeas {'serial-grub':
      context => '/files/boot/grub/grub.conf',
      changes => [
        'rm serial',
        'rm terminal',
        'rm title/kernel/console'
      ]
    }
  }
}
