#!/bin/echo Sourced file - dialog library

# result: 0[ok/yes] 1[cancel/no] 255[*]

dialog_selectapp_null(){
  exec 3>&1

  app_prog=$(${script_path}/src/dialog --backtitle "value input" --title "value" \
   --menu "menu" 20 60 10 \
    "proftpdmysql" "install proftpd with mysql" \
    "proftpd" "install proftpd" \
  2>&1 1>&3)

  result=$?
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

  app_installpkg=$(${script_path}/src/dialog --backtitle "value input" --title "value" \
   --fselect "/root" 20 60 \
  2>&1 1>&3)

  result=$?
  exec 3>&-

  case ${result} in
    0)
      if [ -f "${app_installpkg}" ]; then
        echo ${app_installpkg}
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
  ${script_path}/src/dialog --backtitle "value input" --title "value" --msgbox "$1" 20 60
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