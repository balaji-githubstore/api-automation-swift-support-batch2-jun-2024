*** Settings ***
Documentation   This resource file contains all reusable keywords and configurations details

Library     RequestsLibrary
Library     SeleniumLibrary
Library    String

*** Variables ***
${AUTH_URL}     https://petstore.com/login/oauth/authorize
${TOKEN_URL}    https://petstore.com/login/oauth/access_token
${CLIENT_ID}    Ov23lizmv6HkDFDexGoi
${CLIENT_SCERET}    554e0f7c3555c717e69c667c3caaf00072e412db
${CALLBACK_URL}     https://oauth.pstmn.io/v1/browser-callback
${SCOPE}      repo
${AUTH_CODE}    ${EMPTY}

*** Keywords ***
Create Session With Basic Auth
    @{cred}      Create List       balaji-petstorehubstore    fdgfgdfgfdgfd
    Create Session    alias=petstorebasicauth    url=https://petstore.swagger.io/v2        auth=${cred}

Create Session With Outh Auth
    ${access_token}     Get Access Token

Get Access Token
    &{params}   Create Dictionary   client_id=${CLIENT_ID}      scope=${SCOPE}      redirect_uri=${CALLBACK_URL}

    Create Session    alias=petstore_token    url=${AUTH_URL}
    ${respone}      GET On Session  alias=petstore_token     url=${AUTH_URL}     params=${params}
    Log    ${respone.url}

    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Go To    url=${respone.url}
    Input Text    id=login_field    balaji-petstorehubstore
#    Input Password    id=password    xxxxxx
    Sleep    10s
    Click Element    name=commit
    Sleep    10s
    ${current_url}      Get Location
    Log    ${current_url}

    ${AUTH_CODE}    Remove String   ${current_url}  https://oauth.pstmn.io/v1/browser-callback?code=
    Log    ${AUTH_CODE}
    Close Browser

    #get access token using auth code
    &{payload}   Create Dictionary   client_id=${CLIENT_ID}      client_secret=${CLIENT_SCERET}
    ...     scope=${SCOPE}      redirect_uri=${CALLBACK_URL}    code=${AUTH_CODE}

    ${headers}      Create Dictionary   Accept=application/json
    ${response}  POST On Session   alias=petstore_token   url=${TOKEN_URL}    data=${payload}     headers=${headers}

    Return From Keyword    ${response.json()}[access_token]


Create Session With Bearer Token
    ${headers}      Create Dictionary       Authorization=Bearer xxxx
    Create Session    alias=petstore    url=https://petstore.swagger.io/v2     headers=${headers}
