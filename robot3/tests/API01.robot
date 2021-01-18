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
# Check if return a list with 200 books.
    Request all books
    Check status code   200
    Check reason    OK
    Check if return a list with "200" books
Case of test 2: check a specific book
    Request book "12"
    Check status code   200
    Check reason    OK
    Check all datas of book 12
Case of test 3: cadaster a new book (POST)
    Cadaster a new book
    Check datas of new book
Case of test 4: TO-DO - Alter the book (PUT)
    Alter the book "150"
Case of test 5: TO-DO - delete a book (DELETE)
    Delete a book




