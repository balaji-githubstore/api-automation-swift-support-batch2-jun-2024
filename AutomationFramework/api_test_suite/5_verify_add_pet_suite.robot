*** Settings ***
Documentation       This suite file contains all testcase related to valid pet search
...  connected to required R01 and testcase TC_01

Resource    ../resource/base/CommonFunctionality.resource
Library     DataDriver  file=../test_data/petstore_data.xlsx    sheet_name=Verify Add Pet Template
Library    OperatingSystem

Suite Setup     Create Session With Bearer Token
Suite Teardown      Delete All Sessions

Test Template   Verify Add Pet Template


*** Test Cases ***
Verify Add Pet Test_${test_name}

*** Keywords ***
Verify Add Pet Template
    [Arguments]     ${pet_json}     ${expected_pet_id}
    &{header}   Create Dictionary   Content-Type=application/json       Connection=keep-alive
    ${response}     POST On Session     alias=petstore      url=/pet    headers=${header}    data=${pet_json}
    ...     expected_status=200
    Should Be Equal As Integers    ${response.json()}[id]    ${expected_pet_id}


