#!/usr/bin/env bash
set -x
#
# Create directory for license activation
#

sudo mkdir /Library/Application\ Support/Unity
sudo chmod -R 777 /Library/Application\ Support/Unity

ACTIVATE_LICENSE_PATH="$GITHUB_WORKSPACE/_activate-license"
mkdir -p "$ACTIVATE_LICENSE_PATH"

#
# Run steps
#

source "$ACTION_FOLDER/platforms/mac/steps/activate.sh"
source "$ACTION_FOLDER/platforms/mac/steps/set_gitcredential.sh"
source "$ACTION_FOLDER/platforms/mac/steps/run_tests.sh"
source "$ACTION_FOLDER/platforms/mac/steps/return_license.sh"

#
# Remove license activation directory
#

sudo rm -r /Library/Application\ Support/Unity
rm -r "$ACTIVATE_LICENSE_PATH"

#
# Instructions for debugging
#

if [[ $TEST_RUNNER_EXIT_CODE -gt 0 ]]; then
echo ""
echo "###########################"
echo "#         Failure         #"
echo "###########################"
echo ""
echo "Please note that the exit code is not very descriptive."
echo "Most likely it will not help you solve the issue."
echo ""
echo "To find the reason for failure: please search for errors in the log above."
echo ""
fi;

#
# Exit with code from the build step.
#

if [[ $USE_EXIT_CODE == true || $TEST_RUNNER_EXIT_CODE -ne 2 ]]; then
exit $TEST_RUNNER_EXIT_CODE
fi;
