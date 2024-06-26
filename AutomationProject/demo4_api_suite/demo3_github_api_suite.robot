*** Settings ***
Library     RequestsLibrary

Suite Setup     Create Session    alias=gitapi    url=https://api.github.com
Suite Teardown  Delete All Sessions
Resource    demo5_github_oauth.robot

*** Keywords ***
Create Git Session With Auth
    @{cred}      Create List       balaji-githubstore    fdgfgdfgfdgfd
    Create Session    alias=gitbasicauth    url=https://api.github.com      auth=${cred}

*** Test Cases ***
TC1 List User Repo Bearer Token
    ${headers}      Create Dictionary       Authorization=Bearer fdgfgdfgfdgfd
    ${respone}      GET On Session  alias=gitapi    url=/user/repos     headers=${headers}
    Log    ${respone.json()}

TC2 List User Repo Basic Auth Not Working
    ${cred}      Create List       balaji-githubstore    fdgfgdfgfdgfd
    ${respone}      GET On Session  alias=gitapi    url=/user/repos     auth=${cred}
    Log    ${respone.json()}

#set basic auth while creating the session
TC3 List User Repo Basic Auth
    @{cred}      Create List       balaji-githubstore    fdgfgdfgfdgfd
    Create Session    alias=gitbasicauth    url=https://api.github.com      auth=${cred}
    ${respone}      GET On Session  alias=gitbasicauth    url=/user/repos
    Log    ${respone.json()}

TC4 List User Repo Basic Auth
    Create Git Session With Auth
    ${respone}      GET On Session  alias=gitbasicauth    url=/user/repos
    Log    ${respone.json()}


TC5 List User Repo Outh
    ${access_token}     Get Access Token
    ${headers}      Create Dictionary       Authorization=Bearer ${access_token}
    ${respone}      GET On Session  alias=gitapi    url=/user/repos     headers=${headers}
    Log    ${respone.json()}