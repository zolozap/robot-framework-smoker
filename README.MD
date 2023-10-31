
# Robot Framework

Just A Robot smoke tester for conicle



## Installation

Install robot-project with pip

```bash
  pip install -r requirement.txt
```
    
## How to run

Run bot with specific file

```bash
robot your_test_file.robot
```

Or, if you want to run all test files in a directory:

```bash
robot /path/to/your/test/directory
```
## Cheat Sheet

```javascript
*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Resource          Common.robot
Variables         Variables.robot
Test Setup        Open Browser  ${URL}  ${BROWSER}
Test Teardown     Close Browser

*** Variables ***
${URL}            https://example.com
${BROWSER}        Chrome

*** Test Cases ***
Login Test
    [Documentation]  This is a sample test case
    Open Login Page
    Input Username    myuser
    Input Password    mypass
    Submit Login
    Verify Login Success

*** Keywords ***
Open Login Page
    Go To            /login
    Wait Until Page Contains    Login Form

Input Username
    [Arguments]      ${username}
    Input Text    id=username    ${username}

Input Password
    [Arguments]      ${password}
    Input Text    id=password    ${password}

Submit Login
    Click Button    id=login-btn

Verify Login Success
    Wait Until Page Contains    Welcome, User

}
```

Key Syntax Elements:
```javascript
*** Settings ***: Section for importing libraries, resources, and defining settings.
*** Variables ***: Section for defining global variables.
*** Test Cases ***: Section for writing test cases.
*** Keywords ***: Section for defining custom keywords.
[Documentation]: Metadata for describing the purpose of test cases and keywords.
[Arguments]: Specify arguments for custom keywords.
```

SeleniumLibrary Keywords:
```javascript
Open Browser: Open a web browser.
Go To: Navigate to a URL.
Input Text: Enter text into a text field.
Click Button: Click a button.
Wait Until Page Contains: Wait for a specific element to appear.
Close Browser: Close the browser.
```

Comments:
```javascript
#: Single-line comments.
# Comment: Single-line comment in a keyword or test case.
```
## Authors

- [@NutTheZolozap](https://www.github.com/zolozap)

