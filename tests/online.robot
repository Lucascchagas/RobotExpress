*** Settings ***
Documentation

Resource        ../resources/base.resource   

*** Test Cases ***
Example Test
    New Page    https://playwright.dev
    Get Text    h1    contains    Playwright

*** Test Cases ***
Webapp deve estar online

    Start Session
    Get Title       equal        Mark85 by QAx       
