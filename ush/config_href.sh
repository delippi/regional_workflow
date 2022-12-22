MACHINE="hera"
ACCOUNT="fv3lam"
EXPT_SUBDIR="HREF"

COMPILER="intel"
VERBOSE="TRUE"

RUN_ENVIR="community"
PREEXISTING_DIR_METHOD="rename"

DATE_FIRST_CYCL="20220527"
DATE_LAST_CYCL="20220527"
CYCL_HRS=( "00" )

FCST_LEN_HRS="36"
#
# Since the forecast files are staged, turn off the forecast, post-
# processing, and other tasks that are not needed for generation of
# post-processed forecast files.
#
RUN_TASK_MAKE_GRID="FALSE"
RUN_TASK_MAKE_OROG="FALSE"
RUN_TASK_MAKE_SFC_CLIMO="FALSE"
RUN_TASK_GET_EXTRN_ICS="FALSE"
RUN_TASK_GET_EXTRN_LBCS="FALSE"
RUN_TASK_MAKE_ICS="FALSE"
RUN_TASK_MAKE_LBCS="FALSE"
RUN_TASK_RUN_FCST="FALSE"
RUN_TASK_RUN_POST="FALSE"
#
# Location of MET and METplus install -- with gen-ens-prod, need METv10.1 or higher!
#
METPLUS_PATH="/contrib/METplus/METplus-4.1.1"
MET_INSTALL_DIR="/contrib/met/10.1.1"
#
# Since the forecast files are staged, specify the base staging directory.
# Also, since these staged files use a naming convention that differs
# from the default convention in the SRW App, explicitly specify their
# subdirectory and file name templates.
#
VX_FCST_INPUT_BASEDIR="/scratch2/BMC/fv3lam/HIWT/HWT-SFE_data/HREFv3_byMem"
FCST_SUBDIR_TEMPLATE='{init?fmt=%Y%m%d%H?shift=-${time_lag}}${SLASH_ENSMEM_SUBDIR_OR_NULL}/postprd'
FCST_FN_TEMPLATE='${NET}.t{init?fmt=%H?shift=-${time_lag}}z.bgdawpf{lead?fmt=%HHH?shift=${time_lag}}.tm00.grib2'
FCST_FN_METPROC_TEMPLATE='${NET}.t{init?fmt=%H}z.bgdawpf{lead?fmt=%HHH}.tm00_a${ACCUM}h.nc'
#
# Since the obs are staged, deactivate the GET_OBS_... tasks and instead
# specify the obs staging directories.
#
RUN_TASK_GET_OBS_CCPA="TRUE"
CCPA_OBS_DIR="/scratch2/BMC/fv3lam/HIWT/obs_data/ccpa/proc"
RUN_TASK_GET_OBS_MRMS="TRUE"
MRMS_OBS_DIR="/scratch2/BMC/fv3lam/HIWT/obs_data/mrms/proc"
RUN_TASK_GET_OBS_NDAS="TRUE"
NDAS_OBS_DIR="/scratch2/BMC/fv3lam/HIWT/obs_data/ndas/proc"
#
# Turn on the flag that specifies that the staged forecast files represent
# an ensemble forecast and specify the number of ensemble members.
#
IS_ENS_FCST="TRUE"
NUM_ENS_MEMBERS="10"
#
# Run deterministic vx on each member of the forecast ensemble.
#
RUN_TASKS_VXDET="TRUE"
#
# Run vx on the ensemble as a whole.
#
RUN_TASKS_VXENS="TRUE"
#
# Specify other vx parameters.
#
# ENS_TIME_LAG_HRS is the time-lagging that the vx tasks should assume
# for each ensemble member (in units of hours).
#
ENS_TIME_LAG_HRS=( "0" "0" "0" "0" "0" "12" "12" "12" "6" "12" )
#
# NET is needed to construct the paths/names of the staged forecast files
# using the templates above.
#
NET="HREF"
#
# Name of the forecast model being verified, to be used in the output of
# the verification tasks.
#
VX_FCST_MODEL_NAME="HREF"

VX_APCP_ACCUMS_HRS=( "03" "06" "24" )

MAXTRIES_RUN_VXAUX_PB2NC_OBS="2"
MAXTRIES_RUN_VXAUX_PCPCOMBINE_OBS="2"
MAXTRIES_RUN_VXAUX_PCPCOMBINE_FCST="2"
MAXTRIES_RUN_VXDET_GRIDSTAT="2"
MAXTRIES_RUN_VXDET_POINTSTAT="2"
MAXTRIES_RUN_VXENS_GEPES_GRIDDED="2"
MAXTRIES_RUN_VXENS_GEPES_POINT="2"
MAXTRIES_RUN_VXENS_GRIDSTAT_MEAN="2"
MAXTRIES_RUN_VXENS_POINTSTAT_MEAN="2"
MAXTRIES_RUN_VXENS_GRIDSTAT_PROB="2"
MAXTRIES_RUN_VXENS_POINTSTAT_PROB="2"
