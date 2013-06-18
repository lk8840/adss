#!/bin/bash

script_path=$(dirname $(readlink -f "$0"))

. ${script_path}/include/dialog.sh
. ${script_path}/include/config.sh
. ${script_path}/include/general.sh

. ${script_path}/include/proftpdmysql.sh

# Initial system configuration
config_systemenv_null
config_varinit_null

# main()
main(){
  import_args_null

  if [ -z ${setup_script} ]; then
    dialog_selectapp_null
  else
    prog=`grep "^prog" ${setup_script} | sed "s/^prog(|)\(.*\)$/\1/"`
    install_proftpdmysql ${setup_script}
  fi

  case $1 in
    proftpd)
      install_proftpd
      ;;
    proftpdmysql)
      install_proftpdmysql
      ;;
    *)
      echo "Prog fetch error!"
      exit 1
      ;;
  esac
}

import_args_null(){
  for args in $@
  do
    case ${args} in
      -c=*|--config=*)
        setup_script=$(general_parsearg_atom ${args})
        ;;
    esac
  done
}

install_proftpdmysql(){
  proftpdmysql_varinit_null
  setupscript_installparam_proftpdmysql ${setup_script}
  #proftpdmysql_parsearg_null
  proftpdmysql_precompile_prog "${installpkg}"
  proftpdmysql_compile_prog
  proftpdmysql_setenv_null
  proftpdmysql_modifyfile_configfile
  proftpdmysql_import_mysql
  proftpdmysql_createfile_controlscript
  proftpdmysql_install_verify
}