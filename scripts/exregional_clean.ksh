#!/bin/ksh --login

currentime=`date`

. ${GLOBAL_VAR_DEFNS_FP}

# Delete ptmp directories
#deletetime=`date +%Y%m%d -d "${currentime} 72 hours ago"`
#echo "Deleting ptmp directories before ${deletetime}..."
#cd ${COMOUT_BASEDIR}
#set -A XX `ls -d ${RUN}.20* | sort -r`
#for dir in ${XX[*]};do
#  onetime=`echo $dir | cut -d'.' -f2`
#  if [[ ${onetime} -le ${deletetime} ]]; then
#    rm -rf ${COMOUT_BASEDIR}/${RUN}.${onetime}${SLASH_ENSMEM_SUBDIR}
#    echo "Deleted ${COMOUT_BASEDIR}/${RUN}.${onetime}${SLASH_ENSMEM_SUBDIR}"
#  fi
#done

# Delete stmp directories
deletetime=`date +%Y%m%d%H -d "${currentime} 72 hours ago"`
echo "Deleting stmp directories before ${deletetime}..."
cd ${CYCLE_BASEDIR}
set -A XX `ls -d 20* | sort -r`
for onetime in ${XX[*]};do
  if [[ ${onetime} -le ${deletetime} ]]; then
    rm -rf ${CYCLE_BASEDIR}/${onetime}${SLASH_ENSMEM_SUBDIR}
    echo "Deleted ${CYCLE_BASEDIR}/${onetime}${SLASH_ENSMEM_SUBDIR}"
  fi
done

# Delete netCDF files
deletetime=`date +%Y%m%d%H -d "${currentime} 36 hours ago"`
echo "Deleting netCDF files before ${deletetime}..."
cd ${CYCLE_BASEDIR}
set -A XX `ls -d 20* | sort -r`
for onetime in ${XX[*]};do
  if [[ ${onetime} -le ${deletetime} ]]; then
    rm -f ${CYCLE_BASEDIR}/${onetime}${SLASH_ENSMEM_SUBDIR}/phy*nc
    rm -f ${CYCLE_BASEDIR}/${onetime}${SLASH_ENSMEM_SUBDIR}/dyn*nc
    rm -rf ${CYCLE_BASEDIR}/${onetime}${SLASH_ENSMEM_SUBDIR}/RESTART
    rm -rf ${CYCLE_BASEDIR}/${onetime}${SLASH_ENSMEM_SUBDIR}/INPUT
    echo "Deleted netCDF files in ${CYCLE_BASEDIR}/${onetime}${SLASH_ENSMEM_SUBDIR}"
  fi
done

# Delete old log files
#deletetime=`date +%Y%m%d%H -d "${currentime} 72 hours ago"`
#echo "Deleting log files before ${deletetime}..."

# Remove template date from last two levels
#logs=`echo ${LOGDIR} | rev | cut -f 3- -d / | rev`
#cd ${logs}
#pwd
#set -A XX `ls -d ${RUN}.20*/* | sort -r`
#for onetime in ${XX[*]}; do
#  # Remove slash and RUN from directory to get time
#  filetime=${onetime/\//}
#  filetime=${filetime##*.}
#  # Remove cycle subdir from path
#  logsdate=${onetime%%/*}
#  if [[ ${filetime} -le ${deletetime} ]]; then
#    echo "Deleting files from ${logs}/${onetime}${SLASH_ENSMEM_SUBDIR}"
#    rm -rf ${onetime}${SLASH_ENSMEM_SUBDIR}
#    # Remove an empty date directory
#    [ "$(ls -A $logsdate)" ] || rmdir $logsdate
#  fi
#done

exit 0