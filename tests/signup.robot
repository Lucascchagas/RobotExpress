*** Settings ***
Documentation
   
Resource    ../resources/base.robot  

Suite Setup        Log    Tudo aqui ocorre antes da Suite
Suite Teardown     Log    Tudo aqui ocorre depois da Suite

Test Setup         Start Session
Test Teardown      Take Screenshot

*** Test Cases ***
Deve cadastrar um novo usuário

    ${user}        Create Dictionary        
    ...            name=Lucas Chagas       
    ...            email=chagas@hotmail.com        
    ...            password=pwd123

    Remove user from database    ${user}[email]

    Go To    ${BASE_URL}/signup

    # Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Faça seu cadastro

    Fill Text    css=input[name=name]            ${user}[name]
    Fill Text    css=input[name=email]           ${user}[email]
    Fill text    css=input[name=password]        ${user}[password]

    Click        css=button[type=submit] >> text=Cadastrar

    Wait For Elements State    css=.notice p        visible        5
    Get Text                   css=.notice p        equal          Boas vindas ao Mark85, o seu gerenciador de tarefas.
    
Não deve permitir o cadastro com email duplicado
    [Tags]   dup

   ${user}        Create Dictionary        
    ...            name=Lucas Chagas       
    ...            email=chagas@hotmail.com        
    ...            password=pwd123

    Remove user from database      ${user}[email]
    Insert user from database      ${user}    

    Go To    ${BASE_URL}/signup

    # Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Faça seu cadastro

    Fill Text    css=#name            ${user}[name]
    Fill Text    css=#email           ${user}[email]
    Fill text    css=#password        ${user}[password]

    Click        id=buttonSignup

    Wait For Elements State    css=.notice p        visible        5
    Get Text                   css=.notice p        equal          Oops! Já existe uma conta com o e-mail informado.
    