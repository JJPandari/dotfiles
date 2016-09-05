g_window_z := 0
g_window_x := 0

RAlt & e::
WinActivate, ahk_class Emacs
return
RAlt & c::
WinActivate, ahk_class Chrome_WidgetWin_1
return
RAlt & t::
WinActivate, ahk_class mintty
return
RAlt & a::
WinActivate, ahk_class EVERYTHING
return
RAlt & d::
WinActivate, ahk_exe BingDict.exe
return

RAlt & z::
GetKeyState, state, LCtrl
if state = D
g_window_z := WinExist("A")
else
if WinExist("ahk_id" . g_window_z)
WinActivate
return

RAlt & x::
GetKeyState, state, LCtrl
if state = D
  g_window_x := WinExist("A")
else
  if WinExist("ahk_id" . g_window_x)
  WinActivate
return
