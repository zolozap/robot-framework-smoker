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
    
Go to Competency Group Menu
    Wait Until Page Contains Element    id=left-menu    
    Mouse Over    xpath=//*[@id="left-menu"]/ul/li[4]/ul/li[1]/div/div/a
    Wait Until Element Is Visible    xpath=//*[@data-qa="txt-menu-competency-library-competency-group"]    10s
    Click Element    xpath=//*[@data-qa="txt-menu-competency-library-competency-group"]
    Wait Until Page Contains Element     xpath=//*[@id="competency-group-index-page"]/div[1]/h2

Create New Competency Group
    Wait Until Page Contains Element    xpath=//*[@data-qa="btn-group-create-competency-group"]
    Click Element    xpath=//*[@data-qa="btn-group-create-competency-group"]
    Wait Until Page Contains Element    xpath=//*[@data-qa="btn-create-new"]
    Click Element    xpath=//*[@data-qa="btn-create-new"]
    Wait Until Page Contains Element    xpath://input[@data-qa="txt-field-name"]
    Generate Input Random Text Group
    Click Element    xpath=//*[@data-qa="btn-save-next"]

Create New Competency SubGroup
    Wait Until Element Is Visible    xpath=//*[@data-qa="btn-add-subgroup"]
    Click Element    xpath=//*[@data-qa="btn-add-subgroup"]
    Wait Until Element Is Visible    xpath=//*[@data-qa="txt-field-subgroup-name"]
    Generate Input Random Text SubGroup
    Click Element    xpath=//*[@data-qa="btn-confirm"]

Update Competency SubGroup
    Wait Until Element Is Visible    xpath=(//*[@data-qa="ico-edit"])[2]
    Click Element    xpath=(//*[@data-qa="ico-edit"])[2]
    Wait Until Element Is Visible    xpath=//*[@data-qa="form-dialog"]
    Wait Until Element Is Visible    xpath=//*[@data-qa="txt-field-subgroup-name"]
    Generate Input Random Text SubGroup
    Click Element    xpath=//*[@data-qa="btn-confirm"]

Delete Competency SubGroup
    Wait Until Element Is Visible    xpath=//*[@data-qa="ico-delete"]
    Click Element    xpath=(//*[@data-qa="ico-delete"])[1]
    Wait Until Element Is Visible    xpath=//button[contains(., 'Confirm')]    10s
    Click Element    xpath=//button[contains(., 'Confirm')]

Update Competency Group
    Click Element    xpath=//*[@data-qa="breadcrumb-1"]
    Wait Until Page Contains Element    xpath=//*[@id="competency-group-index-page"]
    Wait Until Page Contains Element    xpath=//*[@data-qa="r1-txt-name"]
    Click Element    xpath=//*[@data-qa="r1-txt-name"]
    Wait Until Element Is Visible    xpath=//*[@data-qa="ico-edit"]
    Click Element    xpath=(//*[@data-qa="ico-edit"])[1]
    Wait Until Page Contains Element    xpath://input[@data-qa="txt-field-name"]
    Generate Input Random Text Group
    Click Element    xpath=//button[contains(., 'Confirm')]

Delete Competency Group
    Click Element    xpath=//*[@data-qa="breadcrumb-1"]
    Wait Until Element Is Visible    xpath=//*[@data-qa="ico-delete"]
    Click Element    xpath=(//*[@data-qa="ico-delete"])[1]
    Wait Until Element Is Visible    xpath=//button[contains(., 'Confirm')]    10s
    Click Element    xpath=//button[contains(., 'Confirm')]
    Close Browser

*** Keywords ***
Set Global Timeout
    [Arguments]    ${timeout}
    Set Selenium Implicit Wait    ${timeout}

Generate Input Random Text Group
    ${RANDOM_NAME_TEXT} =    Generate Random Text    100
    ${RANDOM_CODE_TEXT} =    Generate Random Text    10
    ${RANDOM_DESC_TEXT} =    Generate Random Text    2000
    Input Text    xpath://input[@data-qa="txt-field-name"]    RF_${RANDOM_NAME_TEXT}
    Input Text    xpath://input[@data-qa="txt-field-id"]    RF${RANDOM_CODE_TEXT}
    Input Text    xpath://textarea[@data-qa="txt-field-description"]    ${RANDOM_DESC_TEXT}

Generate Input Random Text SubGroup
    ${RANDOM_NAME_TEXT} =    Generate Random Text    10
    ${RANDOM_CODE_TEXT} =    Generate Random Text    5
    ${RANDOM_DESC_TEXT} =    Generate Random Text    1000
    Input Text    xpath://input[@data-qa="txt-field-subgroup-name"]    RF_${RANDOM_NAME_TEXT}
    Input Text    xpath://input[@data-qa="txt-field-subgroup-id"]    RF${RANDOM_CODE_TEXT}
    Input Text    xpath://textarea[@data-qa="txt-field-description"]    edited_${RANDOM_DESC_TEXT}_edited