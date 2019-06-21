# Setup getty process to start
class serial_console::getty (
  String  $ttys     = $serial_console::ttys,
  Integer $speed    = $serial_console::speed,
  Boolean $enabled  = $serial_console::enabled
) {

  case $::sys_init {
    'init': {
      contain serial_console::getty::upstart
    }
    'systemd': {
      contain serial_console::getty::systemd
    }
    default: {
      fail("Support for init ${::sys_init} is not implemented")
    }
  }
}
