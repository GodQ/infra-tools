
if [ -z "$SOURCE_GIT_URL" ]; then
    echo "environment variable SOURCE_GIT_URL should not be empty"
    exit 1
fi

git_dir="/tmp/git_src"
echo "Git clone $SOURCE_GIT_URL to folder $git_dir"
git clone $SOURCE_GIT_URL $git_dir
if [ -z "$?" ]; then
    echo "Failed to git clone"
    exit 1
fi

jmeter_dir=$git_dir/$PROJECT_DIR
lib_dir=$git_dir/$LIB_EXT_DIR

if [ ! "$(ls -A $jmeter_dir)" ]; then
        echo "The jmeter dir should not be empty"
        exit 1
fi
cp -rf $jmeter_dir project

if [ -d "$lib_dir" ]; then
    if [ "$(ls -A $lib_dir)" ]; then
        echo "copy customized lib ext jar files to jmeter lib ext dir"
        cp -rf $lib_dir/* lib/ext
    fi
fi

if [ "$ROLE" == "worker" ]; then
    bin/jmeter-server -Jserver.rmi.ssl.disable=true -Jserver.rmi.localport=1099 -Dserver_port=1099  
else
    ./agent $AGENT_PORT
fi