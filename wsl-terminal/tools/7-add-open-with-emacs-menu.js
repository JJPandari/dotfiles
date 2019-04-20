var WshShell = new ActiveXObject("WScript.Shell");

WshShell.CurrentDirectory = "..";
WshShell.RegWrite("HKCU\\Software\\Classes\\*\\shell\\emacs-in-wsl-terminal\\"
    , "Open with &emacs in wsl-terminal", "REG_SZ");
WshShell.RegWrite("HKCU\\Software\\Classes\\*\\shell\\emacs-in-wsl-terminal\\icon"
    , "\"" + WshShell.CurrentDirectory + "\\emacsclient.exe\"" );
WshShell.RegWrite("HKCU\\Software\\Classes\\*\\shell\\emacs-in-wsl-terminal\\command\\"
    , "\"" + WshShell.CurrentDirectory + "\\emacsclient.exe -n\" \"%1\"", "REG_SZ");
