*** Settings ***
Documentation        Elementos e ações da página de cadastro

Library        Browser
Resource       ../env.robot

*** Keywords ***
Go to signup Page

   Go To    ${BASE_URL}/signup

    # Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Faça seu cadastro
Submit signup from
    [Arguments]        ${user}

    Fill Text    css=input[name=name]            ${user}[name]
    Fill Text    css=input[name=email]           ${user}[email]
    Fill text    css=input[name=password]        ${user}[password]

    Click        css=button[type=submit] >> text=Cadastrar
Notice should be
    [Arguments]        ${expected_text}

    ${element}         Set Variable    css=.notice p     
    
    Wait For Elements State    ${element}        visible        5
    Get Text                   ${element}        equal          ${expected_text}
