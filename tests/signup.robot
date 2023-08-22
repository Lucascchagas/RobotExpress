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

    Go to signup Page
    Submit signup from           ${user} 
    Notice should be             Boas vindas ao Mark85, o seu gerenciador de tarefas.
    
Não deve permitir o cadastro com email duplicado
    [Tags]   dup

   ${user}        Create Dictionary        
    ...            name=Lucas Chagas       
    ...            email=chagas@hotmail.com        
    ...            password=pwd123

    Remove user from database     ${user}[email]
    Insert user from database     ${user}    

    Go to signup Page
    Submit signup from            ${user}    
    Notice should be              Oops! Já existe uma conta com o e-mail informado.