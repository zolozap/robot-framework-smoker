*** Settings ***
Documentation     Grow Content Suite
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Set Global Timeout    20s 

*** Variables ***
${BROWSER}        Chrome
${DASHBOARD_URL}  ${EMPTY}
${USERNAME}       ${EMPTY}
${PASSWORD}       ${EMPTY}
${HEADLESS_OPTION}   --headless
# ${ScreenshotDirectory}    ${CURDIR}/screenshot
# ${FailureScreenshotDirectory}    ${CURDIR}/failure_screenshot

*** Test Cases ***
Setup Environment Variables
    ${DASHBOARD_URL}       Get Variable Value    ${DASHBOARD_URL}
    ${USERNAME}  Get Variable Value    ${USERNAME}
    ${PASSWORD}  Get Variable Value    ${PASSWORD}
    
Login to Dashboard
    Open Browser    ${DASHBOARD_URL}    ${BROWSER}    ${HEADLESS_OPTION}
    Wait Until Element Is Visible  name=username_or_email
    Input Text    name=username_or_email    ${USERNAME}
    Wait Until Element Is Visible  name=password
    Input Password    name=password    ${PASSWORD}
    Wait Until Element Is Visible  id=btn-login
    Click Button    id=btn-login
    Wait Until Page Contains Element    id=content    
    
Go to ConicleX Menu
    Wait Until Page Contains Element    id=left-menu    
    Click Element    xpath=//*[@id="left-menu"]/ul/li[9]/ul/li[2]
    Wait Until Page Contains Element     xpath=//a[@href="/dashboard/coniclex/course"]    
    Click Element    xpath=//a[@href="/dashboard/coniclex/course"]
    Wait Until Page Contains Element    xpath=//h2[@data-qa="txt-title" and contains(@class, "m-0 m-b-10")]    

View and Select first Course Content in ContentList
    Wait Until Page Contains Element    xpath=//*[@data-qa="r1-txt-name"]    
    Click Element    xpath=//*[@data-qa="r1-txt-name"]
    Wait Until Page Contains Element    xpath=//*[@id="coniclex-course-overall"]/div[1]/ul/li[2]/div/span/a/div/div[1]/div/div    

Go to Tab Management
    Wait Until Element Is Visible    xpath=//*[@id="coniclex-course-overall-index"]    
    Click Element    xpath=//*[@data-qa="txt-tab-management"]
    # Capture Page Screenshot    ${ScreenshotDirectory}/course_coniclex_management_dashboard.png
    Close Browser

*** Keywords ***
Set Global Timeout
    [Arguments]    ${timeout}
    Set Selenium Implicit Wait    ${timeout}

# Capture Failure Screenshot
#     [Arguments]    ${test_name}
#     Run Keyword If Test Failed    Capture Screenshot    ${FailureScreenshotDirectory}/${test_name}.png

# Test Teardown
#     [Documentation]    Capture a failure screenshot if the test case fails
#     Capture Failure Screenshot    ${TEST NAME}