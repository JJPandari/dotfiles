#If !WinActive("ahk_class Emacs") and !WinActive("ahk_class mintty") and !WinActive("ahk_class MozillaWindowClass")
#UseHook

^a::
SendInput, {Home}
return
^>#a::
SendInput, ^a
return
^+a::
SendInput, +{Home}
return

^e::
SendInput, {End}
return
^>#e::
SendInput, ^e
return
^+e::
SendInput, +{End}
return

^f::
SendInput, {Right}
return
^>#f::
SendInput, ^f
return
^+f::
SendInput, +{Right}
return

^d::
SendInput, {Left}
return
^>#d::
SendInput, ^d
return
^+d::
SendInput, +{left}
return

^n::
SendInput, {Down}
return
^>#n::
SendInput, ^n
return

^p::
SendInput, {Up}
return
^>#p::
SendInput, ^p
return

^w::
SendInput, ^{Backspace}
return
^>#w::
SendInput, ^w
return

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
