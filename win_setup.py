
import subprocess as sub


# Function to simulate file download (replace this with actual download code)
def download_file(file:str):
    # downloading python if you want and install git for future tasks
    if file == "git":
        sub.run("powershell.exe winget install --id Git.Git -e --source winget",shell=True)
        sub.run("git clone https://github.com/marhau-dev/win_setup_marhau_ED",shell=True)
        cls()
        title(2)
        print("Git and Script was downloaded ")
    






def cls():
    sub.run("cls", shell=True)

def title(type:int):


    if type == 1:
        print(""" 
      

░█░█░█▀▀░█░░░█▀▀░█▀█░█▄█░█▀▀░░░▀█▀░█▀█░░░█░█░▀█▀░█▀█░░░█▀▀░█▀▀░▀█▀░█░█░█▀█
░█▄█░█▀▀░█░░░█░░░█░█░█░█░█▀▀░░░░█░░█░█░░░█▄█░░█░░█░█░░░▀▀█░█▀▀░░█░░█░█░█▀▀
░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀░▀░░░▀░▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░
      
     
              

      """)
    else:
        print("""
              
░░░█░█░▀█▀░█▀█░░░█▀▀░█▀▀░▀█▀░█░█░█▀█
░░░█▄█░░█░░█░█░░░▀▀█░█▀▀░░█░░█░█░█▀▀
░░░▀░▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░
              
              """)

title(1)

print("press any button")
input()

a = "git"

download_file(a)

cls()
title(1)
print("\n Runing script")

sub.run(
    'powershell.exe -Command "cd .\\win_setup_marhau_ED; '
    'Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force; '
    'ls -Recurse *.ps*1 | Unblock-File; '
    '.\\WinDebloatTools.ps1 "CLI""', 
    shell=True
)











