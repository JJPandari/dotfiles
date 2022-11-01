#If !WinActive("ahk_class Emacs") and !WinActive("ahk_class mintty") and !WinActive("ahk_exe aces.exe") and !WinActive("ahk_exe KFGame.exe") and !WinActive("ahk_exe helldivers.exe") and !WinActive("ahk_class R6Game") and !WinActive("ahk_class CryENGINE") and !WinActive("ahk_exe DeadByDaylight-Win64-Shipping.exe") and !WinActive("ahk_exe Cyberpunk2077.exe") and !WinActive("ahk_exe blender.exe") and !WinActive("ahk_class Respawn001")
RAlt & s::
If (!WinActive("ahk_class Emacs") and !WinActive("ahk_class mintty"))
{
    Send, ^c
    Sleep 50
}
Run, http://cn.bing.com/search?q=%clipboard%
Return

RAlt & m::
If (!WinActive("ahk_class Emacs") and !WinActive("ahk_class mintty"))
{
    Send, ^c
    Sleep 50
}
Run, http://cn.bing.com/search?q=%clipboard%+site`%3Adeveloper.mozilla.org
Return

RAlt & o::
If (!WinActive("ahk_class Emacs") and !WinActive("ahk_class mintty"))
{
    Send, ^c
    Sleep 50
}
Run, http://cn.bing.com/search?q=%clipboard%+site`%3Astackoverflow.com
Return
