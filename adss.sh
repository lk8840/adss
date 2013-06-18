#!/bin/bash

script_path=$(dirname $(readlink -f "$0"))

. ${script_path}/include/dialog.sh
. ${script_path}/include/config.sh
. ${script_path}/include/general.sh

. ${script_path}/include/proftpdmysql.sh

# Initial system configuration
config_systemenv_null
config_varinit_null

# Choose the app which need be installed
dialog_selectapp_null

install_dispatch_null(){
  case $1 in
    proftpd)
      install_proftpd
      ;;
    proftpdmysql)
      install_proftpdmysql
      ;;
    *)
      echo "Dialog dispatch error"
      exit 1
      ;;
  esac
}

install_proftpdmysql(){
  proftpdmysql_varinit_null
  dialog_installparam_proftpdmysql
  proftpdmysql_parsearg_null
  proftpdmysql_precompile_prog
  proftpdmysql_compile_prog
  proftpdmysql_setenv_null
  proftpdmysql_modifyfile_configfile
  proftpdmysql_import_mysql
  proftpdmysql_createfile_controlscript
  proftpdmysql_install_verify
}