*** Settings ***
Documentation     This file contains all necessary keywords for emporea.robot.
Library           ImageHorizonLibrary    reference_folder=resource/img/emporea/${RESOLUTION}    screenshot_folder=result/    confidence=0.8

*** Keywords ***
Open Emporea
    [Documentation]    This keyword opens Emporea from Steam.
    ...    Sadly Launch Application does not work properly for this game.
    Launch Application    "C:\\Program Files (x86)\\Steam\\steam.exe"
    Wait For    steambib.png    5
    Click Image    steambib.png
    Wait for    emp.png    5
    ${emp}    Locate    emp.png
    Move To    ${emp}
    Double Click
    Wait for    close.png    25
    Close Popups
    ${claimexists}    Does Exist    claim.png
    IF    ${claimexists}
        Click Image    claim.png
    END
    Click Image    world.png

Attack Portal
    [Documentation]    This keyword closes all recent popups if available and then attacks a portal once.
    Close Popups
    Wait for    easy.png    1
    ${easyloc}    Locate    easy.png
    Move to    ${easyloc}
    Click Image    easy.png
    Wait for    attack.png    1
    Click Image    attack.png
    Wait for    max.png    1
    Click Image    max.png
    Wait for    go.png    1
    Click Image    go.png

Close Popups
    [Documentation]    This keyword closes all popups on screen.
    ${exists}    Does Exist    close.png
    IF    ${exists}
        FOR    ${i}    IN RANGE    5
            ${exists_in_loop}    Does Exist    close.png
            Exit For Loop If    not ${exists_in_loop}
            Click Image    close.png
        END
    END
