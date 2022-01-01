#If !WinActive("ahk_class Emacs") and !WinActive("ahk_class mintty") and !WinActive("ahk_exe aces.exe") and !WinActive("ahk_exe KFGame.exe") and !WinActive("ahk_exe helldivers.exe") and !WinActive("ahk_class R6Game") and !WinActive("ahk_class CryENGINE") and !WinActive("ahk_exe DeadByDaylight-Win64-Shipping.exe") and !WinActive("ahk_exe Cyberpunk2077.exe") and !WinActive("ahk_exe blender.exe") and !WinActive("ahk_class Respawn001")
#UseHook

; ===== C-* movements =====

^a::
SendInput, {Home}
return
^+a::
SendInput, +{Home}
return
<#a::
>#a::
SendInput, ^a
return
^<#a::
^>#a::
SendInput, ^a
return
+<#a::
+>#a::
SendInput, {RWin Down}a{RWin Up}
return

^e::
SendInput, {End}
return
^+e::
SendInput, +{End}
return
; >#e:: >#e
^<#e::
^>#e::
SendInput, ^e
return
+<#e::
+>#e::
SendInput, {RWin Down}e{RWin Up}
return

^f::
SendInput, {Right}
return
^+f::
SendInput, +{Right}
return

^d::
SendInput, {Left}
return
^+d::
SendInput, +{left}
return
<#d::
>#d::
SendInput, ^d
return
^<#d::
^>#d::
SendInput, ^d
return
+<#d::
+>#d::
SendInput, {RWin Down}d{RWin Up}
return

^n::
SendInput, {Down}
return
<#n::
>#n::
SendInput, ^n
return
^<#n::
^>#n::
SendInput, ^n
return
+<#n::
+>#n::
SendInput, {RWin Down}n{RWin Up}
return

^p::
SendInput, {Up}
return
<#p::
>#p::
SendInput, ^p
return
^<#p::
^>#p::
SendInput, ^p
return
+<#p::
+>#p::
SendInput, {RWin Down}p{RWin Up}
return

; ===== C-* non-movement operations =====

^w::
SendInput, ^{Backspace}
return
<#w::
>#w::
SendInput, ^w
return
^<#w::
^>#w::
SendInput, ^w
return
+<#w::
+>#w::
SendInput, {RWin Down}w{RWin Up}
return

^b::
SendInput, {Del}
return
; >#b:: >#b
^<#b::
^>#b::
SendInput, ^b
return
+<#b::
+>#b::
SendInput, {RWin Down}b{RWin Up}
return

^g::
SendInput, {Esc}
return
<#g::
>#g::
SendInput, ^g
return
^<#g::
^>#g::
SendInput, ^g
return
+<#g::
+>#g::
SendInput, +^g
return

^s::
SendInput, ^f
return
^<#s::
^>#s::
SendInput, ^s
return

; ===== M-* movements =====

!f::
SendInput, ^{Right}
return
!<#f::
!>#f::
SendInput, !f
return

!d::
SendInput, ^{Left}
return
!<#d::
!>#d::
SendInput, !d
return

!b::
SendInput, ^{Del}
return
!<#b::
!>#b::
SendInput, !b
return

; ===== undo & redo =====

^/::
SendInput, ^z
return
^<#/::
^>#/::
SendInput, ^/
return

^+/::
SendInput, ^y
return
^+<#/::
^+>#/::
SendInput, ^+/
return
