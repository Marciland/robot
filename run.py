import subprocess
import sys

def run(variable, suite):
    command = "powershell.exe robot --variable "+variable+" --outputdir ${CURDIR}${/}result Task/"+suite+".robot"
    subprocess.run(command)

if __name__ == "__main__":
    variable = str(sys.argv[1])
    suite = str(sys.argv[2])
    run(language, suite)