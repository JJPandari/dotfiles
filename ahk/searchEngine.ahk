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
