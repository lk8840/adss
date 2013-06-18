#!/bin/echo Sourced file - dialog library

# result: 0[ok/yes] 1[cancel/no] 255[*]

dialog_selectapp_null(){
  exec 3>&1

  prog=$(${dialogpath} --backtitle "Select install app" --title "Apps" \
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

  installpkg=$(readlink -f "$(${dialogpath} --backtitle "Input install package path" \
   --title "Input path" \
   --fselect "/" 20 60 \
  2>&1 1>&3)")

  local result=$?
  exec 3>&-

  case ${result} in
    0)
      if [ -f "${installpkg}" ]; then
        general_checkpkgsupport_null $(basename "${installpkg}")
      else
        dialog_msgbox_info "${installpkg} not exist, please select correct install package!" "dialog_selectfile_installpkg"
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
