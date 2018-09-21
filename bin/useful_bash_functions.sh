
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

bd() {
    #
    # "back directory", cd up N directories
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

    local MAKEROOT="./"

    while [ ! -f "$MAKEROOT/CMakeCache.txt" ] && [ ! -f "$MAKEROOT/build.ninja" ]; do
        MAKEROOT+="../"

        # If we've hit the / folder (assumed by the presence of a /root folder,
        # which I optimistically assume won't exist elsewhere, at least in a Ninja
        # build folder), then stop searching...
        if [ -d "$MAKEROOT/root" ]; then
            echo Unable to find CMakeCache.txt or build.ninja file
            return
        fi
    done

    cd "$MAKEROOT"
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
}

