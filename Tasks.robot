*** Settings ***
# Documentation
Library     Browser
Library     OperatingSystem
Library     ImageHorizonLibrary  reference_folder=img\\de  keyword_on_failure=No Operation  confidence=0.8
Library     String
Library     keys.py
# Resource
# Suite Setup
# Suite Teardown
# Task Setup
# Task Teardown

*** Variables ***
${codeURL}          https://incendar.com/idlechampions_codes.php
${cookiesAccept}    //*[@id="ncmp__tool"]/div/div/div[3]/div[1]/button[2]
${codeList}         //*[@id="123"]
${smallCode}        14
${largeCode}        19

*** Keywords ***

Read Codes To List
    New Page            ${codeURL}
    Browser.Click       ${cookiesAccept}
    Scroll To           vertical=bottom
    ${codes}            Get Text            ${codeList}
    @{codesAsList}      Split To Lines      ${codes}
    Set Task Variable   @{codesAsList}

Setup Codes
    Read Codes To List
    Wait Until Keyword Succeeds    10x    100ms    Click Image         chestInventory.png
    Sleep               1s
    Click Image         enterCode.png
    Sleep               1s

Input All Codes
    FOR    ${code}    IN    @{codesAsList}
        ${size}    Get Length    ${code}
        Input Code    ${code}  ${size}
    END

Set To Code Size
    [Arguments]    ${size}
    IF  ${size} == ${smallCode}
        ${fit}    Does Exist                    large.png
        IF    ${fit} == ${False}
                   Click Image                     small.png
        END
    ELSE
        ${fit}        Does Exist                        small.png
        IF    ${fit} == ${False}
                   Click Image                     large.png
        END
    END

Cancel Code Input
    Click Image     ok.png
    Sleep           1s
    Send Keys       esc

Input Code
    [Arguments]         ${code}                         ${size}
    Wait Until Keyword Succeeds    10x    100ms    Set To Code Size    ${size}
    Type                ${code}
    Click Image         unlock.png
    ${already}          Run Keyword And Return Status
    ...                 ImageHorizonLibrary.Wait For    already.png  1
    ${expired}          Run Keyword And Return Status
    ...                 ImageHorizonLibrary.Wait For    expired.png  1
    ${invalid}          Run Keyword And Return Status
    ...                 ImageHorizonLibrary.Wait For    invalid.png  1
    IF                  ${already} == ${True}
                        Cancel Code Input
    END
    IF                  ${expired} == ${True}
                        Cancel Code Input
    END
    IF                  ${invalid} == ${True}
                        Cancel Code Input
    END
    IF  ${already} == ${False} and ${expired} == ${False} and ${invalid} == ${False}
        Wait Until Keyword Succeeds    10x    100ms    Click Image  flip.png
        Wait Until Keyword Succeeds    10x    100ms    Click Image  done.png
    END
    Wait Until Keyword Succeeds    10x    100ms    Click Image  enterCode.png

*** Tasks ***
Use Codes
    [Setup]    Setup Codes
    Input All Codes