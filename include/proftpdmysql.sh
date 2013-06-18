#!/bin/echo Sourced file - proftpdmysql library

proftpdmysql_varinit_null(){
  prog="proftpd"

  installpkg=""
  precompile_tool="gcc make mysql"

  prefix="/usr/local/${prog}"
  bindir="${prefix}/bin"
  sbindir="${prefix}/sbin"
  libexecdir="${prefix}/libexec"
  sysconfdir="${prefix}/etc"
  libdir="${prefix}/lib"
  includedir="${prefix}/include"
  sharedir="${prefix}/share"
  compile_opt="${default_compileopt}"

  conf_file="${script_path}/src/proftpdmysql_proftpd.conf"
  sql_file="${script_path}/src/proftpdmysql_proftpd.sql"

  ftppubdir="/opt/ftp"
  ftpport="21"
  
  mysqlhost="localhost"
  mysqlport="3306"
  mysqlacc="proftpd"
  mysqlpsw="proftpd"
  mysqldb="proftpd"
}

dialog_installparam_proftpdmysql(){
  exec 3>&1

  local app_installparam=$(${dialogpath} --backtitle "Input install parameters" \
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
    "mysqldb: " 9 1 "${mysqldb}" 9 15 15 255 \
  2>&1 1>&3)

  local result=$?
  exec 3>&-

  case $(result) in
    0)
      if [ ! -z "$(echo ${app_installparam} | awk '{print $1}')" ]; then
        prefix=$(echo ${app_installparam} | awk '{print $1}')
      fi
      if [ ! -z "$(echo ${app_installparam} | awk '{print $2}')" ]; then
        compile_opt=$(echo ${app_installparam} | awk '{print $2}')
      fi
      if [ ! -z "$(echo ${app_installparam} | awk '{print $3}')" ]; then
        ftppubdir=$(echo ${app_installparam} | awk '{print $3}')
      fi
      if [ ! -z "$(echo ${app_installparam} | awk '{print $4}')" ]; then
        ftpport=$(echo ${app_installparam} | awk '{print $4}')
      fi
      if [ ! -z "$(echo ${app_installparam} | awk '{print $5}')" ]; then
        mysqlhost=$(echo ${app_installparam} | awk '{print $5}')
      fi
      if [ ! -z "$(echo ${app_installparam} | awk '{print $6}')" ]; then
        mysqlport=$(echo ${app_installparam} | awk '{print $6}')
      fi
      if [ ! -z "$(echo ${app_installparam} | awk '{print $7}')" ]; then
        mysqlacc=$(echo ${app_installparam} | awk '{print $7}')
      fi
      if [ ! -z "$(echo ${app_installparam} | awk '{print $8}')" ]; then
        mysqlpsw=$(echo ${app_installparam} | awk '{print $8}')
      fi
      if [ ! -z "$(echo ${app_installparam} | awk '{print $9}')" ]; then
        mysqldb=$(echo ${app_installparam} | awk '{print $9}')
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

setupscript_installparam_proftpdmysql(){
  local installpkg_temp=`grep "^installpkg" $1 | sed "s/^installpkg(|)\(.*\)$/\1/"`
  local precompile_tool_temp=`grep "^precompile_tool" $1 | sed "s/^precompile_tool(|)\(.*\)$/\1/"`
  local prefix_temp=`grep "^prefix" $1 | sed "s/^prefix(|)\(.*\)$/\1/"`
  local bindir_temp=`grep "^bindir" $1 | sed "s/^bindir(|)\(.*\)$/\1/"`
  local sbindir_temp=`grep "^sbindir" $1 | sed "s/^sbindir(|)\(.*\)$/\1/"`
  local libexecdir_temp=`grep "^libexecdir" $1 | sed "s/^libexecdir(|)\(.*\)$/\1/"`
  local sysconfdir_temp=`grep "^sysconfdir" $1 | sed "s/^sysconfdir(|)\(.*\)$/\1/"`
  local libdir_temp=`grep "^libdir" $1 | sed "s/^libdir(|)\(.*\)$/\1/"`
  local includedir_temp=`grep "^includedir" $1 | sed "s/^includedir(|)\(.*\)$/\1/"`
  local sharedir_temp=`grep "^sharedir" $1 | sed "s/^sharedir(|)\(.*\)$/\1/"`
  local compile_opt_temp=`grep "^compile_opt" $1 | sed "s/^compile_opt(|)\(.*\)$/\1/"`
  local conf_file_temp=`grep "^conf_file" $1 | sed "s/^conf_file(|)\(.*\)$/\1/"`
  local sql_file_temp=`grep "^sql_file" $1 | sed "s/^sql_file(|)\(.*\)$/\1/"`
  local ftppubdir_temp=`grep "^ftppubdir" $1 | sed "s/^ftppubdir(|)\(.*\)$/\1/"`
  local ftpport_temp=`grep "^ftpport" $1 | sed "s/^ftpport(|)\(.*\)$/\1/"`
  local mysqlhost_temp=`grep "^mysqlhost" $1 | sed "s/^mysqlhost(|)\(.*\)$/\1/"`
  local mysqlport_temp=`grep "^mysqlport" $1 | sed "s/^mysqlport(|)\(.*\)$/\1/"`
  local mysqlacc_temp=`grep "^mysqlacc" $1 | sed "s/^mysqlacc(|)\(.*\)$/\1/"`
  local mysqlpsw_temp=`grep "^mysqlpsw" $1 | sed "s/^mysqlpsw(|)\(.*\)$/\1/"`
  local mysqldb_temp=`grep "^mysqldb" $1 | sed "s/^mysqldb(|)\(.*\)$/\1/"`

  if [ ! -z "${prog_temp}" ]; then
    prog=${prog_temp}
  fi
  if [ ! -z "${installpkg_temp}" ]; then
    installpkg=${installpkg_temp}
  fi
  if [ ! -z "${precompile_tool_temp}" ]; then
    precompile_tool=${precompile_tool_temp}
  fi
  if [ ! -z "${bindir_temp}" ]; then
    bindir=${bindir_temp}
  fi
  if [ ! -z "${sbindir_temp}" ]; then
    sbindir=${sbindir_temp}
  fi
  if [ ! -z "${libexecdir_temp}" ]; then
    libexecdir=${libexecdir_temp}
  fi
  if [ ! -z "${sysconfdir_temp}" ]; then
    sysconfdir=${sysconfdir_temp}
  fi
  if [ ! -z "${libdir_temp}" ]; then
    libdir=${libdir_temp}
  fi
  if [ ! -z "${includedir_temp}" ]; then
    includedir=${includedir_temp}
  fi
  if [ ! -z "${sharedir_temp}" ]; then
    sharedir=${sharedir_temp}
  fi
  if [ ! -z "${compile_opt_temp}" ]; then
    compile_opt=${compile_opt_temp}
  fi
  if [ ! -z "${conf_file_temp}" ]; then
    conf_file=${conf_file_temp}
  fi
  if [ ! -z "${sql_file_temp}" ]; then
    sql_file=${sql_file_temp}
  fi
  if [ ! -z "${ftppubdir_temp}" ]; then
    ftppubdir=${ftppubdir_temp}
  fi
  if [ ! -z "${ftpport_temp}" ]; then
    ftpport=${ftpport_temp}
  fi
  if [ ! -z "${mysqlhost_temp}" ]; then
    mysqlhost=${mysqlhost_temp}
  fi
  if [ ! -z "${mysqlport_temp}" ]; then
    mysqlport=${mysqlport_temp}
  fi
  if [ ! -z "${mysqlacc_temp}" ]; then
    mysqlacc=${mysqlacc_temp}
  fi
  if [ ! -z "${mysqlpsw_temp}" ]; then
    mysqlpsw=${mysqlpsw_temp}
  fi
  if [ ! -z "${mysqldb_temp}" ]; then
    mysqldb=${mysqldb_temp}
  fi
}

proftpdmysql_parsearg_null(){
  for args in $@
  do
    case ${args} in
      --installpkg=*)
        installpkg=$(general_parsearg_atom ${args})
        ;;
      --prefix=*)
        prefix=$(general_parsearg_atom ${args})
        ;;
      --bindir=*)
        bindir=$(general_parsearg_atom ${args})
        ;;
      --sbindir=*)
        sbindir=$(general_parsearg_atom ${args})
        ;;
      --libexecdir=*)
        libexecdir=$(general_parsearg_atom ${args})
        ;;
      --sysconfdir=*)
        sysconfdir=$(general_parsearg_atom ${args})
        ;;
      --libdir=*)
        libdir=$(general_parsearg_atom ${args})
        ;;
      --includedir=*)
        includedir=$(general_parsearg_atom ${args})
        ;;
      --sharedir=*)
        sharedir=$(general_parsearg_atom ${args})
        ;;
      --compile_opt=*)
        compile_opt=$(general_parsearg_atom ${args})
        ;;
      --conf_file=*)
        conf_file=$(general_parsearg_atom ${args})
        ;;
      --sql_file=*)
        sql_file=$(general_parsearg_atom ${args})
        ;;
      --ftppubdir=*)
        ftppubdir=$(general_parsearg_atom ${args})
        ;;
      --ftpport=*)
        ftpport=$(general_parsearg_atom ${args})
        ;;
      --mysqlhost=*)
        mysqlhost=$(general_parsearg_atom ${args})
        ;;
      --mysqlport=*)
        mysqlport=$(general_parsearg_atom ${args})
        ;;
      --mysqlacc=*)
        mysqlacc=$(general_parsearg_atom ${args})
        ;;
      --mysqlpsw=*)
        mysqlpsw=$(general_parsearg_atom ${args})
        ;;
      --mysqldb=*)
        mysqldb=$(general_parsearg_atom ${args})
        ;;
    esac
  done
}

proftpdmysql_precompile_prog(){
  if [ -z "$1" ]; then
    echo "Install package path not defined!"
    exit 1
  else
    installpkg="$1"
  fi

  general_checkpkgexist_null "${installpkg}"
  general_checktoolexist_null "${precompile_tool}"
}

proftpdmysql_compile_prog(){
  installpkg_filefolder=$(dirname "${installpkg}")
  installpkg_filename=$(basename "${installpkg}")
	cd ${installpkg_filefolder}
  tar xvf ${installpkg_filename}
  cd ${installpkg_filename%.*.*}
  ./configure --prefix=${prefix} --bindir=${bindir} --sbindir=${sbindir} --libexecdir=${libexecdir} --sysconfdir=${sysconfdir} --libdir=${libdir} --includedir=${includedir} --datarootdir=${sharedir} ${compile_opt}
  make -j ${cpu_processor} && make install
  cd ${installpkg_filefolder}
  rm -rf ${installpkg_filefolder}/${installpkg_filename%.*.*}
}

proftpdmysql_setenv_null(){
  if [ ! -d ${prefix}/var ]; then
    mkdir -pv ${prefix}/var
  fi
  if [ ! -d ${ftppubdir} ]; then
    mkdir -pv ${ftppubdir}
    chown ftp:ftp ${ftppubdir}
    chmod 755 ${ftppubdir}
  fi
  if [ ! -d ${ftppubdir}/pub ]; then
    mkdir -pv ${ftppubdir}/pub
    chmod 777 ${ftppubdir}/pub
  fi
}

proftpdmysql_modifyfile_configfile(){
  # Backup default config file
  cp ${sysconfdir}/${prog}.conf{,.old}

  # Process proftpd.conf
  cp ${conf_file} ${sysconfdir}/proftpd.conf
  sed -i "s/\${ip_addr}/${ip_addr}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${ftpport}/${ftpport}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${prefix}/${prefix}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${sysconfdir}/${sysconfdir}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${prog}/${prog}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${ftppubdir}/${ftppubdir}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${mysqlhost}/${mysqlhost}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${mysqlport}/${mysqlport}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${mysqlacc}/${mysqlacc}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${mysqlpsw}/${mysqlpsw}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${mysqldb}/${mysqldb}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${prefix}/${prefix}/g" ${sysconfdir}/proftpd.conf

  cat > ${sysconfdir}/welcome.msg << EOF
Welcome to CQ's FTP Server
********************
* User information *
********************
Host name      : %L
Date time      : %T
Max clients    : %M
Online clients : %N
Your host name : %R
Your account   : %U
Current path   : %C
********************
EOF
}

proftpdmysql_import_mysql(){
  mysql -h ${mysqlhost} -P ${mysqlport} -u${mysqlacc} -p${mysqlpsw} ${mysqldb} < ${sql_file}
}

proftpdmysql_createfile_controlscript(){
  cat > $prefix/$prog.sh << EOF
#!/bin/bash

# get variables
prog=$prog
exec=\$(dirname \$(readlink -f "\$0"))/sbin/proftpd
pidfile=\$(dirname \$(readlink -f "\$0"))/var/${prog}.pid
DAEMON_OPTS=""

# main function
start() {
  if [ -f \$pidfile ]; then
    execpid=\`cat \$pidfile\`
    echo -n "\$prog daemon is running, pid = \$execpid"
    echo ""
  else
    echo -n "starting \$prog..."
    \$exec \$DAEMON_OPTS 2>&1
    sleep 2
    echo "OK"
    execpid=\`cat \$pidfile\`
    echo "pid = \$execpid"
    echo ""
    retval=\$?
  fi

  return \$retval
}

stop() {
  if [ -f \$pidfile ]; then
    echo -n "stopping \$prog daemon..."
    kill -15 \`cat \$pidfile\`
    sleep 2
    echo "OK"
    retval=\$?
    rm -rf \$pidfile
  else
    echo -n "\$prog is not running."
    echo ""
  fi

  return \$retval
}

restart() {
  stop
  sleep 2
  start
}

status() {
  if [ -f \$pidfile ]; then
    execpid=\`cat \$pidfile\`
    echo -n "\$prog daemon is running, pid = \$execpid"
    echo ""
  else
    echo -n "\$prog is not running."
    echo ""
  fi
}

case "\$1" in
  start)
    start && exit 0
    ;;
  stop)
    stop
    ;;
  restart)
    restart
    ;;
  status)
    status
    ;;
  *)
  echo "Usage: \$0 {start|stop|status|restart}"

  exit 2
esac

exit \$?

EOF

  chmod 755 ${prefix}/${prog}.sh
}

proftpdmysql_install_verify(){
  tag=0
  if [ ! -d ${prefix} ]; then
    tag=1
  fi
  if [ ! -d ${ftppubdir} ]; then
    tag=1
  fi
  if [ $tag -eq 1 ]; then
    proftpdmysql_uninstall_null
    exit 1
  fi
}

proftpdmysql_uninstall_null(){
  rm -vrf "${prefix}"
  rm -vrf "${ftppubdir}"
}