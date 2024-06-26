*** Settings ***
Library     RequestsLibrary
Library    OperatingSystem

Suite Setup     Create Session    alias=petstore    url=https://petstore.swagger.io/v2
Suite Teardown      Delete All Sessions

*** Test Cases ***
TC1 Get Valid Pet Id
    ${response}      GET On Session     alias=petstore      url=/pet/5      expected_status=200
    Status Should Be    200
    Log    ${response.json()}
    Log    ${response.json()}[id]
    Should Be Equal As Integers    ${response.json()}[id]    5
    #get the name and log it
    Log    ${response.text}
    Log    ${response.status_code}
    Log    ${response.json()}[name]
    Log    ${response.json()}[category]
    Log    ${response.json()}[category][name]

TC2 Get Invalid Pet Id
    ${response}      GET On Session     alias=petstore      url=/pet/59999      expected_status=404
    #assert the Pet not found message
    Log    ${response.json()}
    Should Be Equal As Strings    ${response.json()}[message]    Pet not found

TC3 Find By Status
    ${status}   Set Variable    available
    ${response}     GET On Session      alias=petstore  url=/pet/findByStatus?status=${status}    expected_status=200
#    Log    ${response}
#    Log    ${response.json()}
#    Log    ${response.json()}[0]
#try to get status of the first pet in the array
#    Log    ${response.json()}[0][status]

    ${pet_count}    Get Length    ${response.json()}
    FOR    ${i}    IN RANGE    0    ${pet_count}
#        Log    ${i}
#        Log    ${response.json()}[${i}][status]
        Should Be Equal As Strings    ${response.json()}[${i}][status]    ${status}
    END


    FOR    ${pet}    IN    @{response.json()}
        Should Be Equal As Strings    ${pet}[status]    ${status}
#        Log    ${pet}
    END


TC3 Delete Valid Pet
    ${respone}  DELETE On Session    alias=petstore     url=/pet/10    expected_status=200

TC4 Delete Invalid Pet
    DELETE On Session    alias=petstore     url=/pet/501    expected_status=404


TC5 Add Valid Pet To Store
    ${json}      Get Binary File     ${EXECDIR}${/}test_data${/}add_pet.json
    &{header}   Create Dictionary   Content-Type=application/json       Connection=keep-alive
    ${response}     POST On Session     alias=petstore      url=/pet    headers=${header}    data=${json}
    ...     expected_status=200
    Should Be Equal As Integers    ${response.json()}[id]    601


TC6 Upate a Pet
    ${json}      Get Binary File     ${EXECDIR}${/}test_data${/}update_pet.json
    &{header}   Create Dictionary   Content-Type=application/json       Connection=keep-alive
    ${response}     Put On Session     alias=petstore      url=/pet    headers=${header}    data=${json}
    ...     expected_status=200
    Should Be Equal As Integers    ${response.json()}[id]    601
    Should Be Equal As Strings    ${response.json()}[name]    doggie601-update

TC7 Image Upload
    ${image_file}      Get Binary File     ${EXECDIR}${/}test_data${/}demo.jpg
    &{payload}      Create Dictionary       additionalMetadata=image/jpg
    ${files}    Create List     file    ${image_file}
    ${files1}       Create List     ${files}

    ${response}     POST On Session     alias=petstore      url=/pet/5/uploadImage     data=${payload}     files=${files1}
    ...     expected_status=200
