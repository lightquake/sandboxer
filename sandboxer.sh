#!/bin/bash


if [ -z "$SANDBOXER_ROOT" ]; then
    export SANDBOXER_ROOT="$HOME/.sandboxer"
fi

_activate() {
    if [ -e $SANDBOXER_ROOT/$1 ]; then
        export SANDBOXER_BOX=$1
    else
        echo "$SANDBOXER_ROOT/$1 does not exist";
    fi
}

function sandboxer() {
    case $1 in
        init)
            echo "Making sandbox $2"
            mkdir ~/.sandboxer/$2
            _activate $2
            ;;
        activate)
            _activate $2
            ;;
        deactivate)
            unset SANDBOXER_BOX
            ;;
        *)
            cat <<EOF
sandboxer is a shell script that helps you manage cabal-dev sandboxes even in
sandbox-unaware applications.

Usage:
sandboxer init <name>       -- create a new sandbox and activate it
sandboxer activate <name>   -- activate a sandbox
sandboxer deactivate <name> -- deactivate the current sandbox
EOF
            ;;
    esac

}