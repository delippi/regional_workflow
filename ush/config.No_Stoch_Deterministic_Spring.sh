MACHINE="hera"
ACCOUNT="hmtb"
EXPT_SUBDIR="No_Stoch_Deterministic_Spring"

USE_CRON_TO_RELAUNCH="TRUE"
CRON_RELAUNCH_INTVL_MNTS="02"

COMPILER="intel"
VERBOSE="TRUE"

RUN_ENVIR="community"
PREEXISTING_DIR_METHOD="rename"

PREDEF_GRID_NAME="RRFS_CONUScompact_3km"

RUN_TASK_RUN_POST="TRUE"

CCPP_PHYS_SUITE="FV3_HRRR"
FCST_LEN_HRS="36"
LBC_SPEC_INTVL_HRS="3"

DATE_FIRST_CYCL="20210511"
DATE_LAST_CYCL="20210518"
CYCL_HRS=( "00" )

EXTRN_MDL_NAME_ICS="HRRR"
EXTRN_MDL_NAME_LBCS="RAP"

QUILTING="TRUE"

WTIME_RUN_FCST="05:00:00"

MODEL="FV3_HRRR_CONUS_3KM_NO_STOCH_DETERMINISTIC"
METPLUS_PATH="/contrib/METplus/METplus-4.1.1"
MET_INSTALL_DIR="/contrib/met/10.1.1"
CCPA_OBS_DIR="/scratch2/BMC/fv3lam/HIWT/obs_data/ccpa/proc"
MRMS_OBS_DIR="/scratch2/BMC/fv3lam/HIWT/obs_data/mrms/proc"
NDAS_OBS_DIR="/scratch2/BMC/fv3lam/HIWT/obs_data/ndas/proc"

WTIME_GET_OBS_CCPA="08:00:00"
WTIME_GET_OBS_MRMS="08:00:00"
WTIME_GET_OBS_NDAS="08:00:00"

RUN_TASK_MAKE_GRID="TRUE"
RUN_TASK_MAKE_OROG="TRUE"
RUN_TASK_MAKE_SFC_CLIMO="TRUE"
RUN_TASK_GET_OBS_CCPA="TRUE"
RUN_TASK_GET_OBS_MRMS="TRUE"
RUN_TASK_GET_OBS_NDAS="TRUE"
RUN_TASK_VX_GRIDSTAT="TRUE"
RUN_TASK_VX_POINTSTAT="TRUE"
#RUN_TASK_VX_ENSGRID="TRUE"
#RUN_TASK_VX_ENSPOINT="TRUE"

#
# Uncomment the following line in order to use user-staged external model 
# files with locations and names as specified by EXTRN_MDL_SOURCE_BASEDIR_ICS/
# LBCS and EXTRN_MDL_FILES_ICS/LBCS.
#
#USE_USER_STAGED_EXTRN_FILES="TRUE"
#
# The following is specifically for Hera.  It will have to be modified
# if on another platform, using other dates, other external models, etc.
# Uncomment the following EXTRN_MDL_*_ICS/LBCS only when USE_USER_STAGED_EXTRN_FILES=TRUE
#
#EXTRN_MDL_SOURCE_BASEDIR_ICS="/scratch2/BMC/det/UFS_SRW_app/v1p0/model_data/FV3GFS"
#EXTRN_MDL_FILES_ICS=( "gfs.pgrb2.0p25.f000" )
#EXTRN_MDL_SOURCE_BASEDIR_LBCS="/path/to/model_data/FV3GFS"
#EXTRN_MDL_FILES_LBCS=( "gfs.pgrb2.0p25.f006" "gfs.pgrb2.0p25.f012" "gfs.pgrb2.0p25.f018" "gfs.pgrb2.0p25.f024" \
#                       "gfs.pgrb2.0p25.f030" "gfs.pgrb2.0p25.f036" "gfs.pgrb2.0p25.f042" "gfs.pgrb2.0p25.f048" )
