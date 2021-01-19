*** Settings ***
Documentation   https://fakerestapi.azurewebsites.net/index.html
...             Endpoints = Books
Library         RequestsLibrary
Library         Collections


*** Variables ***
${URL_API}          https://fakerestapi.azurewebsites.net/api/v1
&{SPECIFIC_BOOK}    id=15
...                 title=Book 15
...                 pageCount=1500
${DELETE_BOOK}

*** Keywords ***
### SETUP AND TEARDOWN
Connect With API
    # Create Session(Alias, url)
    Create Session  FakeAPI     ${URL_API}


### ACTIONS
request all books
    ${Answer}           get on session  fakeApi  Books
    log                 ${Answer.text}
    set test variable   ${Answer}

request a specific book
    [Arguments]         ${id}
    ${Answer}           get on session  fakeApi  Books/${id}
    log                 ${Answer}
    log                 ${Answer.text}
    set test variable   ${Answer}

cadaster a new book
    ${headers}          create dictionary  content-type=application/json
    ${Answer}           post on session    fakeApi  Books
    ...                                    data={"id": 210,"title": "test","description": "test","pageCount": 25,"excerpt": "test","publishDate": "2021-01-19T10:29:45.149Z"}
    ...                                    headers=${headers}
    log                 ${Answer.text}
    set test variable   ${Answer}

alter a book
    [Arguments]         ${id}
    ${headers}          create dictionary  content-type=application/json
    ${Answer}           put on session  fakeApi  Books/${id}
    ...                 data={"id": 100, "title": "test 2", "description": "test 2", "pageCount": 0, "excerpt": "test 2", "publishDate": "2021-01-19T10:55:09.641Z"}
    ...                 headers=${headers}
    set test variable   ${Answer}
    log                 ${Answer.json()}

delete a book
    [Arguments]         ${id}
    ${Answer}           delete on session  fakeApi  Books/${id}
    log                 ${Answer.text}
    set test variable   ${Answer}


### CHECKS
check status code
    [Arguments]                  ${status_code_ideal}
    should be equal as strings   ${Answer.status_code}  ${status_code_ideal}
    log                          ${Answer.status_code}

check reason
    [Arguments]                 ${reason_ideal}
    should be equal as strings  ${Answer.reason}   ${reason_ideal}
    log                         ${Answer.reason}

check all books
    [Arguments]                 ${value}
    log                         ${Answer.json()}
    length should be            ${Answer.json()}   ${value}

check datas of book 15
    log                              ${Answer.json()}
    log                              ${SPECIFIC_BOOK}
    dictionary should contain item   ${Answer.json()}   id          ${SPECIFIC_BOOK.id}
    dictionary should contain item   ${Answer.json()}   title       ${SPECIFIC_BOOK.title}
    dictionary should contain item   ${Answer.json()}   pageCount   ${SPECIFIC_BOOK.pageCount}

    should not be empty    ${Answer.json()["description"]}
    should not be empty    ${Answer.json()["excerpt"]}
    should not be empty    ${Answer.json()["publishDate"]}

check delete book
    log                              ${Answer}
    log                              ${Answer.text}
    log                              ${DELETE_BOOK}
    should be equal as strings       ${Answer.text}   ${DELETE_BOOK}





