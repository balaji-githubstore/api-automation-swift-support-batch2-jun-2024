*** Settings ***
Documentation       This suite file contains all testcase related to valid pet search
...  connected to required R01 and testcase TC_01

Resource    ../resource/base/CommonFunctionality.resource
Library     DataDriver  file=../test_data/find_pet_by_id.csv

Suite Setup     Create Session With Bearer Token
Suite Teardown      Delete All Sessions

Test Template   Verify Valid Pet By ID Template


*** Test Cases ***
Verify Valid Pet ID_${test_name}

*** Keywords ***
Verify Valid Pet By ID Template
    [Arguments]     ${pet_id}   ${pet_name}
    ${response}      GET On Session     alias=petstore      url=/pet/${pet_id}     expected_status=200
    Should Be Equal As Integers    ${response.json()}[id]    ${pet_id}
    Should Be Equal As Strings    ${response.json()}[name]    ${pet_name}

