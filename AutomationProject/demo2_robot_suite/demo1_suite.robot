*** Settings ***

Library     DateTime
Library    String

*** Variables ***
${BROWSER_NAME}     chrome
@{COLORS}       red     green     yellow
&{MY_DETAIL}    name=balaji     role=trainer    mobile=383893

*** Test Cases ***
TC6
    Log To Console    ${BROWSER_NAME}
    Log To Console    ${COLORS}
    Log To Console    ${MY_DETAIL}

    Log To Console    ${COLORS}[1]
    Log To Console    ${MY_DETAIL}[mobile]
    
    ${len}  Get Length    ${COLORS}
    Log To Console    ${len}

TC7
    ${len}      Get Length    ${COLORS}
    FOR    ${i}    IN RANGE    0    ${len}
        Log To Console    ${COLORS}[${i}]
    END

TC8
    FOR    ${color}    IN    @{COLORS}
        Log To Console    ${color}

    END

TC1
    Log To Console      Balaji Dinakaran
    Log To Console    Welcome to robot framework
    Log To Console    message=hello, everyone

TC2
    Log To Console    Bala
    ${my_name}  Set Variable    Balaji Dinakaran
    Log To Console    ${my_name}

TC3
    ${radius}=    Set Variable    10
    #calculate area of circle and print the output
    #3.14*${radius}*${radius}
    #Log To Console    3.14*${radius}*${radius}
    ${result}   Evaluate    3.14*${radius}*${radius}
    Log To Console    ${result}
    Log    ${result}

TC4
   ${current_date}  Get Current Date
   Log To Console   ${current_date}

TC5
    ${my_name}  Set Variable    Balaji Dinakaran
    ${name}     Convert To Upper Case   ${my_name}
    Log To Console    ${name}
    
    
TC9
    Log To Console    C:\\Mine\\Company${/}Swift Support 2 Jun 2024\\AutomationProject\\test_data\\add_pet.json
    Log To Console    ${EXECDIR}
    Log To Console    ${CURDIR}
    Log To Console    ${OUTPUT_DIR}
    Log To Console    ${SUITE_NAME}
    Log To Console    ${TEST_NAME}
    Log To Console    ${TEMPDIR}
    Log To Console    ${EXECDIR}${/}test_data${/}add_pet.json