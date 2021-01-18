*** Settings ***
Library     SeleniumLibrary     
Library     String

*** Variables ***
${URL}      http://automationpractice.com/index.php
${BROWSER}  firefox
&{FIELDS}   firstname=Wictor    lastname=Gomes  password=12345678     address1=Street 01, Nº 34   city=Paulista   postcode=00000  phone_mobile=81 991021317   alias=Next at Church Assembléia             
@{TITLES}   Printed Summer Dress  Printed Chiffon Dress
     
*** Keywords ***
### Setups e teardowns
Abrir navegador
    Open Browser    about:blank  ${BROWSER}
Fechar navegador
    Close Browser
### NORMAL KEYWORDS
Novo email
    [Arguments]         ${NOME}     ${SOBRENOME}
    ${RANDOM_STRING}    Generate Random String
    ${CUSTOM_EMAIL}     Set Variable    ${NOME}${SOBRENOME}${RANDOM_STRING}@email.com
    [Return]            ${CUSTOM_EMAIL} 

Usando LOG para mensagens
    Log     Minha mensagem de LOG
    ${VAR}  Set Variable    variável qualquer
    Log     Posso logar uma ${VAR} no meio de um log

log console
    Log To Console      Done task
    Log Many            Complete list: @{TITLES}
    Log                 Posso logar somente itens da minha lista ${TITLES[0]} - ${TITLES[1]}

Screen_shots
    Log                         In web tests, i can log a Screenshot.
    Open Browser                http://www.robotizandotestes.blogspot.com.br    firefox
    Capture Page Screenshot     nome_img.png
    Close Browser
Keyword is true 
    Run Keyword If      '${BROWSER}' == 'firefox'   Log     This browser is firefox.
Keyword is false    
    Run Keyword Unless  '${FIELDS.firstname}' == 'Jhon'     Log     The real name is Wictor
Change variable if
    ${VAR}  Set Variable If     '${FIELDS.lastname}' == 'Gomes'   Silva
    ${FIELDS.lastname} =        Set Variable    ${VAR}                 
    Log                         ${FIELDS.lastname} now is ${VAR}


### Passo-a-passo

Acessar a página home do site
    Go To               http://automationpractice.com/index.php
    Title Should Be     My Store
Digitar o nome do produto "${PRODUCT}" no campo de pesquisa
    Input Text                      name=search_query    ${PRODUCT}
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
Passar o mouse por cima da categoria "Women" no menu principal superior de categorias
    Mouse Over                      //*[@id="block_top_menu"]//a[@class='sf-with-ul'][@title='Women']
    wait until element is visible   //*[@id="block_top_menu"]/ul/li[1]/ul/li[2]/ul/li[3]/a
Clicar na sub categoria "${CATEGORY}"
    Click Link                      //*[@id="block_top_menu"]/ul/li[1]/ul/li[2]/ul/li[3]/a
    wait until element is visible   //*[@id="center_column"]/div[1]/div
    wait until element is visible   //*[@id="center_column"]/ul/li[1]/div/div[2]/h5/a[@title="${TITLES[0]}"]
    wait until element is visible   //*[@id="center_column"]/ul/li[2]/div/div[2]/h5/a[@title="${TITLES[0]}"]
    wait until element is visible   //*[@id="center_column"]/ul/li[3]/div/div[2]/h5/a[@title="${TITLES[1]}"]
Clicar no botão "${BUTTON}" do produto 
    Mouse Over                      //*[@id="center_column"]/ul/li/div/div[1]/div/a[1]/img
    wait until element is visible   //*[@id="center_column"]/ul/li/div/div[2]/div[2]/a[1]
    Click Link                      //*[@id="center_column"]/ul/li/div/div[2]/div[2]/a[1]
    wait until element is visible   //*[@id="layer_cart"]/div[1]/div[1]/h2
Clicar no botão "Proceed to checkout"
    wait until element is visible       //*[@id="layer_cart"]/div[1]/div[1]/h2
    Click Link                          //*[@id="layer_cart"]//a[@class="btn btn-default button button-medium"]   
    wait until element is visible       //*[@id="cart_title"]
    wait until element is visible       //*[@id="product_1_1_0_0"]/td[2]/p
    wait until element is visible       //*[@id="product_1_1_0_0"]/td[2]/small[2]/a
    wait until element is visible       //*[@id="total_product"]
    wait until element is visible       //*[@id="total_shipping"]
    wait until element is visible       //*[@id="total_price_without_tax"]
    wait until element is visible       //*[@id="total_price_without_tax"]
    wait until element is visible       //*[@id="total_price_without_tax"]
Clicar no ícone carrinho de compras no menu superior direito
    Click link                          //*[@id="header"]/div[3]/div/div/div[3]/div/a
    wait until element is visible       //*[@id="cart_title"]
Clicar no botão de remoção de produtos "delete" no produto do carrinho
    wait until element is visible       //*[@id="1_1_0_0"]   
    Click Link                          //*[@id="1_1_0_0"] 
    wait until element is visible       //*[@id="center_column"]/p
Clicar no botão superior direito “Sign in”
    wait until element is visible       //*[@id="header"]//a[@class="login"]
    Click Link                          //*[@id="header"]//a[@class="login"]
    wait until element is visible       //*[@id="center_column"]/h1
Informar um e-mail válido
    ${NEW_EMAIL}                    Novo email  ${FIELDS.firstname}  ${FIELDS.lastname}                                
    Input Text                      name=email_create      ${NEW_EMAIL}
Clicar no botão "Create na account"
    Click Button                    //*[@id="SubmitCreate"]
    wait until element is visible   //*[@id="id_gender1"]           
    wait until element is visible   //*[@id="customer_firstname"]
    wait until element is visible   //*[@id="customer_lastname"]
    wait until element is visible   //*[@id="email"]
    wait until element is visible   //*[@id="passwd"]
    wait until element is visible   //*[@id="days"]
    wait until element is visible   //*[@id="firstname"]
    wait until element is visible   //*[@id="lastname"]
    wait until element is visible   //*[@id="company"]
    wait until element is visible   //*[@id="address1"]
    wait until element is visible   //*[@id="address2"]            
    wait until element is visible   //*[@id="city"] 
    wait until element is visible   name=id_country             
    wait until element is visible   //*[@id="postcode"]
    wait until element is visible   id=uniform-id_state         
    wait until element is visible   //*[@id="other"]
    wait until element is visible   //*[@id="phone"]
    wait until element is visible   //*[@id="phone_mobile"]
    wait until element is visible   //*[@id="alias"]
    wait until element is visible   //*[@id="submitAccount"]/span

Preencher os campos obrigatórios
    Input Text              //*[@id="customer_firstname"]   ${FIELDS.firstname}
    Input Text              //*[@id="customer_lastname"]    ${FIELDS.lastname}
    Input Text              //*[@id="passwd"]               ${FIELDS.password}
    Input Text              //*[@id="firstname"]            ${FIELDS.firstname}
    Input Text              //*[@id="lastname"]             ${FIELDS.lastname}
    Input Text              //*[@id="address1"]             ${FIELDS.address1}
    Input Text              //*[@id="city"]                 ${FIELDS.city}
    Input Text              //*[@id="postcode"]             ${FIELDS.postcode}
    Input Text              //*[@id="phone_mobile"]         ${FIELDS.phone_mobile}
    Input Text              //*[@id="alias"]                ${FIELDS.alias}
    Click Element           name=id_state
    Press Keys              name=id_state   ARROW_DOWN	
    Press Keys              name=id_state   RETURN

Clicar em "Register"para finalizar o cadastro
    Click Button                    //*[@id="submitAccount"]
    wait until element is visible   //*[@id="center_column"]/h1
    
