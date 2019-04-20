#If !WinActive("ahk_class Emacs") and !WinActive("ahk_class mintty") and !WinActive("ahk_exe XWin_MobaX.exe") and !WinActive("ahk_class MozillaWindowClass") and !WinActive("ahk_exe aces.exe") and !WinActive("ahk_exe KFGame.exe") and !WinActive("ahk_exe helldivers.exe")
#UseHook

; ===== C-* movements =====

^a::
SendInput, {Home}
return
^+a::
SendInput, +{Home}
return
>#a::
SendInput, ^a
return
^>#a::
SendInput, ^a
return
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
^>#e::
SendInput, ^e
return
+>#e::
SendInput, {RWin Down}e{RWin Up}
return

^f::
SendInput, {Right}
return
^+f::
SendInput, +{Right}
return
>#f::
SendInput, ^f
return
^>#f::
SendInput, ^f
return
+>#f::
SendInput, {RWin Down}f{RWin Up}
return

^d::
SendInput, {Left}
return
^+d::
SendInput, +{left}
return
>#d::
SendInput, ^d
return
^>#d::
SendInput, ^d
return
+>#d::
SendInput, {RWin Down}d{RWin Up}
return

^n::
SendInput, {Down}
return
>#n::
SendInput, ^n
return
^>#n::
SendInput, ^n
return
+>#n::
SendInput, {RWin Down}n{RWin Up}
return

^p::
SendInput, {Up}
return
>#p::
SendInput, ^p
return
^>#p::
SendInput, ^p
return
+>#p::
SendInput, {RWin Down}p{RWin Up}
return

^w::
SendInput, ^{Backspace}
return
>#w::
SendInput, ^w
return
^>#w::
SendInput, ^w
return
+>#w::
SendInput, {RWin Down}w{RWin Up}
return

^b::
SendInput, {Del}
return
; >#b:: >#b
^>#b::
SendInput, ^b
return
+>#b::
SendInput, {RWin Down}b{RWin Up}
return

^g::
SendInput, {Esc}
return
>#g::
SendInput, ^g
return
^>#g::
SendInput, ^g
return
+>#g::
SendInput, +^g
return

; ===== M-* movements =====

!f::
SendInput, ^{Right}
return
!>#f::
SendInput, !f
return

!d::
SendInput, ^{Left}
return
!>#d::
SendInput, !d
return

!b::
SendInput, ^{Del}
return
!>#b::
SendInput, !b
return

; ===== undo & redo =====

^/::
SendInput, ^z
return
^>#/::
SendInput, ^/
return

^+/::
SendInput, ^y
return
^+>#/::
SendInput, ^+/
return
