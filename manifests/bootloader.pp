# Setup boot loader
# Any subclass should provide serial-bootloader event for chaining other events
class serial_console::bootloader {

  case $::loader {
    'grub1': {
      contain ::serial_console::bootloader::grub1
    }
    'grub2': {
      contain ::serial_console::bootloader::grub2
    }
    default: {
      fail("Support for loader ${::loader} is not implemented")
    }
  }
}
