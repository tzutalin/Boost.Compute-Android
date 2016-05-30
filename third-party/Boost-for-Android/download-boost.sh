#!/bin/sh

BOOST_VER1=1
BOOST_VER2=55
BOOST_VER3=0

PROGNAME=`basename $0`
PROGDIR=`pwd`

BOOST_DOWNLOAD_LINK="http://downloads.sourceforge.net/project/boost/boost/$BOOST_VER1.$BOOST_VER2.$BOOST_VER3/boost_${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost%2Ffiles%2Fboost%2F${BOOST_VER1}.${BOOST_VER2}.${BOOST_VER3}%2F&ts=1291326673&use_mirror=garr"
BOOST_TAR="boost_${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}.tar.bz2"
BOOST_DIR="boost_${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}"
BUILD_DIR="./build/"

VERBOSE="yes"

prepare_download ()
{
    find_program CMD_WGET wget
    find_program CMD_CURL curl
    find_program CMD_SCRP scp
}

pattern_match ()
{
    echo "$2" | grep -q -E -e "$1"
}

# Let's check that we have a working md5sum here
check_md5sum ()
{
    A_MD5=`echo "A" | md5sum | cut -d' ' -f1`
    if [ "$A_MD5" != "bf072e9119077b4e76437a93986787ef" ] ; then
        echo "Please install md5sum on this machine"
        exit 2
    fi
}

find_program ()
{
    local PROG
    PROG=`which $2 2>/dev/null`
    if [ -n "$PROG" ] ; then
        if pattern_match '^no ' "$PROG"; then
            PROG=
        fi
    fi
    eval $1="$PROG"
}

run ()
{
    if [ "$VERBOSE" = "yes" ] ; then
        echo "##### NEW COMMAND"
        echo "$@"
        $@ 2>&1
    else
        if [ -n "$TMPLOG" ] ; then
            echo "##### NEW COMMAND" >> $TMPLOG
            echo "$@" >> $TMPLOG
            $@ 2>&1 | tee -a $TMPLOG
        else
            $@ > /dev/null 2>&1
        fi
    fi
}

download_file ()
{
    # Is this HTTP, HTTPS or FTP ?
    if pattern_match "^(http|https|ftp):.*" "$1"; then
        if [ -n "$CMD_WGET" ] ; then
            run $CMD_WGET -O $2 $1 
        elif [ -n "$CMD_CURL" ] ; then
            run $CMD_CURL -o -L $2 $1
        else
            echo "Please install wget or curl on this machine"
            exit 1
        fi
        return
    fi

    # Is this SSH ?
    # Accept both ssh://<path> or <machine>:<path>
    #
    if pattern_match "^(ssh|[^:]+):.*" "$1"; then
        if [ -n "$CMD_SCP" ] ; then
            scp_src=`echo $1 | sed -e s%ssh://%%g`
            run $CMD_SCP $scp_src $2
        else
            echo "Please install scp on this machine"
            exit 1
        fi
        return
    fi

    # Is this a file copy ?
    # Accept both file://<path> or /<path>
    #
    if pattern_match "^(file://|/).*" "$1"; then
        cp_src=`echo $1 | sed -e s%^file://%%g`
        run cp -f $cp_src $2
        return
    fi
}

prepare_download
echo "Download boost version: $BOOST_VER1.$BOOST_VER2.$BOOST_VER3"
download_file $BOOST_DOWNLOAD_LINK $PROGDIR/$BOOST_TAR
echo "extracing: $BOOST_TAR"
tar -xvf $BOOST_TAR
