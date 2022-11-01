#If !WinActive("ahk_class Emacs") and !WinActive("ahk_class mintty") and !WinActive("ahk_exe aces.exe") and !WinActive("ahk_exe KFGame.exe") and !WinActive("ahk_exe helldivers.exe") and !WinActive("ahk_class R6Game") and !WinActive("ahk_class CryENGINE") and !WinActive("ahk_exe DeadByDaylight-Win64-Shipping.exe") and !WinActive("ahk_exe Cyberpunk2077.exe") and !WinActive("ahk_exe blender.exe") and !WinActive("ahk_class Respawn001")
+!#e::
WinActivate, ahk_exe XWin_MobaX.exe
return
+!#f::
WinActivate, ahk_exe chrome.exe
return
+!#t::
WinActivate, ahk_class mintty
return
+!#a::
WinActivate, ahk_class EVERYTHING
return
+!#q::
WinActivate, ahk_class CommunicatorMainWindowClass
return

+!#Space::
if WinActive("ahk_exe XWin_MobaX.exe")
  WinActivate, ahk_exe chrome.exe
else
  WinActivate, ahk_exe XWin_MobaX.exe
return

g_window_n := 0
g_window_m := 0

*+!#n::
GetKeyState, state, LCtrl
if state = D
  g_window_n := WinExist("A")
else
  if WinExist("ahk_id " . g_window_n)
  WinActivate
return

*+!#m::
GetKeyState, state, LCtrl
if state = D
  g_window_m := WinExist("A")
else
  if WinExist("ahk_id " . g_window_m)
  WinActivate
return
