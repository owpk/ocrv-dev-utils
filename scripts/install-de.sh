#!/bin/bash

CZT_HOME=$HOME/ocrv/czt

function installDesktopEntries() {
   cat << EOF >> ${HOME}"/Рабочий стол/"${1}
[Desktop Entry]
Categories=Utility;TextEditor;Development;IDE
Comment=Code Editing. Redefined.
Exec=code ${CZT_HOME}/${1}
GenericName=Text Editor
Icon=vscode
Keywords=vscode
Name=Visual Studio Code
StartupNotify=true
StartupWMClass=Code
Type=Application
Version=1.4
EOF
}

function installVsCodeScripts() {
   
   target="$HOME/ocrv/$1.sh"
   cat << EOF >> "${target}"
#!/bin/bash
code ${CZT_HOME}/$1
EOF
   chmod +x $target
}

for i in $($HOME/.local/bin/cztlist); do
   echo $i
   installVsCodeScripts $i
   installDesktopEntries $i
done
