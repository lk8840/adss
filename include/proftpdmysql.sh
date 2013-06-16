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

  conf_file=""
  sql_file=""

  ftppubdir="/opt/ftp"
  ftpport="21"
  
  mysqlhost="localhost"
  mysqlport="3306"
  mysqlacc="proftpd"
  mysqlpsw="proftpd"
  mysqldb="proftpd"
}

proftpdmysql_parsearg_null(){
  for args in $@
  do
    case $args in
      --installpkg=*)
        installpkg=$(general_parsearg_atom $args)
        ;;
      --prefix=*)
        prefix=$(general_parsearg_atom $args)
        ;;
      --bindir=*)
        bindir=$(general_parsearg_atom $args)
        ;;
      --sbindir=*)
        sbindir=$(general_parsearg_atom $args)
        ;;
      --libexecdir=*)
        libexecdir=$(general_parsearg_atom $args)
        ;;
      --sysconfdir=*)
        sysconfdir=$(general_parsearg_atom $args)
        ;;
      --libdir=*)
        libdir=$(general_parsearg_atom $args)
        ;;
      --includedir=*)
        includedir=$(general_parsearg_atom $args)
        ;;
      --sharedir=*)
        sharedir=$(general_parsearg_atom $args)
        ;;
      --compile_opt=*)
        compile_opt=$(general_parsearg_atom $args)
        ;;
      --conf_file=*)
        conf_file=$(general_parsearg_atom $args)
        ;;
      --sql_file=*)
        sql_file=$(general_parsearg_atom $args)
        ;;
      --ftppubdir=*)
        ftppubdir=$(general_parsearg_atom $args)
        ;;
      --ftpport=*)
        ftpport=$(general_parsearg_atom $args)
        ;;
      --mysqlhost=*)
        mysqlhost=$(general_parsearg_atom $args)
        ;;
      --mysqlport=*)
        mysqlport=$(general_parsearg_atom $args)
        ;;
      --mysqlacc=*)
        mysqlacc=$(general_parsearg_atom $args)
        ;;
      --mysqlpsw=*)
        mysqlpsw=$(general_parsearg_atom $args)
        ;;
      --mysqldb=*)
        mysqldb=$(general_parsearg_atom $args)
        ;;
    esac
  done
}

proftpdmysql_precompile_prog(){
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
  cp ${script_path}/src/proftpdmysql_proftpd.conf ${sysconfdir}/proftpd.conf
  sed -i "s/\${ip_addr}/${ip_addr}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${ftpport}/${ftpport}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${prefix}/${prefix}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${sysconfdir}/${sysconfdir}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${prog}/${prog}/g" ${sysconfdir}/proftpd.conf
  sed -i "s/\${ftppubdir}/${ftppubdir}/g" ${sysconfdir}/proftpd.conf

  # Process mysql.conf
  cp ${script_path}/src/proftpdmysql_mysql.conf ${sysconfdir}/mysql.conf
  sed -i "s/\${mysqlhost}/${mysqlhost}/g" ${sysconfdir}/mysql.conf
  sed -i "s/\${mysqlport}/${mysqlport}/g" ${sysconfdir}/mysql.conf
  sed -i "s/\${mysqlacc}/${mysqlacc}/g" ${sysconfdir}/mysql.conf
  sed -i "s/\${mysqlpsw}/${mysqlpsw}/g" ${sysconfdir}/mysql.conf
  sed -i "s/\${mysqldb}/${mysqldb}/g" ${sysconfdir}/mysql.conf

  # Process quota.conf
  cp ${script_path}/src/proftpdmysql_quota.conf ${sysconfdir}/quota.conf
  sed -i "s/\${prefix}/${prefix}/g" ${sysconfdir}/quota.conf

  # Process welcome.msg
  cp ${script_path}/src/proftpdmysql_welcome.msg ${sysconfdir}/welcome.msg
}

proftpdmysql_import_mysql(){
  mysql -h ${mysqlhost} -P ${mysqlport} -u${mysqlacc} -p${mysqlpsw} ${mysqldb} < ${script_path}/src/proftpdmysql_proftpd.sql
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