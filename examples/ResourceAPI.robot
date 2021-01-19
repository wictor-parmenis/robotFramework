*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books
Library         RequestsLibrary
Library         Collections

*** Variable ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/v1
&{BOOK_15}      id=15
...             title=Book 15
...             pageCount=1500
&{BOOK_201}     id=201
...             title=Meu novo Book
...             description=Meu novo livro conta coisas fantásticas
...             pageCount=523
...             excerpt=Meu Novo livro é massa
...             publishDate=2018-04-26T17:58:14.765Z
&{BOOK_150}     id=150
...             title=Book 150 alterado
...             description=Descrição do book 150 alteada
...             pageCount=600
...             excerpt=Resumo do book 150 alteado
...             publishDate=2017-04-26T15:58:14.765Z

*** Keywords ***
####SETUP E TEARDOWNS
Conectar a minha API
    Create Session    fakeAPI    ${URL_API}
    ${HEADERS}     Create Dictionary    content-type=application/json
    Set Suite Variable    ${HEADERS}

#### Ações
Requisitar todos os livros
    ${RESPOSTA}    Get Request    fakeAPI    Books
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}    Get Request    fakeAPI    Books/${ID_LIVRO}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Cadastrar um novo livro
    ${RESPOSTA}    Post Request   fakeAPI    Books
    ...                           data={"ID": ${BOOK_201.ID},"Title": "${BOOK_201.Title}","Description": "${BOOK_201.Description}","PageCount": ${BOOK_201.PageCount},"Excerpt": "${BOOK_201.Excerpt}","PublishDate": "${BOOK_201.PublishDate}"}
    ...                           headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Alterar o livro "${ID_LIVRO}"
    ${RESPOSTA}    Put Request    fakeAPI    Books/${ID_LIVRO}
    ...                           data={"ID": ${BOOK_150.ID},"Title": "${BOOK_150.Title}","Description": "${BOOK_150.Description}","PageCount": ${BOOK_150.PageCount},"Excerpt": "${BOOK_150.Excerpt}","PublishDate": "${BOOK_150.PublishDate}"}
    ...                           headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Excluir o livro "${ID_LIVRO}"
    ${RESPOSTA}    Delete Request    fakeAPI    Books/${ID_LIVRO}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

#### Conferências
Conferir o status code
    [Arguments]      ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]    ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}     ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros
    Length Should Be      ${RESPOSTA.json()}     ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro 15
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id              ${BOOK_15.ID}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    Title           ${BOOK_15.Title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    PageCount       ${BOOK_15.PageCount}
    Should Not Be Empty    ${RESPOSTA.json()["Description"]}
    Should Not Be Empty    ${RESPOSTA.json()["Excerpt"]}
    Should Not Be Empty    ${RESPOSTA.json()["PublishDate"]}

Conferir se retorna todos os dados cadastrados do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}

Conferir se retorna todos os dados alterados do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}

Conferir livro
    [Arguments]     ${ID_LIVRO}
    log                               ${BOOK_${ID_LIVRO}.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id              ${BOOK_${ID_LIVRO}.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    Title           ${BOOK_${ID_LIVRO}.Title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    Description     ${BOOK_${ID_LIVRO}.Description}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    PageCount       ${BOOK_${ID_LIVRO}.PageCount}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    Excerpt         ${BOOK_${ID_LIVRO}.Excerpt}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    PublishDate     ${BOOK_${ID_LIVRO}.PublishDate}

Conferir se excluiu o livro "${ID_LIVRO}"
    Should Be Empty     ${RESPOSTA.content}
