#!/bin/bash
file="/home/ec2-user/bsc.txt"
command=""
next=""
while IFS= read -r line
do
    if [ "$command" == "DROPPED" ]; then
        if [ "$next" == "PRINT" ]; then
            set -- $line
            next=""
            echo "$1"
        fi
    fi

    #find and set command
    if [ "$line" == "<rlstp:cell=all,state=halted;" ]; then
        command="HALTED"
        echo "Halted sites"
    elif [ "$line" == "<rlstp:cell=all,state=active;" ]; then
        command="ACTIVE"
        echo "Active sites"
    elif [ "$line" == "<allip:alcat=kesinti;" ]; then
        command="DROPPED"
        echo "Dropped sites"
    fi

    if [ "$command" == "HALTED" ]; then
        set -- $line
        if [ "$4" == "HALTED" ]; then
            echo "$1"
        fi
    fi

    if [ "$command" == "ACTIVE" ]; then
        set -- $line
        if [ "$4" == "ACTIVE" ]; then
            echo "$1"
        fi
    fi

    if [ "$command" == "DROPPED" ]; then
        if [ "$line" == "CELL       SCTYPE      CHTYPE       CHRATE    SPV" ]; then
            next="PRINT"
        else
            next=""
        fi
    fi

done <"$file"