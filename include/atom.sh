#!/bin/echo Sourced file - atomfunc library

atom_filedetect_null(){

  # Function need input full path of file
  # Call method:
  # atom_filedetect_null filepath1 filepath2

  case $os in
    linux)
      for args in $@; do
        if [ ! -f ${args} ]; then
          echo "atom_filedetect_null():There's no file \"${args}\""
          exit 1
        fi
      done
      ;;
    *)
      echo "atom_filedetect_null():Can not identify os type"
      exit 1
      ;;
  esac
}

atom_parsearg_null(){

  # Function will parse the args
  # Call method:
  # atom_parsearg_null --param=value

  local sourcearg=$(echo "$1" | sed -e 's/^[^=]*=//')

  if [ $(echo ${sourcearg:0-1}) = "/" ]; then
    echo ${sourcearg} | sed "s/\(.*\)\//\1/"
  else
    echo ${sourcearg}
  fi
}

atom_firewallrule_add(){

  # Function need initial ${append_str} before call itself
  # Function will insert new rule in system iptables config file
  # Call method:
  # atom_firewallrule_add commit

  if [ -z $1 ]; then
    echo "atom_firewallrule_add():Param missing..."
    exit 1
  fi

  case $os in
    linux)
      local firewallinfo=" -m comment --comment \"$1\""
      sed -i "/COMMIT/i${append_str}${firewallinfo}" ${iptables_conf}
      # debug: grep "^${append_str}${firewallinfo}"
      # debug: sed "/COMMIT/i${append_str}${firewallinfo}" /etc/sysconfig/iptables
      ;;
    *)
      echo "atom_firewallrule_add():Can not identify os type"
      exit 1
      ;;
  esac
}

atom_firewallrule_remove(){

  # Function need initial ${append_str} before call itself
  # Function will insert new rule in system iptables config file
  # Call method:
  # atom_firewallrule_remove commit

  if [ -z $1 ]; then
    echo "atom_firewallrule_remove():Param missing..."
    exit 1
  fi

  case $os in
    linux)
      local firewallinfo=" -m comment --comment \"$1\""
      sed -i "s/^${append_str}${firewallinfo}//g" ${iptables_conf}
      # debug: grep "^${append_str}${firewallinfo}"
      # debug: sed "/COMMIT/i${append_str}${firewallinfo}" /etc/sysconfig/iptables | sed "s/^${append_str}${firewallinfo}\n//g"
      ;;
    *)
      echo "atom_firewallrule_remove():Can not identify os type"
      exit 1
      ;;
  esac
}

atom_fetchvalue_null(){

  # Call method:
  # atom_fetchvalue_null filepath item
  #
  # config file example
  # item(|)content

  returnvalue=`grep "^${2}" ${1} | sed "s/^${2}(|)\(.*\)$/\1/g"`
  
  echo ${returnvalue}
}

