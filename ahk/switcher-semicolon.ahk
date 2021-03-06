g_window_z := 0
g_window_x := 0
g_is_combination := false

`; Up::
if (!g_is_combination)
{
    SendInput, `;
}
g_is_combination := false
return

`;::
g_is_combination := false
return

~*^`;::
return

~*!`;::
return

~*+`;::
return

`; & e::
g_is_combination := true
WinActivate, ahk_class Emacs
return
`; & c::
g_is_combination := true
WinActivate, ahk_exe chrome.exe
return
`; & f::
g_is_combination := true
WinActivate, ahk_class MozillaWindowClass
return
`; & t::
g_is_combination := true
WinActivate, ahk_class mintty
return
`; & a::
g_is_combination := true
WinActivate, ahk_class EVERYTHING
return
`; & d::
g_is_combination := true
WinActivate, ahk_exe BingDict.exe
return
`; & v::
g_is_combination := true
WinActivate, ahk_exe code.exe
return
`; & r::
g_is_combination := true
WinActivate, ahk_exe Robomongo.exe
return

`; & z::
GetKeyState, state, LCtrl
if state = D
  g_window_z := WinExist("A")
else
  if WinExist("ahk_id " . g_window_z)
  WinActivate
return

`; & x::
GetKeyState, state, LCtrl
if state = D
  g_window_x := WinExist("A")
else
  if WinExist("ahk_id " . g_window_x)
  WinActivate
return

`; & Tab::
g_is_combination := true
WinGet, ActiveEXE, ProcessName, A
WinGet, List, List, ahk_exe %ActiveEXE%
IF List = 1
  return
Else
{
  WinActivate, % "ahk_id " . List%List%
  return
}
