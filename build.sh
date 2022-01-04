# !/bin/bash
comp_dir='.'
comp_dir_lib='WEB-INF'
compile_dir (){
  _cur_dir=$1 
  _getdir="$(ls $_cur_dir)"
  for f in ${_getdir}; do
    rdr="$_cur_dir/$f"
    # echo ${rdr} "is compiled"
    
    if [ -d "${rdr}" ]; then 
      # echo "dir: ${rdr}"
      # echo ${PWD}
      compile_dir ${rdr} &
      wait
    else
      case ${rdr} in
        SendMail.java )
          # echo "    file: ${rdr}"
          javac -cp /usr/share/java/javamail/:${comp_dir_lib}/lib/*:${comp_dir}/. ${rdr}
          ;;
        *.java )
          # echo "    file: ${rdr}"
          javac -cp ${comp_dir_lib}/lib/*:${comp_dir}/. ${rdr}
          ;;
      esac
      # touch "compiled"
      # echo ${rdr} "is compiled"
    fi
  done 
}
# chown tomcat -R WEB-INF/*
compile_dir ${comp_dir}