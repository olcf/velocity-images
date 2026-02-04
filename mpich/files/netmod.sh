#!/usr/bin/env bash

# Detect network type and set MPICH netmod
if [ -z "${SLURM_PROCID+x}" ] || [ "${SLURM_PROCID}" -eq 0 ]; then
    if ls /sys/class/net | grep -q "hsn[0-9]"; then
        export MPIR_CVAR_CH4_NETMOD=ofi;
        echo "Setting MPIR_CVAR_CH4_NETMOD=ofi for Slingshot";
    elif ls /sys/class/net | grep -q "ib[0-9]"; then
        export MPIR_CVAR_CH4_NETMOD=ucx;
        echo "Setting MPIR_CVAR_CH4_NETMOD=ucx for InfiniBand";
    else
        echo "Cannot determine network type; MPIR_CVAR_CH4_NETMOD unchanged";
    fi;
fi;
