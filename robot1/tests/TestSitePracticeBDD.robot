*** Settings ***
Resource        ../resource/Resource.robot
Suite Setup     Abrir navegador
Suite Teardown  Fechar navegador

### SETUP: roda as keyword antes da suite ou antes de um teste.
### TEARDOWN: roda a keyword depois de uma suite ou de um teste.

*** Variables ***


*** Test Cases ***
Caso de teste 1: pesquisar produtos existentes
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "Blouse"
    Então o produto "Blouse" deve ser listado na página resultado da busca

Caso de teste 2: pesquisar produtos não existentes
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "produtoNãoExistente"
    Então a página deve exibir a mensagem "No results were found for your search "produtoNãoExistente""

*** Keywords ***
Dado que estou na página home do site
    Acessar a página home do site

Quando eu pesquisar pelo produto "${PRODUCT}"
    Digitar o nome do produto "${PRODUCT}" no campo de pesquisa
    Clicar no botão pesquisar

Então o produto "${PRODUCT}" deve ser listado na página resultado da busca
    Conferir se o produto "${PRODUCT}" foi listado no site

Então a página deve exibir a mensagem "${MESSAGE}"
    Conferir se a mensagem de erro: "${MESSAGE}"

    



