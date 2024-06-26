*** Settings ***
Library     SeleniumLibrary


*** Test Cases ***
TC1 Alert
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Go To    url=https://netbanking.hdfcbank.com/netbanking/IpinResetUsingOTP.htm
    #click on go
    Click Element    xpath=//img[@alt='Go']
    ${actual_alert_text}    Handle Alert    action=ACCEPT   timeout=30s
    Log To Console    ${actual_alert_text}
    Should Be Equal As Strings    ${actual_alert_text}    Customer ID${SPACE}${SPACE}cannot be left blank.


TC2 Upload pdf
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Go To    url=https://www.ilovepdf.com/jpg_to_pdf
    Choose File    xpath=//input[@type='file']    file_path=${EXECDIR}${/}test_data${/}demo.jpg

TC3 JS
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Go To    url=https://www.citibank.co.in/ssjsps/forgetuseridmidssi.jsp

    Click Element    link=select your product type
    Click Element    link=Credit Card

    Input Text    id=citiCard1    2333
    Input Text    css=#citiCard2    4443
    Input Text    css=input[name='citiCard3']    5454

    #approach 1 - not working
#    Input Text    id=bill-date-long    14/09/2000

    #approach 2 - automate calendar
    #click calendar
    #select year
    #select month
    #Click Element link=14

    #approach 3
    Execute Javascript      document.querySelector('#bill-date-long').value='14/09/2000'
    Sleep    5s


TC4 JS
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Go To    url=https://www.citibank.co.in/ssjsps/forgetuseridmidssi.jsp

    Click Element    link=select your product type
    Click Element    link=Credit Card

    Input Text    id=citiCard1    2333
    Input Text    css=#citiCard2    4443
    Input Text    css=input[name='citiCard3']    5454

    #approach 1 - not working
#    Input Text    id=bill-date-long    14/09/2000

    #approach 2 - automate calendar
    #click calendar
    #select year
    #select month
    #Click Element link=14

    #approach 3
#    Execute Javascript      document.querySelector('#bill-date-long').value='14/09/2000'
#    Sleep    5s

     #approach 4
    ${ele}     Get WebElement    xpath=//input[@id='bill-date-long']
    Execute Javascript     arguments[0].value='14/09/2000'      ARGUMENTS       ${ele}
    Sleep    5s