# Fact: sys_init
#
# Purpose: return system init process name
#
# Resolution:
#
# Caveats:
#
Facter.add("sys_init") do
  confine :kernel => :linux
  setcode do
    proc_exec = '/proc/1/exe'
    proc_bin = File.readlink(proc_exec)
    File.basename(proc_bin)
  end
end
