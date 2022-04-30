*** Settings ***
Documentation   This automates attacking portals in Emporea from Steam.

Resource        ../Keywords/emporea.resource

Suite Setup    Open Emporea
*** Variables ***
${RESOLUTION}    1080p

*** Tasks ***
Attack Portals
    [Documentation]     This task starts to attack portals.
    Attack Portal