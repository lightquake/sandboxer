#!/bin/bash


if [ -z "$SANDBOXER_ROOT" ]; then
    export SANDBOXER_ROOT="$HOME/.sandboxer"
fi

_activate() {
    if [ ! -e $SANDBOXER_ROOT/$1 ]; then
        echo "$SANDBOXER_ROOT/$1 does not exist"
        return
    fi

    export SANDBOXER_BOX=$1
    export SANDBOXER_OLD_PATH=$PATH
    export SANDBOXER_REAL_CABAL_DEV=$(which cabal-dev)
    export PATH=$SANDBOXER_ROOT/$SANDBOXER_BOX/sandboxer:$PATH
}

_deactivate() {
    if [ -z "$SANDBOXER_BOX" ]; then
        echo "Not currently in a sandbox."
        return
    fi

    echo "Deactivating sandbox $SANDBOXER_BOX."

    export PATH=$SANDBOXER_OLD_PATH
    unset SANDBOXER_REAL_CABAL_DEV
    unset SANDBOXER_BOX
}

function sandboxer() {
    case $1 in
        init)
            echo "Making sandbox $2"
            local sandbox=$HOME/.sandboxer/$2
            mkdir -p $sandbox/sandboxer
            _activate $2
            local target=$sandbox/sandboxer/cabal-dev
            cat > $target <<EOF
#!/bin/bash
\$SANDBOXER_REAL_CABAL_DEV \$* --sandbox=$sandbox
EOF
            chmod 0755 $target;
            hash -r
            ;;
        activate)
            _activate $2
            ;;
        deactivate)
            _deactivate $2
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


