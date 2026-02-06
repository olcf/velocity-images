#!/bin/sh

# check if MPIR_CVAR_CH4_NETMOD has already been defined
if [ -z "${MPIR_CVAR_CH4_NETMOD}" ]; then
    # export SLURM_PROCID if it exists
    for kv in "${__exported_env__}"; do
        case "${kv}" in
            SLURM_PROCID=*)
                export "${kv}";
                break;
                ;;
        esac;
    done;

    # detect network type and set MPIR_CVAR_CH4_NETMOD
    # only print action if SLURM_PROCID undefined or equal to 0
    if [ "${SLURM_PROCID:-0}" = "0" ]; then
        if ls /sys/class/net | grep -q "hsn[0-9]"; then
            export MPIR_CVAR_CH4_NETMOD=ofi;
            echo "Setting MPIR_CVAR_CH4_NETMOD=ofi for Slingshot";
        elif ls /sys/class/net | grep -q "ib[0-9]"; then
            export MPIR_CVAR_CH4_NETMOD=ucx;
            echo "Setting MPIR_CVAR_CH4_NETMOD=ucx for InfiniBand";
        else
            echo "Cannot determine network type; MPIR_CVAR_CH4_NETMOD unchanged";
        fi;
    else
        if ls /sys/class/net | grep -q "hsn[0-9]"; then
            export MPIR_CVAR_CH4_NETMOD=ofi;
        elif ls /sys/class/net | grep -q "ib[0-9]"; then
            export MPIR_CVAR_CH4_NETMOD=ucx;
        fi;
    fi;
fi;