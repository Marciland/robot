*** Settings ***
# Documentation
Library     Browser
Library     OperatingSystem
Library     ImageHorizonLibrary         reference_folder=img            keyword_on_failure=No Operation
Library     String
Library     Collections
# Resource
# Suite Setup
# Suite Teardown
# Task Setup
# Task Teardown

*** Variables ***
${codeURL}          https://incendar.com/idlechampions_codes.php
${cookiesAccept}    //*[@id="ncmp__tool"]/div/div/div[3]/div[1]/button[2]
${codeList}         //*[@id="123"]

*** Keywords ***
# Documentation

Read Codes To List
    New Page            ${codeURL}
    Browser.Click       ${cookiesAccept}
    Scroll To           vertical=bottom
    ${codes}            Get Text            ${codeList}
    @{codesAsList}      Split To Lines      ${codes}
    Set Task Variable   @{codesAsList}
Open Locked Chest Interface
    Click Image         chestInventory.png
    Sleep               1s
    Click Image         enterCode.png
    Sleep               1s

Input Codes
    FOR    ${element}    IN    @{codesAsList}
        # use element to input code
    END

*** Tasks ***
# Documentation
# Tags
# Setup
# Teardown

Test
    Read Codes To List
    #Open Locked Chest Interface
    Input Codes