*** Settings ***
Library     RequestsLibrary
Library    SeleniumLibrary
Library    String

*** Variables ***
${AUTH_URL}     https://github.com/login/oauth/authorize
${TOKEN_URL}    https://github.com/login/oauth/access_token
${CLIENT_ID}    Ov23lizmv6HkDFDexGoi
${CLIENT_SCERET}    554e0f7c3555c717e69c667c3caaf00072e412db
${CALLBACK_URL}     https://oauth.pstmn.io/v1/browser-callback
${SCOPE}      repo
${AUTH_CODE}    ${EMPTY}

*** Test Cases ***
Get Access Token
    &{params}   Create Dictionary   client_id=${CLIENT_ID}      scope=${SCOPE}      redirect_uri=${CALLBACK_URL}

    Create Session    alias=git_token    url=${AUTH_URL}
    ${respone}      GET On Session  alias=git_token     url=${AUTH_URL}     params=${params}
    Log    ${respone.url}

    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Go To    url=${respone.url}
    Input Text    id=login_field    balaji-githubstore
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
    ${response}  POST On Session   alias=git_token   url=${TOKEN_URL}    data=${payload}     headers=${headers}
    Log    ${response.json()}
    Log    ${response.json()}[access_token]

