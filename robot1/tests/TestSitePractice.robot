*** Settings ***
Resource        ../resource/Resource.robot
Test Setup      Abrir navegador
# Test Teardown   Fechar navegador

*** Test Cases ***
Caso de teste 1: pesquisar produtos existentes
     Acessar a página home do site
     Digitar o nome do produto "Blouse" no campo de pesquisa
     Clicar no botão pesquisar
     Conferir se o produto "Blouse" foi listado no site

Caso de teste 2: pesquisar produtos não existentes
    Acessar a página home do site
    Digitar o nome do produto "produtoNãoExistente" no campo de pesquisa
    Clicar no botão pesquisar
    Conferir se a mensagem de erro: "No results were found for your search "produtoNãoExistente""

# *** Keywords ***
