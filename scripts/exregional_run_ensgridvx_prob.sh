#!/bin/bash

#
#-----------------------------------------------------------------------
#
# Source the variable definitions file and the bash utility functions.
#
#-----------------------------------------------------------------------
#
. ${GLOBAL_VAR_DEFNS_FP}
. $USHDIR/source_util_funcs.sh
#
#-----------------------------------------------------------------------
#
# Save current shell options (in a global array).  Then set new options
# for this script/function.
#
#-----------------------------------------------------------------------
#
{ save_shell_opts; set -u +x; } > /dev/null 2>&1
#
#-----------------------------------------------------------------------
#
# Get the full path to the file in which this script/function is located 
# (scrfunc_fp), the name of that file (scrfunc_fn), and the directory in
# which the file is located (scrfunc_dir).
#
#-----------------------------------------------------------------------
#
scrfunc_fp=$( $READLINK -f "${BASH_SOURCE[0]}" )
scrfunc_fn=$( basename "${scrfunc_fp}" )
scrfunc_dir=$( dirname "${scrfunc_fp}" )
#
#-----------------------------------------------------------------------
#
# Print message indicating entry into script.
#
#-----------------------------------------------------------------------
#
print_info_msg "
========================================================================
Entering script:  \"${scrfunc_fn}\"
In directory:     \"${scrfunc_dir}\"

This is the ex-script for the task that runs METplus for grid-stat on
the UPP output files by initialization time for all forecast hours for 
gridded data.
========================================================================"
#
#-----------------------------------------------------------------------
#
# Specify the set of valid argument names for this script/function.  
# Then process the arguments provided to this script/function (which 
# should consist of a set of name-value pairs of the form arg1="value1",
# etc).
#
#-----------------------------------------------------------------------
#
valid_args=( "cycle_dir" )
process_args valid_args "$@"
#
#-----------------------------------------------------------------------
#
# For debugging purposes, print out values of arguments passed to this
# script.  Note that these will be printed out only if VERBOSE is set to
# TRUE.
#
#-----------------------------------------------------------------------
#
print_input_args "valid_args"
#
#-----------------------------------------------------------------------
#
# Begin grid-to-grid vx on ensemble output.
#
#-----------------------------------------------------------------------
#
print_info_msg "$VERBOSE" "Starting grid-stat verification"
#
#-----------------------------------------------------------------------
#
# Get the cycle date and hour (in formats of yyyymmdd and hh, respect-
# ively) from CDATE.
#
#-----------------------------------------------------------------------
#
echo "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU"
set -x

#yyyymmdd=${CDATE:0:8}
#hh=${CDATE:8:2}
#cyc=$hh
#export CDATE
#export hh

#
#-----------------------------------------------------------------------
#
# Create a comma-separated list of forecast hours for METplus to step
# through.
#
#-----------------------------------------------------------------------
#
export fhr_last=${FCST_LEN_HRS}

fhr_array=($( seq ${ACCUM:-1} ${ACCUM:-1} ${FCST_LEN_HRS} ))
export fhr_list=$( echo "${fhr_array[@]}" | $SED "s/ /,/g" )
echo "fhr_list = |${fhr_list}|"
#
#-----------------------------------------------------------------------
#
# Set OUTPUT_BASE for use in METplus configuration files.
#
#-----------------------------------------------------------------------
#
OUTPUT_BASE=${MET_OUTPUT_DIR}
#
#-----------------------------------------------------------------------
#
# Create the directory(ies) in which MET/METplus will place its output
# from this script.  We do this here because (as of 20220811), when
# multiple workflow tasks are launched that all require METplus to create
# the same directory, some of the METplus tasks can fail.  This is a
# known bug and should be fixed by 20221000.  See https://github.com/dtcenter/METplus/issues/1657.
# If/when it is fixed, the following directory creation step can be
# removed from this script.
#
#-----------------------------------------------------------------------
#
mkdir_vrfy -p "${OUTPUT_BASE}/${CDATE}/metprd/grid_stat_prob"  # Output directory for GridStat tool.
#
#-----------------------------------------------------------------------
#
# Check for existence of top-level OBS_DIR.
#
#-----------------------------------------------------------------------
#
if [ ! -d "${OBS_DIR}" ]; then
  print_err_msg_exit "\
OBS_DIR does not exist or is not a directory:
  OBS_DIR = \"${OBS_DIR}\""
fi
#
#-----------------------------------------------------------------------
#
# Set variables needed in forming the names of METplus configuration and
# log files.
#
#-----------------------------------------------------------------------
#
acc=""
if [ "${VAR}" = "APCP" ]; then
  acc="${ACCUM}h"
fi
config_fn_str="${VAR}${acc}_prob"
LOG_SUFFIX="ensgrid_prob_${CDATE}_${VAR}${acc:+_${acc}}"
#
#-----------------------------------------------------------------------
#
# Export variables to environment to make them accessible in METplus
# configuration files.
#
#-----------------------------------------------------------------------
#
export EXPTDIR
export LOGDIR
export CDATE
export OUTPUT_BASE
export LOG_SUFFIX
export MET_INSTALL_DIR
export MET_BIN_EXEC
export METPLUS_PATH
export METPLUS_CONF
export MET_CONFIG
export MODEL
export NET
export POST_OUTPUT_DOMAIN_NAME
export acc
#
#-----------------------------------------------------------------------
#
# Run METplus.
#
#-----------------------------------------------------------------------
#
print_info_msg "$VERBOSE" "
Calling METplus to run MET's GridStat tool..."
metplus_config_fp="${METPLUS_CONF}/GridStat_${config_fn_str}.conf"
${METPLUS_PATH}/ush/run_metplus.py \
  -c ${METPLUS_CONF}/common.conf \
  -c ${metplus_config_fp} || \
print_err_msg_exit "
Call to METplus failed with return code: $?
METplus configuration file used is:
  metplus_config_fp = \"${metplus_config_fp}\""
#print_info_msg "
#METplus/GridStat returned with the following non-zero return code: $?"
#
#-----------------------------------------------------------------------
#
# Print message indicating successful completion of script.
#
#-----------------------------------------------------------------------
#
print_info_msg "
========================================================================
METplus grid-stat completed successfully.

Exiting script:  \"${scrfunc_fn}\"
In directory:    \"${scrfunc_dir}\"
========================================================================"
#
#-----------------------------------------------------------------------
#
# Restore the shell options saved at the beginning of this script/func-
# tion.
#
#-----------------------------------------------------------------------
#
{ restore_shell_opts; } > /dev/null 2>&1
