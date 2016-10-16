; http://superuser.com/a/527542
g_LastShiftKeyDownTime := 0
g_AbortSendParen := false
g_ShiftRepeatDetected := false

*LShift::
    if (g_ShiftRepeatDetected)
    {
        return
    }

    send,{LShift down}
    g_LastShiftKeyDownTime := A_TickCount
    g_AbortSendParen := false
    g_ShiftRepeatDetected := true

    return

*LShift Up::
    send,{LShift up}
    g_ShiftRepeatDetected := false
    if (g_AbortSendParen)
    {
        return
    }
    current_time := A_TickCount
    time_elapsed := current_time - g_LastShiftKeyDownTime
    if (time_elapsed <= 250)
    {
        SendInput {(}
    }
    return

~*+a::
    g_AbortSendParen := true
    return
~*+b::
    g_AbortSendParen := true
    return
~*+c::
    g_AbortSendParen := true
    return
~*+d::
    g_AbortSendParen := true
    return
~*+e::
    g_AbortSendParen := true
    return
~*+f::
    g_AbortSendParen := true
    return
~*+g::
    g_AbortSendParen := true
    return
~*+h::
    g_AbortSendParen := true
    return
~*+i::
    g_AbortSendParen := true
    return
~*+j::
    g_AbortSendParen := true
    return
~*+k::
    g_AbortSendParen := true
    return
~*+l::
    g_AbortSendParen := true
    return
~*+m::
    g_AbortSendParen := true
    return
~*+n::
    g_AbortSendParen := true
    return
~*+o::
    g_AbortSendParen := true
    return
~*+p::
    g_AbortSendParen := true
    return
~*+q::
    g_AbortSendParen := true
    return
~*+r::
    g_AbortSendParen := true
    return
~*+s::
    g_AbortSendParen := true
    return
~*+t::
    g_AbortSendParen := true
    return
~*+u::
    g_AbortSendParen := true
    return
~*+v::
    g_AbortSendParen := true
    return
~*+w::
    g_AbortSendParen := true
    return
~*+x::
    g_AbortSendParen := true
    return
~*+y::
    g_AbortSendParen := true
    return
~*+z::
    g_AbortSendParen := true
    return

~*+[::
    g_AbortSendParen := true
    return
~*+]::
    g_AbortSendParen := true
    return
~*+;::
    g_AbortSendParen := true
    return
~*+'::
    g_AbortSendParen := true
    return
~*+,::
    g_AbortSendParen := true
    return
~*+.::
    g_AbortSendParen := true
    return
~*+/::
    g_AbortSendParen := true
    return
~*+1::
    g_AbortSendParen := true
    return
~*+2::
    g_AbortSendParen := true
    return
~*+3::
    g_AbortSendParen := true
    return
~*+4::
    g_AbortSendParen := true
    return
~*+5::
    g_AbortSendParen := true
    return
~*+6::
    g_AbortSendParen := true
    return
~*+7::
    g_AbortSendParen := true
    return
~*+8::
    g_AbortSendParen := true
    return
~*+9::
    g_AbortSendParen := true
    return
~*+0::
    g_AbortSendParen := true
    return
~*+-::
    g_AbortSendParen := true
    return
~*++::
    g_AbortSendParen := true
    return
~*+\::
    g_AbortSendParen := true
    return
~*+`::
    g_AbortSendParen := true
    return
