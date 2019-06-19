# Setup boot loader
# Any subclass should provide serial-bootloader event for chaining other events
class serial_console::bootloader {

  # Configure grub and kernel parameters
  case $::loader {
    'grub1': {
      contain ::serial_console::bootloader::grub1
    }
    'grub2': {
      contain ::serial_console::bootloader::grub2
    }
    default: {
      notify { "Support for ${::loader} is not implement": }
    }
  }
}
