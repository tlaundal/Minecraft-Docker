#!/bin/bash

# A little script to split args.
# Usage:
#     ./args-split.sh <first> -- <third> -- <second> -- <fourth>
# This script will then take the args and put them in the correct order.
# The intended usage is to split args for launching java jars through docker
# The normal usage is this:
#     ./args-split.sh <some command> -- <hard coded args> -- ${prefix} -- ${suffix}

args=( "$@" )

# Our argument arrays
first=()
third=()
second=()
fourth=()

# Pass the arguments into the right arrays
counter=0
for index in "${!args[@]}"
do
    element=${args[index]}
    if [ "$element" == "--" ]
    then
        counter=$(( counter + 1 ))
        continue
    fi
    case "$counter" in
    0)  first+=( "$element" )
        ;; 
    1)  third+=( "$element" )
        ;;
    2)  second+=( "$element" )
        ;;
    3)  fourth+=( "$element" )
        ;;
    *)  continue
        ;;
    esac
done

if (( $counter != 3 ))
then
    echo "Wrong format"
    exit 1
fi

# Execute the command
eval "${first[@]} ${second[@]} ${third[@]} ${fourth[@]}"
