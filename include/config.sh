#!/bin/echo Sourced file - config library

config_systemenv_null(){

  # Function will initial the system environment

  cpu_processor=$(cat /proc/cpuinfo | grep "processor" | wc -l)
  ip_addr=`/sbin/ifconfig|sed -n '/inet addr/s/^[^:]*:\([0-9.]\{7,15\}\) .*/\1/p' | head -n1`
  iptables_conf="/etc/sysconfig/iptables"
  os_startup_conf_file="/etc/rc.local"
  dialogpath="${script_path}/src/dialog"
}

config_varinit_null(){

  # Function will initial the vars

  font_default_color="\033[0m"
  font_echo_color="\033[40;32m"
  font_focus_color="\033[40;31;1m"

}

