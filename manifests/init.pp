class serial_console (
  String $port,
  String $console,
  String $speed,
  String $word,
  String $parity,
  String $stop,
  String $timeout,
  Boolean $enabled
) {

  contain serial_console::getty
  contain serial_console::securetty
  Class['::serial_console::securetty'] -> Class['::serial_console::getty']

  # Configure grub and kernel parameters
  case $::bootloader {
    'grub1': {
      contain ::serial_console::grub1
      Class['::serial_console::grub1'] -> Class['::serial_console::getty']
    }
    'grub2': {
      contain ::serial_console::grub2
      Class['::serial_console::grub2'] -> Class['::serial_console::getty']
    }
    default: {
      notify {'Class serial console requires grub to be installed':
        withpath => true
      }
    }
  }
}
