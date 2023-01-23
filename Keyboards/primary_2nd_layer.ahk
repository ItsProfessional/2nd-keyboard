;____________________________________________________________________
;                                                                    
;		  2ND LAYER OF PRIMARY KEYBOARD USING CAPSLOCK AS WRAPPING KEY (Corsair K95)  
;____________________________________________________________________

; Secondary layer of main keyboard, using CAPSLOCK remapped to F20.
; UPDATE: I decided not to do this, at least for now. I currently use the capslock key to enable/disable clips on Premiere's timeline.
#if (getKeyState("F20", "P"))
F20::return 

escape::msgbox,,, you pressed escape. this might cause like problems maybe, 0.9
F1::send ^+{pgup}
F2::send ^+{pgdn} ;for firefox tab moving
F3::
F4::
F5::
F6::
F7::
F9::
F8::
F10::
F11::
F12::return

`::tooltip, llllll
1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
-::
=::
backspace::return

tab::msgbox,,,within F20 - you pressed tab. :P,0.8

q::
w::
e::
r::
t::
y::
u::
i::
o::
p::
[::
]::
\::return
capslock::msgbox, , ,you should not ever see this text, 1000

a::tooltip,fancy A
s::tooltip,fancy S
d::tooltip,fancy D
f::
g::
h::
j::
k::
l::
`;::
'::

Lshift::return
z::
x::
c::
v::
b::return
n::
m::
,::
.::
/::return
Lwin::msgbox, LEFT win
Lalt::msgbox, LEFT alt
space::tooltip,
Ralt::msgbox, Ralt - doesnt work
Rwin::msgbox, Right Win 
Rshift::msgbox RIGHT SHIFT lol

Rctrl::msgbox,,,Rctrlll,0.5
appskey::msgbox, this is the appskey KEY I guess

;these were all formerly runExplorer()
PrintScreen::
ScrollLock::return
SC061::msgbox, scancode061
CtrlBreak::msgbox, CTRL BREAK?
pause::msgbox, is this the PAUSE key?? IDK
Break::msgbox, Maybe THIS is the pause/break key???

pgdn::
end::
delete::
pgup::
home::
insert::

up::
down::
left::
right::

numpad0::
numpad1::
numpad2::
numpad3::
numpad4::
numpad5::
numpad6::
numpad7::
numpad8::
numpad9::

+numlock::
numlock::
numpadDiv::
numpadMult::
numpadSub::
numpadAdd::
numpadEnter::return
numpadDot::

#if				
;_________________end fake 5th keyboard with capslock remapped to F20__________________