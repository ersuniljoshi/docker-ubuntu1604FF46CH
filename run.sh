#!/bin/bash
# Entry script to start Xvfb and set display
set -e

# Set the defaults
DEFAULT_LOG_LEVEL="INFO" # Available levels: TRACE, DEBUG, INFO (default), WARN, NONE (no logging)
# DEFAULT_RES="1280x1024x24"
DEFAULT_RES="1028x768x24"
DEFAULT_DISPLAY=":99"
DEFAULT_ROBOT_TESTS="false"
DEFAULT_BROWSER="firefox"

# Use default if none specified as env var
LOG_LEVEL=${LOG_LEVEL:-$DEFAULT_LOG_LEVEL}
RES=${RES:-$DEFAULT_RES}
DISPLAY=${DISPLAY:-$DEFAULT_DISPLAY}
ROBOT_TESTS=${ROBOT_TESTS:-$ROBOT_TESTS}
BROWSER=${BROWSER:-$DEFAULT_BROWSER}

if [[ "${ROBOT_TESTS}" == "false" ]]; then
  echo "Error: Please specify the robot test or directory as env var ROBOT_TESTS"
  exit 1
fi

# Start Xvfb
echo -e "Starting Xvfb on display ${DISPLAY} with res ${RES}"
Xvfb ${DISPLAY} -ac -screen 0 ${RES} +extension RANDR &
export DISPLAY=${DISPLAY}

# Execute tests
echo -e "Executing robot tests at log level ${LOG_LEVEL}"

# System Information
google-chrome --version
firefox --version

#pybot --loglevel ${LOG_LEVEL} -v BROWSER:${BROWSER} ${ROBOT_TESTS} 
#pybot --loglevel ${LOG_LEVEL} -v BROWSER:${BROWSER} ${ROBOT_TESTS}/Tests --report ${ROBOT_TESTS}/results
robot --loglevel ${LOG_LEVEL} -v BROWSER:${BROWSER} -d ${ROBOT_TESTS}/Results ${ROBOT_TESTS}/Tests 

# Stop Xvfb
kill -9 $(pgrep Xvfb)
