# Puppet module for system serial console setup

This module configures system for serial console access (boot loader, kernel and login)

### Requirements

Module has been tested on:

* OS:
  * Scentific Linux 6
  * RHEL/CentOS 7
* Puppet 5.5

Required modules:

* TBD

# Quick Start

Setup

```puppet
include serial_console
```

Full configuration options:

```puppet
class { 'serial_console':
  port    => '...',     # device name, e.g. ttyS1
  console => '...',     # console device name, e.g. tty0
  speed   => '...',     # serial port speed, e.g. 115200
  word    => '...',     # serial port word size, e.g. 8
  parity  => '...',     # serial port parity, e.g. yes or no
  stop    => '...',     # serial port stop bits, e.g. 1
  timeout => '...',     # grub menu timeout, e.g. 10
  enabled => false|true # create/remove configuration
}

```

# Facts

### $::sys_init

Returns binary file name of init process with PID 1

```puppet
'init'
```

### $::bootloader

Returns bootloader name

```puppet
'grub2'
```

# Contributors

* Igor Muratov <imuratov@box.com>

***

