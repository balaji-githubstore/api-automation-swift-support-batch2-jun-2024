*** Settings ***
Documentation       This suite file contains all testcase related to valid pet search
...  connected to required R01 and testcase TC_01

Resource    ../resource/base/CommonFunctionality.resource


Suite Setup     Create Session With Bearer Token
Suite Teardown      Delete All Sessions

Test Template   Verify Valid Pet By ID Template


*** Test Cases ***
TC1
    [Tags]  smoke
    5   doggie
TC2
    501     doggie501444
TC3
    10     Hershey

#TC5
#    [Template]  None
#    #override the test setup in settings
#    [Setup]     None
#    Log To Console    bala
#    #override the test teardown in settings
#    [Teardown]  None
#
#TC1
#    [Template]  Verify Valid Pet By ID Template
#    5   doggie




*** Keywords ***
Verify Valid Pet By ID Template
    [Arguments]     ${pet_id}   ${pet_name}
    ${response}      GET On Session     alias=petstore      url=/pet/${pet_id}     expected_status=200
    Should Be Equal As Integers    ${response.json()}[id]    ${pet_id}
    Should Be Equal As Strings    ${response.json()}[name]    ${pet_name}

