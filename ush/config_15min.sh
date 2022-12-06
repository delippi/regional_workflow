MACHINE="jet"
ACCOUNT="wrfruc"
EXPT_BASEDIR="/lfs1/BMC/wrfruc/jdduda"
EXPT_SUBDIR="RRFSDAS"

if [[ -n $RESERVATION ]] ; then
  ACCOUNT=rtrr
  SERVICE_ACCOUNT=rtrr
  PARTITION_DEFAULT=kjet
  PARTITION_FCST=kjet
  PARTITION_GRAPHICS=kjet
  PARTITION_ANALYSIS=kjet
  PARTITION_WGRIB2=kjet
  
  QUEUE_DEFAULT="rth"
  QUEUE_FCST="rth"
  QUEUE_ANALYSIS="rth"
  QUEUE_WGRIB2="rt"
  QUEUE_GRAPHICS="rt"
  QUEUE_HPSS="rt"
fi

if [[ $MACHINE == "hera" ]] ; then
  ACCOUNT="wrfruc"
  PARTITION_DEFAULT=""
  PARTITION_FCST=""
  QUEUE_ANALYSIS="batch"
  QUEUE_WGRIB2="batch"
  QUEUE_GRAPHICS="batch"
fi

if [[ $MACHINE == "orion" ]] ; then
  ACCOUNT=wrfruc
  QUEUE_ANALYSIS="batch"
  QUEUE_WGRIB2="batch"
  QUEUE_GRAPHICS="batch"
  QUEUE_POST="batch"
  NCORES_PER_NODE=24
fi

if [[ $MACHINE == "wcoss_dell_p3" ]] ; then
  ACCOUNT=HRRR-T2O
  QUEUE_DEFAULT="dev"
  QUEUE_ANALYSIS="dev"
  QUEUE_FCST="dev"
  QUEUE_HPSS="dev"
  QUEUE_WGRIB2="dev"
  QUEUE_GRAPHICS="dev"
fi

VERBOSE="TRUE"

RUN_ENVIR="nco"

PREDEF_GRID_NAME=RRFS_CONUS_3km
ADDNL_OUTPUT_GRIDS=()

TILE_LABELS="CONUS NE NC NW SE SC SW"
TILE_SETS="full NE NC NW SE SC SW"

DO_ENSEMBLE="TRUE"
DO_DACYCLE="FALSE"
DO_SURFACE_CYCLE="FALSE"
DO_SPINUP="FALSE"
DO_RETRO="TRUE"
DO_NONVAR_CLDANAL="TRUE"
DO_REFL2TTEN="FALSE"
RADARREFL_TIMELEVEL=(0)
FH_DFI_RADAR="-2000000000"
DO_SOIL_ADJUST="FALSE"
DO_RADDA="FALSE"
DO_BUFRSND="FALSE"

QUILTING="TRUE"
CCPP_PHYS_SUITE="FV3_HRRR"

EXTRN_MDL_ICS_OFFSET_HRS="6"
LBC_SPEC_INTVL_HRS="1"
EXTRN_MDL_LBCS_OFFSET_HRS="6"
BOUNDARY_LEN_HRS="6"
NSOUT="20"

# avaialble retro period:
# 20210511-20210531; 20210718-20210801
DATE_FIRST_CYCL="20220512"
DATE_LAST_CYCL="20220513"
#CYCL_HRS=("00" "12")
CYCL_HRS=("18")
CYCL_HRS_SPINSTART=("18")
CYCL_HRS_PRODSTART=("18")
CYCLEMONTH="5"
CYCLEDAY="12-13"

PREEXISTING_DIR_METHOD="upgrade" # "rename"
INITIAL_CYCLEDEF="${DATE_FIRST_CYCL}1800 ${DATE_LAST_CYCL}2300 24:00:00"
BOUNDARY_CYCLEDEF="${DATE_FIRST_CYCL}1800 ${DATE_LAST_CYCL}2300 24:00:00"
PROD_CYCLEDEF="${DATE_FIRST_CYCL}2100 ${DATE_LAST_CYCL}2300 01:00:00"
POSTPROC_CYCLEDEF="${DATE_FIRST_CYCL}2100 ${DATE_LAST_CYCL}2300 01:00:00"
POSTPROC_LONG_CYCLEDEF="${DATE_FIRST_CYCL}0900 ${DATE_LAST_CYCL}2300 03:00:00"
#ARCHIVE_CYCLEDEF="${DATE_FIRST_CYCL}0700 ${DATE_LAST_CYCL}2300 24:00:00"
if [[ $DO_SPINUP == "TRUE" ]] ; then
  SPINUP_CYCLEDEF="00 03-08,15-20 ${CYCLEDAY} ${CYCLEMONTH} ${DATE_FIRST_CYCL:0:4} *"
fi

FCST_LEN_HRS="1"
FCST_LEN_HRS_SPINUP="1"
POSTPROC_LEN_HRS="1"
POSTPROC_LONG_LEN_HRS="12"
FCST_LEN_HRS_CYCLES=()
#FCST_LEN_HRS_CYCLES=(48 18 18 18 18 18 48 18 18 18 18 18 48 18 18 18 18 18 48 18 18 18 18 18)
#for i in {0..23}; do FCST_LEN_HRS_CYCLES[$i]=1; done
#for i in {0..23..3}; do FCST_LEN_HRS_CYCLES[$i]=1; done
#for i in 0; do FCST_LEN_HRS_CYCLES[$i]=36; done
CYCLE_LEN_MINS="15"
DA_CYCLE_INTERV="15"
RESTART_INTERVAL="0.25"

RADARREFL_MINS=(0 -1 1 -2 2 -3 3)
RADARREFL_TIMELEVEL=(0 15 30 45)


SST_update_hour=01
GVF_update_hour=04

DT_ATMOS=45
NCORES_RUN_ANAL=240
NCORES_RUN_OBSERVER=80
HYBENSMEM_NMIN=66
HALO_BLEND=20
IO_LAYOUT_Y=1
PPN_RUN_REF2TTEN=1
PPN_RUN_NONVARCLDANL=${IO_LAYOUT_Y}

PRINT_DIFF_PGR="TRUE"
USE_IO_NETCDF="TRUE"

if [[ -n $RESERVATION ]] ; then
  NNODES_MAKE_ICS="3"
  PPN_MAKE_ICS="20"
  NNODES_MAKE_LBCS="3"
  PPN_MAKE_LBCS="20"
  NNODES_RUN_POST="1"
  PPN_RUN_POST="40"
fi

WTIME_RUN_FCST="00:45:00"
WTIME_MAKE_LBCS="02:00:00"

EXTRN_MDL_NAME_ICS="FV3GFS"
EXTRN_MDL_NAME_LBCS="FV3GFS"

FV3GFS_FILE_FMT_ICS="grib2"
FV3GFS_FILE_FMT_LBCS="grib2"

envir="para"

NET="RRFS_CONUS"
TAG="RRFSE_CONUS_3km"

USE_CUSTOM_POST_CONFIG_FILE="TRUE"
TESTBED_FIELDS_FN="testbed_fields_bgdawp.txt"
TESTBED_FIELDS_FN2=""
CUSTOM_POST_CONFIG_FP="$(cd "$( dirname "${BASH_SOURCE[0]}" )/.." &>/dev/null&&pwd)/fix/upp/postxconfig-NT-fv3lam_rrfs.txt"
CUSTOM_POST_PARAMS_FP="$(cd "$( dirname "${BASH_SOURCE[0]}" )/.." &>/dev/null&&pwd)/fix/upp/params_grib2_tbl_new"
ARCHIVEDIR="/1year/BMC/wrfruc/rrfs_dev1"
NCARG_ROOT="/apps/ncl/6.5.0-CentOS6.10_64bit_nodap_gnu447"
NCL_HOME="/home/rtrr/RRFS/graphics"
NCL_REGION="conus"
MODEL="RRFSE"

#
# In NCO mode, the following don't need to be explicitly set to "FALSE" 
# in this configuration file because the experiment generation script
# will do this (along with printing out an informational message).
#
#RUN_TASK_MAKE_GRID="FALSE"
#RUN_TASK_MAKE_OROG="FALSE"
#RUN_TASK_MAKE_SFC_CLIMO="FALSE"

if [[ $MACHINE == "wcoss_dell_p3" ]] ; then
  LAYOUT_X="42"
  LAYOUT_Y="40"
  PPN_MAKE_ICS="14"
  PPN_MAKE_LBCS="14"
  PPN_RUN_ANAL="28"
  PPN_RUN_FCST="28"
  PPN_RUN_POST="28"
  FV3GFS_FILE_FMT_ICS="netcdf"
  FV3GFS_FILE_FMT_LBCS="netcdf"
fi

if [[ ${DO_ENSEMBLE}  == "TRUE" ]]; then
   NUM_ENS_MEMBERS=30
#   DO_SPPT=TRUE
#   SPPT_MAG=0.5
#   DO_ENSCONTROL="TRUE"
   DO_GSIOBSERVER="TRUE"
   DO_ENKFUPDATE="TRUE"
   DO_RECENTER="FALSE"
   DO_ENS_GRAPHICS="TRUE"
   DO_ENKF_RADAR_REF="TRUE"
   DO_ENSPOST="FALSE"
   RADAR_REF_THINNING="2"
   ARCHIVEDIR="/5year/BMC/wrfruc/rrfs_ens"
   NNODES_RUN_RECENTER="3"
   PPN_RUN_RECENTER="31"
   CLEAN_OLDFCST_HRS="48"
   CLEAN_OLDSTMPPOST_HRS="48"
   cld_bld_hgt=0.0
   l_precip_clear_only=.true.
   write_diag_2=.true.
fi

RUN="RRFS_conus_3km"
COMINgfs=""

. set_rrfs_config.sh

STMP="/lfs1/BMC/wrfruc/jdduda/RRFSDAS/NCO_dirs/stmp"  # Path to directory STMP that mostly contains input files.
PTMP="/lfs1/BMC/wrfruc/jdduda/RRFSDAS/NCO_dirs/ptmp"  # Path to directory STMP that mostly contains post-processed model output
NWGES="/lfs1/BMC/wrfruc/jdduda/RRFSDAS/NCO_dirs/nwges"  # Path to directory NWGES that save boundary, cold initial, restart files
if [[ ${DO_RECENTER}  == "TRUE" ]]; then
   ENSCTRL_STMP="/lfs1/BMC/wrfruc/jdduda/RRFSDAS/NCO_dirs/stmp"  # Path to directory STMP that mostly contains control input files for ensemble recentering.
   ENSCTRL_PTMP="/lfs1/BMC/wrfruc/jdduda/RRFSDAS/NCO_dirs/ptmp"  # Path to directory STMP that mostly contains control input files for ensemble recentering.
   ENSCTRL_NWGES="/lfs1/BMC/wrfruc/jdduda/RRFSDAS/NCO_dirs/nwges"  # Path to directory STMP that mostly contains control input files for ensemble recentering.
fi

