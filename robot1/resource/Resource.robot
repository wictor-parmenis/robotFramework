*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL}      http://automationpractice.com/index.php
${BROWSER}  firefox

*** Keywords ***
### Setups e teardowns
Abrir navegador
    Open Browser    about:blank  ${BROWSER}
Fechar navegador
    Close Browser

### Passo-a-passo
Acessar a página home do site
    Go To               http://automationpractice.com/index.php
    Title Should Be     My Store
Digitar o nome do produto "${PRODUCT}" no campo de pesquisa
    Input Text          name=search_query    ${PRODUCT}
Clicar no botão pesquisar
    Click Button        name=submit_search 
Conferir se o produto "${PRODUCT}" foi listado no site
    wait until element is visible   css=.product_img_link > img:nth-child(1)
    Title Should Be                 Search - My Store
    Page Should Contain Image       xpath=//*[@id="center_column"]//*[@src='http://automationpractice.com/img/p/7/7-home_default.jpg']
    Page Should Contain Link        xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUCT}")]
Conferir se a mensagem de erro: "${MESSAGE}"
    wait until element is visible   xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]
    Element Text Should Be          xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]    ${MESSAGE}