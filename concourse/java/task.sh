#!/bin/sh
# we don't to anything with the artifact yet - we just want to build it.
set -ueo pipefail

export GREEN='\033[1;32m'
export NC='\033[0m'
export CHECK="√"
export M2_LOCAL_REPO=".m2"
export GRAPHITE_HOST="${hosted_graphite_host}"
export HOSTEDGRAPHITE_APIKEY="${hosted_graphite_apikey}"
export LOGZ_IO_TOKEN="${logz_io_token}"

mvn -f source/pom.xml install 
echo -e "${GREEN}${CHECK} Maven install${NC}"
