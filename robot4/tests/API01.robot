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
    cadaster a new book
    check status code            200
    check reason                 OK
    # check a specific book        {'id': 210, 'title': 'test', 'description': 'test', 'pageCount': 25, 'excerpt': 'test', 'publishDate': '2021-01-19T10:29:45.149Z'}
    check if return all datas cadaster in new book   210

Case of test 4: TO-DO - Alter the book (PUT)
    [TAGS]  PUT
    alter a book    100
    check status code            200
    check reason                 OK
    # check a specific book        {'id': 100, 'title': 'test 2', 'description': 'test 2', 'pageCount': 0, 'excerpt': 'test 2', 'publishDate': '2021-01-19T10:55:09.641Z'}
    check if return all datas cadaster in edited book   100

Case of test 5: TO-DO - delete a book (DELETE)
    [TAGS]  DELETE
    delete a book   2
    check status code            200
    check reason                 OK
    check delete book




