*** Settings ***
Documentation     Resource file containing all keywords used in Tasks.
Library           Browser
Library           OperatingSystem
Library           String
Library           Python/keys.py
Library           ImageHorizonLibrary    reference_folder=resource\\img\\${LANGUAGE}
...               keyword_on_failure=No Operation
...               confidence=0.95
Library           Collections

*** Variables ***
${codeURL}        https://incendar.com/idlechampions_codes.php
${usedCodesPath}    resource\\txt\\usedCodes.txt
${cookiesAccept}    //*[@id="ncmp__tool"]/div/div/div[3]/div[1]/button[2]
${codeList}       //*[@id="123"]
${smallCode}      14
${largeCode}      19

*** Keywords ***
Read Codes From Website
    New Page    ${codeURL}
    Browser.Click    ${cookiesAccept}
    Scroll To    vertical=bottom
    ${codes}    Get Text    ${codeList}
    @{codesList}    Split To Lines    ${codes}
    Set Task Variable    @{codesList}

Read Codes From File
    ${status}    Run Keyword And Return Status    File Should Exist    ${usedCodesPath}
    IF    ${status} == ${False}
        Create File    ${usedCodesPath}
    END
    ${usedCodes}    Get File    ${usedCodesPath}
    @{usedCodesList}    Split To Lines    ${usedCodes}
    Set Task Variable    @{usedCodesList}

Compare Codes
    Read Codes From Website
    Read Codes From File
    FOR    ${code}    IN    @{codesList}
        ${status}    Run Keyword And Return Status    List Should Contain Value    ${usedCodesList}    ${code}
        IF    ${status} == ${True}
            Remove Values From List    ${codesList}    ${code}
        END
    END
    Set Task Variable    @{codesList}

Gather Codes And Enter ChestInventory
    Compare Codes
    Wait Until Keyword Succeeds    10x    100ms    Click Image    chestInventory.png
    Sleep    1s

Input All Codes
    FOR    ${code}    IN    @{codesList}
        ${size}    Get Length    ${code}
        Input Code    ${code}    ${size}
    END

Set To Code Size
    [Arguments]    ${size}
    IF    ${size} == ${smallCode}
        ${fit}    Does Exist    large.png
        IF    ${fit} == ${False}
            Click Image    small.png
        END
    ELSE
        ${fit}    Does Exist    small.png
        IF    ${fit} == ${False}
            Click Image    large.png
        END
    END

Write Used Code
    [Arguments]    ${code}
    Append To File    ${usedCodesPath}    ${code}\n
    Cancel Code Input

Cancel Code Input
    Click Image    ok.png
    Sleep    1s
    Send Keys    esc

Collect Loot
    Wait Until Keyword Succeeds    10x    100ms    Click Image    flip.png
    Wait Until Keyword Succeeds    10x    100ms    Click Image    done.png

Input Code
    [Arguments]    ${code}    ${size}
    Wait Until Keyword Succeeds    10x    100ms    Click Image    cryptex.png
    Wait Until Keyword Succeeds    10x    100ms    Set To Code Size    ${size}
    Type    ${code}
    Wait Until Keyword Succeeds    10x    100ms    Click Image    unlock.png
    ${already}    Run Keyword And Return Status
    ...    ImageHorizonLibrary.Wait For    already.png    1
    ${expired}    Run Keyword And Return Status
    ...    ImageHorizonLibrary.Wait For    expired.png    1
    ${invalid}    Run Keyword And Return Status
    ...    ImageHorizonLibrary.Wait For    invalid.png    1
    IF    ${invalid} == ${True}
        Cancel Code Input
    ELSE IF    ${expired} == ${True} or ${already} == ${True}
        Write Used Code    ${code}
    ELSE IF    ${already} == ${False} and ${expired} == ${False} and ${invalid} == ${False}
        Collect Loot
    END
