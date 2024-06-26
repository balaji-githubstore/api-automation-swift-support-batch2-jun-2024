*** Settings ***
Documentation       This suite file contains all testcase related to valid pet search
...  connected to required R01 and testcase TC_01

Resource    ../resource/base/CommonFunctionality.resource

Suite Setup     Create Session With Bearer Token
Suite Teardown      Delete All Sessions

Test Template   Verify Find By Status Template

*** Test Cases ***
Verify Find By Pending Status
    [Template]      Verify Find By Status Template
    pending

Verify Find By Available Status
    available

Verify Find By Sold Status
    sold


*** Keywords ***
Verify Find By Status Template
    [Arguments]     ${status}
    ${response}     GET On Session      alias=petstore  url=/pet/findByStatus?status=${status}    expected_status=200

    FOR    ${pet}    IN    @{response.json()}
        Should Be Equal As Strings    ${pet}[status]    ${status}
    END