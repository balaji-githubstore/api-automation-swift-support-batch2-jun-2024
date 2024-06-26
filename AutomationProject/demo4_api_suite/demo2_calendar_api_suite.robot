*** Settings ***
Library     RequestsLibrary
Library    Collections
Library    OperatingSystem

Suite Setup     Create Session    alias=calcapi    url=https://www.googleapis.com/calendar/v3
Suite Teardown      Delete All Sessions


*** Test Cases ***
TC1 Get Calendar List
    #get the list of calendar
    #print first item summary name from items
   &{headers}   Create Dictionary    Authorization=Bearer ya29.a0AXooCgsJN8VHudimW_oSEwTju1T3zPULYvfV3rJBYQHqZu_wMiBi3nDQ0ID1awf4aJ1wzpUhN07Biu_Njz_nbUsabKdvs5eO1Xq6sacWGYoudsvX_Q_7wIRR_9lcFOe-Ops2KGoAgP7ltlLcLsOMB18swhF0M4QeoyWJaCgYKAWASARMSFQHGX2MiQbDZO-66VI6CkTC7h60nPw0171

   ${response}   GET On Session  alias=calcapi   url=/users/me/calendarList    headers=${headers}
   Log    ${response.json()}
   Log    ${response.json()}[items]
   ${items_size}    Get Length    ${response.json()}[items]
   Log    ${items_size}
   Log    ${response.json()}[items][0][summary]

   #verify the calendar list contain "New Fun 2024" calendar
   ${check}     Set Variable    FALSE
   FOR    ${i}    IN RANGE    0    ${items_size}
       Log    ${response.json()}[items][${i}][summary]
       IF    '${response.json()}[items][${i}][summary]' == 'Fun 2025'
           ${check}     Set Variable       TRUE
           BREAK
       END
   END
   Should Be Equal As Strings    ${check}    TRUE      msg=False represent No calandar available with given name

TC2 Check Calendar Fun 2024
    &{headers}   Create Dictionary    Authorization=Bearer ya29.a0AXooCgsJN8VHudimW_oSEwTju1T3zPULYvfV3rJBYQHqZu_wMiBi3nDQ0ID1awf4aJ1wzpUhN07Biu_Njz_nbUsabKdvs5eO1Xq6sacWGYoudsvX_Q_7wIRR_9lcFOe-Ops2KGoAgP7ltlLcLsOMB18swhF0M4QeoyWJaCgYKAWASARMSFQHGX2MiQbDZO-66VI6CkTC7h60nPw0171

   ${response}   GET On Session  alias=calcapi   url=/users/me/calendarList    headers=${headers}

      #using Run Keyword And Return Status
   ${items_size}    Get Length    ${response.json()}[items]
   ${check}     Set Variable    False
   FOR    ${i}    IN RANGE    0    ${items_size}
#       ${output1}   Run Keyword And Ignore Error    Should Be Equal As Strings    ${response.json()}[items][${i}][summary]    Fun 2025
       ${output2}   Run Keyword And Return Status    Should Be Equal As Strings    ${response.json()}[items][${i}][summary]    Fun 2024
#       Log    ${output1}
       Log    ${output2}
       IF    '${output2}' == 'True'
           ${check}     Set Variable       True
           BREAK
       END
   END
   Should Be Equal As Strings    ${check}    True      msg=False represent No calandar available with given name

   #string comparison
   ${items_str}     Convert To String    ${response.json()}[items]
    Log    ${items_str}
    Should Contain    ${items_str}    'summary': 'Fun 2024'

    #using Run Keyword And Ignore Error
    ${check}     Set Variable    False
    @{items_list}     Convert To List     ${response.json()}[items]
    Log    ${items_list}
    FOR    ${item}    IN    @{items_list}
        ${output1}      Run Keyword And Ignore Error    Dictionary Should Contain Value    ${item}     Fun 2024
        Log    ${output1}
        IF    '${output1}[0]' == 'PASS'
           ${check}     Set Variable       True
           BREAK
       END
    END
    Should Be Equal As Strings    ${check}    True      msg=False represent No calandar available with given name


TC2 Create Calendar from json
    ${payload}     Get Binary File     ${EXECDIR}${/}test_data${/}new_calendar.json
    &{headers}   Create Dictionary    Authorization=Bearer ya29.a0AXooCgs_zyRrUq01E8ODiCM1NRS5RM_KBB6b5Lc5tpaJFUQ4pPJKVz_cMxmUivUK2NtW-pYV1PYUkeBXMt4LUpgbLotp1xUEAOE0t_03wSRa9Vj3IeXqi-lCZdUPIRG7FrcrVFVUPVFE4H0ljsfrJ6_9gsl0DGMCcqn1aCgYKATUSARMSFQHGX2MiL6CYhCjwBtGSgMz3_fOvoQ0171
    
    ${respone}   POST On Session     alias=calcapi      url=calendars    data=${payload}     headers=${headers}
    Should Be Equal As Strings    ${respone.json()}[summary]    New Fun 2025

TC2 Create Calendar
    &{payload}     Create Dictionary        summary=New Fun 2026    description=through api automation
    &{headers}   Create Dictionary    Authorization=Bearer ya29.a0AXooCgs_zyRrUq01E8ODiCM1NRS5RM_KBB6b5Lc5tpaJFUQ4pPJKVz_cMxmUivUK2NtW-pYV1PYUkeBXMt4LUpgbLotp1xUEAOE0t_03wSRa9Vj3IeXqi-lCZdUPIRG7FrcrVFVUPVFE4H0ljsfrJ6_9gsl0DGMCcqn1aCgYKATUSARMSFQHGX2MiL6CYhCjwBtGSgMz3_fOvoQ0171

    ${respone}   POST On Session     alias=calcapi      url=calendars    json=${payload}     headers=${headers}
    Should Be Equal As Strings    ${respone.json()}[summary]    New Fun 2026


TC3 Create Calendar client cert
    @{cert}         Create List     client certificate      ${EXECDIR}${/}file.pem
    Create Client Cert Session    alias=cal_cert    url=https://www.googleapis.com/calendar/v3      client_certs=${cert}