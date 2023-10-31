*** Settings ***
Documentation     Grow Competency Suite
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Set Global Timeout    30s 

*** Variables ***
${BROWSER}        Chrome
${DASHBOARD_URL}  ${EMPTY}
${USERNAME}       ${EMPTY}
${PASSWORD}       ${EMPTY}
${HEADLESS_OPTION}   --headless

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
    
Go to Competency Type Menu
    Wait Until Page Contains Element    id=left-menu    
    Mouse Over    xpath=//*[@id="left-menu"]/ul/li[4]/ul/li[1]/div/div/a
    Wait Until Element Is Visible    xpath=//*[@data-qa="txt-menu-competency-library-competency-type"]    10s
    Click Element    xpath=//*[@data-qa="txt-menu-competency-library-competency-type"]
    Wait Until Page Contains Element     xpath=//*[@id="competency-type-index-page"]

View Competency Type in List
    Wait Until Page Contains Element    xpath=//*[@id="competency-type-index-page"]/h2
    Close Browser

*** Keywords ***
Set Global Timeout
    [Arguments]    ${timeout}
    Set Selenium Implicit Wait    ${timeout}
