*** Settings ***
Documentation   https://fakerestapi.azurewebsites.net/index.html
Library         RequestsLibrary
Library         Collections


*** Variables ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/
&{BOOK_12}      id=12
...             title=Book 12
...             description=Lorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\n
...             pageCount=1200
...             excerpt=Lorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\n
...             publishDate=2020-12-31T13:38:59.0479626+00:00
&{NEW_BOOK}    id=900
...            title=test
...            description=a_test
...            pageCount=200
...            excerpt=nothing
...            publishDate=2021-01-12T18:02:55.025Z

&{BOOK_115}     id=115
...             title=Book 115_NEW
...             description=NEW Description
...             pageCount=115
...             excerpt=115 loreins. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\n
...             publishDate=2030-12-31T13:38:59.0479626+00:00



*** Keywords ***
### SETUP AND TEARDOWN
Connect With API
    Create Session  FakeAPI     ${URL_API}
    ${HEADERS}     Create Dictionary    content-type=application/json
    Set Suite Variable    ${HEADERS}
     


### ACTIONS
Request all books
    ${ANSWER}           GET On Session     FakeAPI     v1/Books
    Log                 ${ANSWER.text}
    Set Test Variable   ${ANSWER}
Request book "${ID_BOOK}"
    ${ANSWER}           GET On Session  FakeAPI     v1/Books/${ID_BOOK}
    Log                 ${ANSWER.text}
    Set Test Variable   ${ANSWER}
    Set Test Variable   ${ID_BOOK}

### CHECKS
Check status code
    [Arguments]                  ${STATUS_CODE_WANTED}
    Should Be Equal As Strings   ${ANSWER.status_code}   ${STATUS_CODE_WANTED}
Check reason
    [Arguments]                     ${REASON_WANTED}
    Should Be Equal As Strings      ${ANSWER.reason}    ${REASON_WANTED}      
Check if return a list with "${BOOKS_WANTED}" books
    Length Should Be        ${ANSWER.json()}    ${BOOKS_WANTED}
Check all datas of book 12
# FIXES FIELDS
    Dictionary Should Contain Item   ${ANSWER.json()}   id              ${BOOK_12.id}
    Dictionary Should Contain Item   ${ANSWER.json()}   title           ${BOOK_12.title}
    Dictionary Should Contain Item   ${ANSWER.json()}   pageCount       ${BOOK_12.pageCount}
# VARIABLES FIELDS
    Should Not Be Empty              ${ANSWER.json()["description"]}
    Should Not Be Empty              ${ANSWER.json()["excerpt"]}
    Should Not Be Empty              ${ANSWER.json()["publishDate"]}
Cadaster a new book
    ${HEADER}   Create Dictionary  content-type=application/json
    ${ANSWER}   POST On Session    FakeAPI   v1/Books
    ...                            data={"id": 900,"title": "test","description": "a_test","pageCount": 200,"excerpt": "nothing","publishDate": "2021-01-12T18:02:55.025Z"}     
    ...                            headers=${HEADER}
    Log                 ${ANSWER.text}
    Set Test Variable   ${ANSWER}
Check datas of new book  
    Dictionary Should Contain Item   ${ANSWER.json()}   id              ${NEW_BOOK.id}
    Dictionary Should Contain Item   ${ANSWER.json()}   title           ${NEW_BOOK.title}
    Dictionary Should Contain Item   ${ANSWER.json()}   pageCount       ${NEW_BOOK.pageCount}
    Dictionary Should Contain Item   ${ANSWER.json()}   publishDate     ${NEW_BOOK.publishDate}
    Dictionary Should Contain Item   ${ANSWER.json()}   excerpt         ${NEW_BOOK.excerpt}
    Dictionary Should Contain Item   ${ANSWER.json()}   description     ${NEW_BOOK.description} 
Alter the book "${BOOK_ID}"
    ${HEADERS_2}      Create Dictionary     content-type=application/json       
    ${ANSWER}   PUT On Session      FakeAPI     v1/Books/${BOOK_ID}
    ...                             data={"id": ${BOOK_115.id},"title": "${BOOK_115.title}","description": "${BOOK_115.description}","pageCount": ${BOOK_115.pageCount},"excerpt": "${BOOK_115.excerpt}","publishDate": "${BOOK_115.publishDate}"}
    ...                             headers=${HEADERS_2}

Delete a book
    ${ANSWER}           DELETE On Session      FakeAPI     v1/Books/115
Check delete of book
    Run Keyword If      '${ANSWER.text}' == ''                    Log to console      ${ANSWER.text}                



