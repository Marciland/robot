*** Settings ***
Documentation     Tasks for idle champions
Resource          ../Keywords/idleChamps.resource

*** Variables ***
${LANGUAGE}       de

*** Tasks ***
Use Codes
    [Setup]    Gather Codes And Enter ChestInventory
    Input All Codes
