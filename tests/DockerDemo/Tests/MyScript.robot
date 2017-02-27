*** Settings ***
Library  Selenium2Library
*** Variables ***
${BROWSER}  firefox
#${REMOTE_URL}  http://172.16.20.17:4446/wd/hub
#${DESIRED_CAPABILITIES}  platform:LINUX,browser:firefox,version:45.0
#${SERVER}  http://google.com
*** Test Cases ***
Test_01
    open browser  http://www.google.com  ${BROWSER}
    #open browser  ${SERVER}  ${BROWSER}  ${DESIRED_CAPABILITIES}  ${REMOTE_URL}
    click element  id=lst-ib
    log to console  opening browser ${BROWSER}
    input text  id=lst-ib  infobeans
    close browser
Test_02
    open browser  http://www.google.com  ${BROWSER}
    #open browser  ${SERVER}  ${BROWSER}  ${DESIRED_CAPABILITIES}  ${REMOTE_URL}
    click element  id=lst-ibb
    log to console  opening browser ${BROWSER}
    input text  id=lst-ib  infobeans
    close browser
Test_03
    open browser  http://www.google.com  ${BROWSER}
    #open browser  ${SERVER}  ${BROWSER}  ${DESIRED_CAPABILITIES}  ${REMOTE_URL}
    click element  id=lst-ib
    log to console  opening browser ${BROWSER}
    input text  id=lst-ib  infobeans
    close browser