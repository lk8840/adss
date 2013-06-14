#!/bin/echo Sourced file - general library

general_parsearg_atom(){
  sourcearg=$(echo "$1" | sed -e 's/^[^=]*=//')
  if [ $(echo ${sourcearg:0-1}) = "/" ]; then
    echo $sourcearg | sed "s/\(.*\)\//\1/"
  else
    echo $sourcearg
  fi
}

general_varinit_null(){
  cpu_processor=$(cat /proc/cpuinfo | grep "processor" | wc -l)
  ip_addr=`/sbin/ifconfig|sed -n '/inet addr/s/^[^:]*:\([0-9.]\{7,15\}\) .*/\1/p' | head -n1`
  iptables_conf="/etc/sysconfig/iptables"
  os_startup_conf_file="/etc/rc.local"
  defaultfont="\033[0m"
  echofontbegin="\033[40;32m"
  echofontend="\033[0m"
  focusfontbegin="\033[40;31;1m"
  focusfontend="\033[0m"
}

general_modifyfile_iptables(){
  append_mark="^:OUTPUT ACCEPT \[0:0\]"
  sed -i "$(grep -n "$append_mark" $iptables_conf | head -1 | cut -d ":" -f 1)a$append_str" $iptables_conf
}

general_checkpkgexist_null(){
  for pkgargs in $@; do
    for element in $(ls $installpkgdir 2>/dev/null | grep $pkgargs); do
      if [ -d $installpkgdir/$element ]; then
        rm -rf $installpkgdir/$element
      fi
    done
    if [ $(ls $installpkgdir/${pkgargs}-* 2>/dev/null | grep -c "$(basename $(readlink -f $installpkgdir/${pkgargs}-*) 2>/dev/null)") -eq 0 ]; then
      echo "There's no install package $args"
      exit 1
    fi
  done
}

general_checktoolexist_null(){
  tag=0

  for toolargs in $@; do
    checkstr=$(rpm -q $toolargs)
    if [ "$(echo $checkstr | grep "not installed")" ]; then
      echo -e $checkstr, please install like this: \"yum install ${echofontbegin}$toolargs${echofontend}\"
      tag=1
    fi
  done

  if [ $tag -eq 1 ]; then
    exit 1
  fi
}

