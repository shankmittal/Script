
# Use rsync to copy stuff from other server
# $1 - server:<path>
# $2 - local path

PORT=2222

function portClean()
{
    kill -9 $(lsof -t -i:"$PORT") 2> /dev/null
}

function serverSetup()
{
    portClean
    ssh -N -f -L "$PORT":localhost:22 "$1"
}

function serverExit()
{
    portClean
}

function copy()
{
    IFS=':' read -r server rpath <<< "$1"
    if [ -z $rpath ]; then
        echo "Trying to copy local path..Exiting"
        exit 1
    fi

    serverSetup "$server"

    /Users/shankmittal/homebrew/bin/rsync -avz -e "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p $PORT" "localhost:$rpath" "$2"

    serverExit
}

copy $1 $2
