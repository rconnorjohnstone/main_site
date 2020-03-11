#!/bin/sh

set -e

stack build
stack build yesod-bin
stack exec -- yesod devel
