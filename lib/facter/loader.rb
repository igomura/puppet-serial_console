# Fact: bootloader
#
# Purpose: returns boot loader name
#
# Resolution:
#
# Caveats:
#
Facter.add("loader") do
  confine :kernel => :linux
  setcode do
    value = nil
    if File.exists?('/etc/default/grub')
      value = 'grub2'
    elsif File.exists?('/boot/grub/menu.lst')
      value = 'grub1'
    elsif File.exists?('/etc/grub.conf')
      value = 'grub1'
    elsif File.exists?('/etc/lilo.conf')
      value = 'lilo'
    else
      value = 'Unknown'
    end
    value
  end
end
