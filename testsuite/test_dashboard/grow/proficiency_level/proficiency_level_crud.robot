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

View and Create Proficiency Level
    Wait Until Page Contains Element    xpath=//*[@data-qa="btn-add-proficiency-level"]
    Click Element    xpath=//*[@data-qa="btn-add-proficiency-level"]
    Wait Until Page Contains Element    xpath=//*[@data-qa="txt-field-proficiency-level"]
    Generate and Input Random Proficiency Level
    Wait Until Page Contains Element    xpath=//*[@data-qa="btn-confirm"]
    Click Element    xpath=//*[@data-qa="btn-confirm"]
    Wait Until Page Contains Element    xpath=//*[@data-qa="panel-1"]

Update Proficiency Level
    Wait Until Element Is Visible    xpath=//*[@data-qa="ico-edit"]
    Click Element    xpath=(//*[@data-qa="ico-edit"])[1]
    Generate and Input Random Edit Proficiency Level
    Wait Until Page Contains Element    xpath=//*[@data-qa="btn-confirm"]
    Click Element    xpath=//*[@data-qa="btn-confirm"]

Delete Proficiency Level
    Wait Until Element Is Visible    xpath=//*[@data-qa="ico-delete"]
    Click Element    xpath=(//*[@data-qa="ico-delete"])[1]
    Wait Until Page Contains Element    class=el-button--primary.btn-confirm
    Click Element    class=el-button--primary.btn-confirm

Delete Proficiency Type
    Click Element    xpath=//*[@data-qa="breadcrumb-1"]
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

Generate and Input Random Proficiency Level
    ${RANDOM_NAME_TEXT} =    Generate Random Text    100
    ${RANDOM_DESC_TEXT} =    Generate Random Text    2000
    Input Text    xpath://input[@data-qa="txt-field-proficiency-level"]    RF_${RANDOM_NAME_TEXT}
    Input Text    xpath://textarea[@data-qa="txt-field-description"]    ${RANDOM_DESC_TEXT}

Generate and Input Random Edit Proficiency Level
    ${RANDOM_NAME_TEXT} =    Generate Random Text    10
    ${RANDOM_DESC_TEXT} =    Generate Random Text    1000
    Input Text    xpath://input[@data-qa="txt-field-proficiency-level"]    RF_${RANDOM_NAME_TEXT}
    Input Text    xpath://textarea[@data-qa="txt-field-description"]    edited_${RANDOM_DESC_TEXT}_edited