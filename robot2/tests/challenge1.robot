*** Settings ***
Resource        ../resource/Resource.robot
Test Setup      Abrir navegador
Test Teardown   Fechar navegador

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

Caso de teste 3: listar produtos
    [Tags]  Category
    Acessar a página home do site
    Passar o mouse por cima da categoria "Women" no menu principal superior de categorias
    Clicar na sub categoria "Summer Dresses" 

Caso de teste 4: adicionar produtos no carrinho
    Acessar a página home do site
    Digitar o nome do produto "t-shirt" no campo de pesquisa
    Clicar no botão pesquisar
    Clicar no botão "Add to cart" do produto
    Clicar no botão "Proceed to checkout"
Caso de teste 5: remover produtos
    [Tags]  checkout
    ### Medida paliativa
    Acessar a página home do site
    Digitar o nome do produto "t-shirt" no campo de pesquisa
    Clicar no botão pesquisar
    Clicar no botão "Add to cart" do produto
    Clicar no botão "Proceed to checkout"
    # Acessar a página home do site
    Clicar no ícone carrinho de compras no menu superior direito
    Clicar no botão de remoção de produtos "delete" no produto do carrinho

Caso de teste 6: adicionar cliente
    [Tags]  addClients
    # Usando LOG para mensagens
    # log console
    # Screen_shots
    # Keyword is true 
    # Keyword is false
    Change variable if
    Acessar a página home do site
    Clicar no botão superior direito “Sign in”
    Informar um e-mail válido    
    Clicar no botão "Create na account"
    Preencher os campos obrigatórios
    Clicar em "Register"para finalizar o cadastro

# *** Keywords ***
