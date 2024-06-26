*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
Launch Browser And Navigate To Facebook
    [Arguments]     ${browser_name}
    Open Browser    browser=${browser_name}
    Maximize Browser Window
    Set Selenium Implicit Wait    20s
    Go To    url=https://www.facebook.com/

*** Test Cases ***
TC1
    Launch Browser And Navigate To Facebook     chrome
    Click Element    xpath=(//span[text()='Allow all cookies'])[2]
    Input Text    id:email    hello12323333@gmail.com
    Input Password    id:pass    welcom123
    #click on login. check and add locator
    Click Element    name:login
    Close Browser

TC2 FB SignUp
    Launch Browser And Navigate To Facebook     edge
    Click Element    xpath=(//span[text()='Allow all cookies'])[2]
    Click Element    link:Create new account
    Input Text    name=firstname    john
    Input Text    name=lastname    wick
    #//label[text()='Custom']
    Click Element    xpath=//input[@value='-1']
    #20 Apr 2000
    Select From List By Label    id=day     20
    Select From List By Label    id=month   Apr
    Select From List By Label    id=year    2000
    #click on signup
    Click Element    name=websubmit
    Close Browser