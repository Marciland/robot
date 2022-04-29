import subprocess
import sys

def run(language, suite):
    command = "powershell.exe robot --variable LANGUAGE:"+language+" --outputdir ${CURDIR}${/}result Task/"+suite+".robot"
    subprocess.run(command)

if __name__ == "__main__":
    language = str(sys.argv[1])
    suite = str(sys.argv[2])
    run(language, suite)