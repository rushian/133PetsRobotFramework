*** Settings ***
Documentation       Teste de consulta no buscador Google
...                 Abre o navegador
...                 E realiza a consulta com a biblioteca do Selenium
...                 smoketest e um teste pra garantir o funcionamento minimo

Library         SeleniumLibrary
Library         OperatingSystem
Test Setup      log to console  \n===== INICIO DOS TESTES ======\n
Test Teardown   Encerrar browser

*** Variables ***
#${browser}  Chrome
${browser}  headlesschrome
${url}      https://www.google.com.br

*** Test Cases ***
Consulta Google
    [Tags]    smoketest, rapido
    Setup chromedriver
    Dado que estou usando o Chrome e acesso o site https://www.google.com.br
    E pesquiso pelo termo deck de magic arena
    Entao verifico se no titulo da guia contem "luke magic arena"

*** Keywords ***
Setup chromedriver
    Set Environment Variable  webdriver.Chrome.driver  ${EXECDIR}\\venv\\WebDriverManager\\chrome\\105.0.5195.52\\chromedriver_win32\\chromedriver.exe
Dado que estou usando o Chrome e acesso o site https://www.google.com.br
    Open Browser    ${url}  ${browser}
    Log To Console    Abrir a pagina no navegador
E pesquiso pelo termo deck de magic arena
    Set Test Variable    ${query}   luke magic arena
    Log To Console    Buscar a caixa pra digitar "${query}"
    Input Text    name = q   ${query}
    Press Keys      q    ENTER
Entao verifico se no titulo da guia contem "${query}"

    Log To Console    Verificar titulo da pagina
    ${titulo} =  Get Title
    Should Contain    ${titulo}    ${query}

    Log To Console    Verificar e clicar no link escolhido
    Page Should Contain    lukegamer2015
    Click Link     xpath=//a[contains(.,'lukegamer2015')]

Encerrar browser
    Sleep       4000ms
    Close Browser
