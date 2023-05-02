# the expected swiftlint version
EXPECTED_SWIFTLINT_VERSION="0.38.2"

# compares two version strings 
vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

# determine the swiftlint command location
SWIFTLINT_COMMAND=""
if type swiftlint >/dev/null; then
    SWIFTLINT_COMMAND="swiftlint"
elif [ -x /opt/homebrew/bin/swiftlint ]; then
    SWIFTLINT_COMMAND="/opt/homebrew/bin/swiftlint"
elif [ -x /usr/local/bin/swiftlint ]; then
    SWIFTLINT_COMMAND="/usr/local/bin/swiftlint"
else
    echo "warning: SwiftLint does not exist, download from https://github.com/realm/SwiftLint"
    exit 0
fi

# get the installed swiftlint version
SWIFTLINT_VERSION=`$SWIFTLINT_COMMAND version`

# compare the installed swiftlint version to the expected version
vercomp $SWIFTLINT_VERSION $EXPECTED_SWIFTLINT_VERSION
case $? in
    0) 
		echo "Using the expected swiftlint version: $SWIFTLINT_VERSION"
		;;
    1)
		echo "Using a newer than expected swiftlint version: $SWIFTLINT_VERSION"
		;;
    2)
		echo "Using an older than expected swiftlint version: $SWIFTLINT_VERSION, expected: $EXPECTED_SWIFTLINT_VERSION"
		exit 1
		;;
esac

# execute swiftlint
$SWIFTLINT_COMMAND --strict
