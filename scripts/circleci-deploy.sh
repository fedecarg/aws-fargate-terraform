#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
SEMVER="patch"

#===============================================================================
# Display usage information
#===============================================================================

usage()
{
    echo "USAGE"
    echo "    circleci-deploy.sh [OPTIONS]"
    echo ""
    echo "OPTIONS"
    echo "    --version      <str>  Semantic Versioning: patch (default), minor, major"
    echo "    --help | -h           Usage information"
    echo ""
    echo "EXAMPLE"
    echo "    $ sh aws/circleci-deploy.sh --verison minor"
    echo ""
}

#===============================================================================
# Parse command line options
#===============================================================================

while [ "$1" != "" ]; do
    case $1 in
        --version)   shift; SEMVER=$1;;
        --help)      usage; exit;;
        * )          usage; exit 1
    esac
    shift
done

cd "${SCRIPT_DIR}/../"

TAG_VERSION=$(npm version $SEMVER)
[ $? -ne 0 ] && exit 1

git push origin $TAG_VERSION

echo "Deploying tag ${TAG_VERSION} ..."
echo "https://circleci.com/gh/fedecarg/workflows/example-app\n"
