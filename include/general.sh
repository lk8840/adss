#!/bin/echo Sourced file - general library

general_parsearg_atom(){

  # Function will parse the args

  local sourcearg=$(echo "$1" | sed -e 's/^[^=]*=//')
  if [ $(echo ${sourcearg:0-1}) = "/" ]; then
    echo ${sourcearg} | sed "s/\(.*\)\//\1/"
  else
    echo ${sourcearg}
  fi
}

general_modifyfile_iptables(){

  # Function need initial ${append_str} before call itself
  # Function will appendnew rule to system iptables config file

  local append_marker="^:OUTPUT ACCEPT \[0:0\]"
  sed -i "$(grep -n "${append_marker}" ${iptables_conf} | head -1 | cut -d ":" -f 1)a${append_str}" ${iptables_conf}
}

general_checkpkgexist_null(){

  # Function need input full path of package

  for args in $@; do
    if [ ! -f ${args} ]; then
      echo "There's no install package ${args}"
      exit 1
    fi
  done
}

general_checktoolexist_null(){
  tag=0
  for toolargs in $@; do
    checkstr=$(rpm -q ${toolargs})
    if [ "$(echo ${checkstr} | grep "not installed")" ]; then
      echo -e ${checkstr}, please install like this: \"yum -y install ${echofontbegin}${toolargs}${echofontend}\"
      tag=1
    fi
  done

  if [ $tag -eq 1 ]; then
    exit 1
  fi
}

general_checkpkgsupport_null(){
  local default_compileopt=$(cat ${script_path}/src/supportpkglist.conf | grep "$1" | sed "s/.*|//")
  if [ -z "${default_installopt}" ]; then
    echo "$1 is not supported by adss"
    exit 1
  fi
}

general_fetchvalue_configfile(){
  # Call method
  # general_fetchvalue_configfile filepath item
  #
  # config file example
  # item(|)content

  returnvalue=`grep "^${2}" ${1} | sed "s/^${2}(|)\(.*\)$/\1/g"`
  
  echo ${returnvalue}
}

