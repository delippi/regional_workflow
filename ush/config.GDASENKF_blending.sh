MACHINE="wcoss2"
version="v0.4.0"
ACCOUNT="RRFS_DEV"
#RESERVATION="rrfsens"
#RESERVATION_POST="rrfsdet"
#EXPT_BASEDIR="/misc/whome/wrfruc/RRFSE/rrfs.${version}"
#EXPT_BASEDIR="/lfs1/BMC/wrfruc/chunhua/May2022_retro/Ens_Ctrl_newApp/${version}"
EXPT_BASEDIR="/lfs/h2/emc/da/noscrub/donald.e.lippi/rrfs/June2022_retro/Ens_blending/$version/"
EXPT_SUBDIR="RRFS_CONUS_3km_ens_GDASENKF_blending"

PREDEF_GRID_NAME=RRFS_CONUS_3km

. set_rrfs_config_general.sh

#ACCOUNT="rtwrfruc"
#SERVICE_ACCOUNT="rtwrfruc"
#RESERVATION="rrfsens"
#RESERVATION_POST="rrfsens"
ACCOUNT=RRFS-DEV
HPSS_ACCOUNT="RRFS-DEV"
QUEUE_DEFAULT="dev"
QUEUE_ANALYSIS="dev"
QUEUE_FCST="dev"
QUEUE_HPSS="dev_transfer"
QUEUE_PRDGEN="dev"
QUEUE_GRAPHICS="dev"

CLEAN_OLDPROD_HRS="240"
CLEAN_OLDLOG_HRS="240"
CLEAN_OLDRUN_HRS="24"
CLEAN_OLDFCST_HRS="24"
CLEAN_OLDSTMPPOST_HRS="24"
CLEAN_NWGES_HRS="240"

DO_BLENDING="TRUE"
DO_ENSEMBLE="TRUE"
#DO_ENSFCST="TRUE"
#DO_DACYCLE="TRUE"
#DO_SURFACE_CYCLE="TRUE"
DO_SPINUP="TRUE"
DO_SAVE_DA_OUTPUT="TRUE"
DO_POST_SPINUP="TRUE"
DO_POST_PROD="TRUE"
DO_RETRO="TRUE"
DO_NONVAR_CLDANAL="TRUE"
#DO_ENVAR_RADAR_REF="TRUE"
DO_SMOKE_DUST="FALSE"
#DO_REFL2TTEN="FALSE"
#RADARREFL_TIMELEVEL=(0)
#FH_DFI_RADAR="0.0,0.25,0.5"
#DO_SOIL_ADJUST="TRUE"
#DO_RADDA="FALSE"
#DO_BUFRSND="TRUE"
#USE_FVCOM="TRUE"
#PREP_FVCOM="TRUE"

if [[ ${DO_ENSFCST} == "TRUE" ]] ; then
  DO_SPINUP="FALSE"
  DO_SAVE_DA_OUTPUT="FALSE"
  DO_NONVAR_CLDANAL="FALSE"
  DO_POST_PROD="TRUE"
fi

#EXTRN_MDL_ICS_OFFSET_HRS="30"
EXTRN_MDL_ICS_OFFSET_HRS="6"
LBC_SPEC_INTVL_HRS="1"
EXTRN_MDL_LBCS_OFFSET_HRS="6"
BOUNDARY_LEN_HRS="12"
BOUNDARY_PROC_GROUP_NUM="4"

# avaialble retro period:
# 20210511-20210531; 20210718-20210801
DATE_FIRST_CYCL="20220720"
DATE_LAST_CYCL="20220720"
CYCL_HRS=( "00" "12" )
CYCL_HRS=( "18" )
CYCL_HRS_SPINSTART=("06" "18")
CYCL_HRS_PRODSTART=("07" "19")
if [[ ${DO_ENSFCST} == "TRUE" ]] ; then
  CYCL_HRS_STOCH=("00" "06" "12" "18")
fi
#CYCL_HRS_RECENTER=("19")
CYCLEMONTH="07"
CYCLEDAY="20"

STARTYEAR=${DATE_FIRST_CYCL:0:4}
STARTMONTH=${DATE_FIRST_CYCL:4:2}
STARTDAY=${DATE_FIRST_CYCL:6:2}
STARTHOUR="00"
ENDYEAR=${DATE_LAST_CYCL:0:4}
ENDMONTH=${DATE_LAST_CYCL:4:2}
ENDDAY=${DATE_LAST_CYCL:6:2}
ENDHOUR="23"

PREEXISTING_DIR_METHOD="upgrade" # "rename"
INITIAL_CYCLEDEF="${DATE_FIRST_CYCL}0600 ${DATE_LAST_CYCL}2300 12:00:00"
BOUNDARY_CYCLEDEF="${DATE_FIRST_CYCL}0600 ${DATE_LAST_CYCL}2300 06:00:00"
PROD_CYCLEDEF="${DATE_FIRST_CYCL}0700 ${DATE_LAST_CYCL}2300 01:00:00"
PRODLONG_CYCLEDEF="00 01 01 01 2100 *"
#RECENTER_CYCLEDEF="00 19 * 10 2022 *"
#ARCHIVE_CYCLEDEF="${DATE_FIRST_CYCL}1500 ${DATE_LAST_CYCL}2300 24:00:00"
if [[ ${DO_ENSFCST} == "TRUE" ]] ; then
  BOUNDARY_LEN_HRS="36"
  INITIAL_CYCLEDEF="00 01 01 01 2100 *"
  BOUNDARY_CYCLEDEF="${DATE_FIRST_CYCL}1200 ${DATE_LAST_CYCL}2300 06:00:00"
  PROD_CYCLEDEF="${DATE_FIRST_CYCL}1200 ${DATE_LAST_CYCL}2300 06:00:00"
fi
if [[ $DO_SPINUP == "TRUE" ]] ; then
  SPINUP_CYCLEDEF="${DATE_FIRST_CYCL}0600 ${DATE_LAST_CYCL}2300 12:00:00"
fi
if [[ $DO_SAVE_DA_OUTPUT == "TRUE" ]] ; then
  SAVEDA_CYCLEDEF="${DATE_FIRST_CYCL}1200 ${DATE_LAST_CYCL}2300 06:00:00"
fi

FCST_LEN_HRS="1"
FCST_LEN_HRS_SPINUP="1"
POSTPROC_LEN_HRS="1"
#FCST_LEN_HRS_CYCLES=(48 18 18 18 18 18 48 18 18 18 18 18 48 18 18 18 18 18 48 18 18 18 18 18)
for i in {0..23}; do FCST_LEN_HRS_CYCLES[$i]=1; done
for i in {0..23..6}; do FCST_LEN_HRS_CYCLES[$i]=1; done 
if [[ ${DO_ENSFCST} == "TRUE" ]] ; then
  for i in {0..23..06}; do FCST_LEN_HRS_CYCLES[$i]=24; done 
  POSTPROC_LEN_HRS="24"
  BOUNDARY_PROC_GROUP_NUM="8"
fi
DA_CYCLE_INTERV="1"
RESTART_INTERVAL="1"
RESTART_INTERVAL_LONG="1"
netcdf_diag=.true.
binary_diag=.false.

## set up post
NFHOUT_HF="1"
NFHMAX_HF="12"
NFHOUT="3"

WTIME_RUN_FCST="01:00:00"
WTIME_MAKE_LBCS="02:00:00"

#EXTRN_MDL_NAME_ICS="GEFS"
EXTRN_MDL_NAME_ICS="GDASENKF"
EXTRN_MDL_NAME_LBCS="GEFS"
envir="para"
NET="rrfs_b"
ARCHIVEDIR="/1year/BMC/wrfruc/rrfs_b"
NCL_REGION="conus"
MODEL="RRFS_conus_3km"

if [[ ${DO_ENSEMBLE}  == "TRUE" ]]; then
   NUM_ENS_MEMBERS=30
#   DO_ENSCONTROL="TRUE"
   DO_GSIOBSERVER="TRUE"
   DO_ENKFUPDATE="TRUE"
#   DO_RECENTER="TRUE"
   DO_ENS_GRAPHICS="TRUE"
   DO_ENKF_RADAR_REF="TRUE"
   DO_ENSPOST="TRUE"
   DO_ENSINIT="TRUE"

   RADAR_REF_THINNING="2"
   ARCHIVEDIR="/5year/BMC/wrfruc/rrfs_ens"
#   CLEAN_OLDFCST_HRS="12"
#   CLEAN_OLDSTMPPOST_HRS="12"
   cld_bld_hgt=0.0
   l_precip_clear_only=.true.
   write_diag_2=.true.

   START_TIME_SPINUP="00:30:00"
#   LAYOUT_X="11"
#   LAYOUT_Y="32"
#   NNODES_RUN_FCST="6"

   NUM_ENS_MEMBERS_FCST=9
   if [[ ${DO_ENSFCST} == "TRUE" ]] ; then
     NUM_ENS_MEMBERS=${NUM_ENS_MEMBERS_FCST}
     WTIME_RUN_FCST="04:45:00"
     WTIME_MAKE_LBCS="01:30:00"
     TAG="cefcst38"

#     LAYOUT_X="31"
#     LAYOUT_Y="32"
#     NNODES_RUN_FCST="16"

     DO_SPP="TRUE"
     DO_SPPT="TRUE"
     DO_SKEB="FALSE"
     SPPT_MAG="0.7"
     DO_LSM_SPP="TRUE"

   fi
   PPN_RUN_RECENTER="$(( ${NUM_ENS_MEMBERS} + 1 ))"
   NNODES_RUN_RECENTER="3"
#   NNODES_RUN_RECENTER="10"
#   PPN_RUN_RECENTER="128"

   CLEAN_OLDFCST_HRS="48"
   CLEAN_OLDSTMPPOST_HRS="48"
fi

RUN_ensctrl="rrfs"
RUN="rrfs_conus_3km_ensda"
TAG="c3enkf40"
if [[ ${DO_ENSFCST} == "TRUE" ]] ; then
  RUN="rrfs_conus_3km_ensfcst"
  TAG="c3enfcst40"
fi

. set_rrfs_config.sh

#STMP="/mnt/lfs4/BMC/wrfruc/RRFSE/${version}/stmp_ensda"  # Path to directory STMP that mostly contains input files.
STMP="/lfs/h2/emc/stmp/donald.e.lippi/rrfs/June2022_retro/Ens_blending/${version}/ensda"
if [[ ${DO_ENSFCST} == "TRUE" ]] ; then
  STMP="/lfs/h2/emc/stmp/donald.e.lippi/rrfs/June2022_retro/Ens_blending/${version}/ensfcst"
fi
#PTMP="/mnt/lfs4/BMC/wrfruc/RRFSE/${version}"  # Path to directory STMP that mostly contains input files.
#NWGES="/mnt/lfs4/BMC/wrfruc/RRFSE/${version}/nwges"  # Path to directory NWGES that save boundary, cold initial, restart files
#ENSCTRL_STMP="/mnt/lfs4/BMC/nrtrr/${version}/stmp"  # Path to directory STMP that mostly contains control input files for ensemble recentering.
#ENSCTRL_PTMP="/mnt/lfs4/BMC/nrtrr/${version}"  # Path to directory STMP that mostly contains control input files for ensemble recentering.
#ENSCTRL_NWGES="/mnt/lfs4/BMC/nrtrr/${version}/nwges"  # Path to directory STMP that mostly contains control input files for ensemble recentering.
PTMP="/lfs/h2/emc/ptmp/donald.e.lippi/rrfs/June2022_retro/Ens_blending/${version}"
NWGES="/lfs/h2/emc/ptmp/donald.e.lippi/rrfs/June2022_retro/Ens_blending/${version}/nwges"
ENSCTRL_STMP="/lfs/h2/emc/stmp/donald.e.lippi/rrfs/June2022_retro/Ens_blending/${version}/ctrl"
ENSCTRL_PTMP="/lfs/h2/emc/ptmp/donald.e.lippi/rrfs/June2022_retro/Ens_blending/${version}"
ENSCTRL_NWGES="/lfs/h2/emc/ptmp/donald.e.lippi/rrfs/June2022_retro/Ens_blending/${version}/nwges"