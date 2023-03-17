
findexpr() { 
    #
    # find the given expression in the glob/file
    #

    if [[ $# -ne 2 ]]; then
        echo "Usage:  findexpr <expr> <glob/filename>"
        return
    fi

    find . -iname "$2" -type f -print0 | xargs -0 grep -Hine "$1"; 
}

cdN() {
    #
    # cd up N directories
    #

    if [[ $# -eq 0 ]]; then
        local COUNT=1
    else
        local COUNT=$1
    fi

    local TARGET_DIR=""
    while [[ $COUNT -gt 0 ]]; do
        TARGET_DIR+="../"
        COUNT=$((COUNT-1))
    done

    cd $TARGET_DIR
}

cdbr() {
    #
    # cd to the "build root"
    #

    local CMAKEROOT="./"

    while [ ! -f "$CMAKEROOT/CMakeCache.txt" ] && [ ! -f "$CMAKEROOT/build.ninja" ]; do
        if [ -d "$CMAKEROOT/.git" ]; then
            echo Found .git folder, selecting sibling debug folder
            CMAKEROOT+="../debug"
            continue
        fi

        CMAKEROOT+="../"

        if [ "$(readlink -f "$CMAKEROOT")" == "/" ]; then
            echo Unable to find CMakeCache.txt or build.ninja file
            return
        fi
    done

    cd "$CMAKEROOT"

    if [ $# == 1 ]; then
        cd $1
    fi
}

cdpr() {
    #
    # cd to the project root (top level of a git repo)
    #

    local GITTOPLEVEL
    GITTOPLEVEL=$(git rev-parse --show-toplevel 2> /dev/null)

    if [ $? -eq 0 ]; then
        cd "$GITTOPLEVEL"
    else
        echo "This doesn't appear to be a git folder..."
    fi

    if [ $# == 1 ]; then
        cd $1
    fi
}

mkcd() {
    mkdir $1
    cd $1
}

