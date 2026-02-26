#!/bin/sh

if [ -f /.singularity.d/env/99-netmod.sh ]; then
    . /.singularity.d/env/99-netmod.sh;
fi;

exec "$@";
