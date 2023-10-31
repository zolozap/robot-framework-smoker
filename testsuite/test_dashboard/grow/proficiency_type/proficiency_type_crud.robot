*** Settings ***
Documentation     Grow Competency Suite
Library           SeleniumLibrary
Library           OperatingSystem
Library           BuiltIn
Library           Collections
Library           ../../../../MyCustomLibrary.py

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
    
Go to Proficiency Type Menu
    Wait Until Page Contains Element    id=left-menu
    Click Element    xpath=//*[@id="left-menu"]/ul/li[4]/ul/li[2]/div/div/a

Create New Proficiency Type
    Wait Until Page Contains Element    xpath=//*[@data-qa="btn-add-proficiency-type"]
    Click Element    xpath=//*[@data-qa="btn-add-proficiency-type"]
    Wait Until Page Contains Element    xpath://input[@data-qa="txt-field-proficiency-type-name"]
    Generate and Input Random Text
    Wait Until Page Contains Element    xpath=//*[@data-qa="btn-confirm"]
    Click Element    xpath=//*[@data-qa="btn-confirm"]

View and Update Proficiency Type
    Wait Until Page Contains Element    xpath=//*[@data-qa="txt-field-proficiency-type"]
    Generate and Input Random Text Update
    Click Element    xpath=//*[@data-qa="btn-save-back"]

Delete Proficiency Type
    Wait Until Element Is Visible    xpath=//*[@data-qa="ico-delete"]
    Click Element    xpath=(//*[@data-qa="ico-delete"])[1]
    Wait Until Page Contains Element    class=el-button--primary.btn-confirm
    Click Element    class=el-button--primary.btn-confirm
    Close Browser

*** Keywords ***
Set Global Timeout
    [Arguments]    ${timeout}
    Set Selenium Implicit Wait    ${timeout}

Generate and Input Random Text
    ${RANDOM_NAME_TEXT} =    Generate Random Text    100
    Input Text    xpath://input[@data-qa="txt-field-proficiency-type-name"]    RF_${RANDOM_NAME_TEXT}

Generate and Input Random Text Update
    ${RANDOM_NAME_TEXT} =    Generate Random Text    10
    Input Text    xpath://input[@data-qa="txt-field-proficiency-type"]    RF_${RANDOM_NAME_TEXT}