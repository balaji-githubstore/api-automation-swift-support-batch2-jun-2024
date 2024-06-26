*** Settings ***
Library     SeleniumLibrary


*** Test Cases ***
TC1
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    20s
    Go To    url=https://www.db4free.net/
    #click on phpMyAdmin »
    #//b[contains(text(),'phpMyAdmin')]
    Click Element    partial link=phpMyAdmin
    #switch to 2nd tab using title
    Switch Window   phpMyAdmin
    Input Text    id=input_username    admin
    #enter password as admin123
    #Click log in

    #check what happen with below keywords
    Close Window
    #switch to 1st tab using title
    Switch Window   db4free.net - MySQL Database for free
    Sleep    10s
    Close Browser

TC2
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    20s
    Go To    url=https://www.db4free.net/
    #click on phpMyAdmin »
    #//b[contains(text(),'phpMyAdmin')]
    Click Element    partial link=phpMyAdmin
    #switch to 2nd tab using title
    Switch Window   NEW
    Input Text    id=input_username    admin
    #enter password as admin123
    #Click log in

    #check what happen with below keywords
    Close Window
    #switch to 1st tab using title
    Switch Window   MAIN
    Sleep    10s
    Close Browser