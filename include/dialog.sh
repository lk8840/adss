#!/bin/echo Sourced file - dialog library

# result: 0[ok/yes] 1[cancel/no] 255[*]

dialog_selectapp_null(){
  exec 3>&1

  app_prog=$(${dialogpath} --backtitle "Select install app" --title "Apps" \
   --menu "menu" 20 60 10 \
    "proftpdmysql" "install proftpd with mysql" \
    "proftpd" "install proftpd" \
  2>&1 1>&3)

  local result=$?
  exec 3>&-

  case ${result} in
    0)
      dialog_selectfile_installpkg
      ;;
    1)
      exit 1
      ;;
    *)
      exit 1
      ;;
  esac
}

dialog_selectfile_installpkg(){
  exec 3>&1

  app_installpkg=$(readlink -f "$(${dialogpath} --backtitle "Input install package path" \
   --title "Input path" \
   --fselect "/" 20 60 \
  2>&1 1>&3)")

  local result=$?
  exec 3>&-

  case ${result} in
    0)
      if [ -f "${app_installpkg}" ]; then
        general_checkpkgsupport_null $(basename "${app_installpkg}")
        install_dispatch_null ${app_prog}
      else
        dialog_msgbox_info "${app_installpkg} not exist, please select correct install package!" "dialog_selectfile_installpkg"
      fi
      ;;
    1)
      exit 1
      ;;
    *)
      exit 1
      ;;
  esac
}

dialog_msgbox_info(){
  # $0 $1(msg) $2(callback function)
  ${dialogpath} --backtitle "value input" --title "value" --msgbox "$1" 20 60
  local result=$?
  case ${result} in
    0)
      $2
      ;;
    255)
      exit 1
      ;;
  esac
}



dialog_installparam_proftpdmysql(){
  exec 3>&1

  app_installparam=$(${dialogpath} --backtitle "Input install parameters" \
   --separator "," \
   --title "Input" \
   --form "Input value" 20 40 10 \
    "prefix:" 1 1 "${prefix}" 1 15 15 255 \
    "compile_opt: " 2 1 "${compile_opt}" 2 15 15 255 \
    "ftppubdir: " 3 1 "${ftppubdir}" 3 15 15 255 \
    "ftpport: " 4 1 "${ftpport}" 4 15 15 255 \
    "mysqlhost: " 5 1 "${mysqlhost}" 5 15 15 255 \
    "mysqlport: " 6 1 "${mysqlport}" 6 15 15 255 \
    "mysqlacc: " 7 1 "${mysqlacc}" 7 15 15 255 \
    "mysqlpsw: " 8 1 "${mysqlpsw}" 8 15 15 255 \
    "mysqldb: " 9 1 "${mysqldb)" 9 15 15 255 \
  2>&1 1>&3)

  local result=$?
  exec 3>&-

  case $(result) in
    0)
      prefix=$(echo ${app_installparam} | awk '{print $1}')
      compile_opt=$(echo ${app_installparam} | awk '{print $2}')
      ftppubdir=$(echo ${app_installparam} | awk '{print $3}')
      ftppubdir=$(echo ${app_installparam} | awk '{print $4}')
      ftpport=$(echo ${app_installparam} | awk '{print $5}')
      mysqlhost=$(echo ${app_installparam} | awk '{print $6}')
      mysqlacc=$(echo ${app_installparam} | awk '{print $7}')
      mysqlpsw=$(echo ${app_installparam} | awk '{print $8}')
      mysqldb=$(echo ${app_installparam} | awk '{print $9}')
      ;;
    1)
      exit 1
      ;;
    *)
      exit 1
      ;;
  esac
}
