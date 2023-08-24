*** Settings ***
Documentation
   
Resource    ../resources/base.resource  

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
    [Tags]        dup

   ${user}        Create Dictionary        
    ...            name=Lucas Chagas       
    ...            email=chagas@hotmail.com        
    ...            password=pwd123

    Remove user from database     ${user}[email]
    Insert user from database     ${user}    

    Go to signup Page
    Submit signup from            ${user}    
    Notice should be              Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]         required       

    ${user}        Create Dictionary
    ...            name=${EMPTY}
    ...            email=${EMPTY}
    ...            password=${EMPTY}
    
    Go to signup Page
    Submit signup from         ${user}

    Alert should be            Informe seu nome completo
    Alert should be            Informe seu e-email
    Alert should be            Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com email incorreto

    ${user}        Create Dictionary
    ...            name=Charles Xavier
    ...            email=xavier.com.br
    ...            password=123456

    Go to signup Page
    Submit signup from           ${user}
    Alert should be              Digite um e-mail válido

Não deve cadastrar com senha muito curta

    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
    ${user}               Create Dictionary
    ...                    name=Chagas Lucas
    ...                    email=chagas@msn.com
    ...                    password=${password} 
    
    Go to signup Page
    Submit signup from         ${user}

    Alert should be            Informe uma senha com pelo menos 6 digitos        
    END

Não deve cadastrar com senha de 1 dígito
    [Tags]                required       
    [Template]    
    Short password        1 
Não deve cadastrar com senha de 2 dígitos
    [Tags]                required       
    [Template]    
    Short password        12

Não deve cadastrar com senha de 3 dígitos
    [Tags]                required       
    [Template]    
    Short password        123

Não deve cadastrar com senha de 4 dígitos
    [Tags]                required       
    [Template]    
    Short password        1234

Não deve cadastrar com senha de 5 dígitos
    [Tags]                required       
    [Template]    
    Short password        12345

*** Keywords ***
Short password

    [Arguments]    ${short_pass}       

    ${user}        Create Dictionary
    ...            name=Chagas Lucas
    ...            email=chagas@msn.com
    ...            password=${short_pass} 
    
    Go to signup Page
    Submit signup from         ${user}

    Alert should be            Informe uma senha com pelo menos 6 digitos
