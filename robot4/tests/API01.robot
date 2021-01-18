*** Settings ***
Documentation   https://fakerestapi.azurewebsites.net/index.html
...             Endpoints = Books
Resource        ../resource/resourceAPI.robot
Library         RequestsLibrary
Library         Collections
Suite Setup     Connect With API


*** Test Cases ***
Case of test 1: search list of books in API
    [TAGS]   LISTS
    request all books
    check all books     200
    check status code   200
    check reason        OK

Case of test 2: check a specific book
    [TAGS]  SPECIFIC
    request a specific book      15
    check status code            200
    check reason                 OK
    check datas of book 15

Case of test 3: cadaster a new book (POST)
    [TAGS]  POST

Case of test 4: TO-DO - Alter the book (PUT)
    [TAGS]  PUT

Case of test 5: TO-DO - delete a book (DELETE)
    [TAGS]  DELETE




