#!/bin/echo Sourced file - config library

config_userdefined_null(){

  # Function will initial user defined config

  os = "linux"
}

config_systemenv_null(){

  # Function will initial the system environment

  case $os in
    linux)
      cpu_processor = $(cat /proc/cpuinfo | grep "processor" | wc -l)
      ipaddr = `/sbin/ifconfig|sed -n '/inet addr/s/^[^:]*:\([0-9.]\{7,15\}\) .*/\1/p' | head -n1`
      firewall_conf = "/etc/sysconfig/iptables"
      autorun_conf = "/etc/rc.local"
      ;;
    *)
      echo "config_systemenv_null():Can not identify os type"
      exit 1
      ;;
  esac
}

config_vision_null(){

  # Function will initial the vars

  case $os in
    linux)
      font_default_color = "\033[0m"
      font_echo_color = "\033[40;32m"
      font_focus_color = "\033[40;31;1m"
      ;;
    *)
      echo "config_vision_null():Can not identify os type"
      exit 1
      ;;
  esac
}

