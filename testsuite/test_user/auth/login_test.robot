*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Set Global Timeout    10s 

*** Variables ***
${BROWSER}        Chrome
${URL}            ${EMPTY}
${USERNAME}       ${EMPTY}
${PASSWORD}       ${EMPTY}
${HEADLESS_OPTION}   --headless
# ${ScreenshotDirectory}    ${CURDIR}/screenshot

*** Test Cases ***
Setup Environment Variables
    ${URL}       Get Variable Value    ${URL}
    ${USERNAME}  Get Variable Value    ${USERNAME}
    ${PASSWORD}  Get Variable Value    ${PASSWORD}

Login to Website
    Open Browser  ${URL}  ${BROWSER}    ${HEADLESS_OPTION}
    Wait Until Element Is Visible  name=username_or_email
    Input Text    name=username_or_email    ${USERNAME}
    Wait Until Element Is Visible  name=password
    Input Text    name=password    ${PASSWORD}
    Wait Until Element Is Visible  id=btn-login
    Click Button  id=btn-login
    Wait Until Page Contains Element  id=content
    # Capture Page Screenshot  ${ScreenshotDirectory}/login_page.png
    Close Browser

*** Keywords ***
Set Global Timeout
    [Arguments]    ${timeout}
    Set Selenium Implicit Wait    ${timeout}
