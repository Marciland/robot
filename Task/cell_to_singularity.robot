*** Settings ***
Documentation   Tasks for Cell to Singularity (Steam)

Library         ImageHorizonLibrary

Resource        ../Keywords/cell_to_singularity.resource

*** Tasks ***
Dummy
    Sleep    5
    WHILE  True
        Click
    END