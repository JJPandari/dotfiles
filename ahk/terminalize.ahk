#If !WinActive("ahk_class Emacs") and !WinActive("ahk_class mintty")
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

^b::
SendInput, {Left}
return
^>#b::
SendInput, ^b
return
^+b::
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
