SetWorkingDir, C:\AHK\2nd-keyboard\support_files
; SetNumLockState, on
; SetScrollLockState, off

Menu, Tray, Icon, shell32.dll, 283 ; Keyboard tray icon


; Macro key G14
; global savedCLASS = "ahk_class Notepad++"
; global savedEXE = "notepad++.exe" 
global savedCLASS = "ahk_class Chrome_WidgetWin_1"
global savedEXE = "Teams.exe" ; Before the #includes is the only place these can go

;psApp := ComObjActive("Photoshop.Application")

; #include means the end of the autoexecute section
; gui.ahk must be imported first
#Include C:\AHK\2nd-keyboard\gui.ahk 
#include C:\AHK\2nd-keyboard\Almost_All_Premiere_Functions.ahk
#include C:\AHK\2nd-keyboard\Almost_All_Windows_Functions.ahk
#include C:\AHK\2nd-keyboard\After_Effects_Functions.ahk
#include C:\AHK\2nd-keyboard\Photoshop_Functions.ahk

SetKeyDelay, -1


#NoEnv
SendMode Input
#InstallKeybdHook
#InstallMouseHook
#UseHook On

#SingleInstance Force
#MaxHotkeysPerInterval 2000
#WinActivateForce ; Prevent taskbar flashing.
#HotkeyModifierTimeout 60
#MaxThreadsPerHotkey 1
#KeyHistory 500 ; Useful for debugging

DetectHiddenWindows, On|Off, on
SetNumLockState, AlwaysOn

; Avoid sending LCtrl when alt is released: https://autohotkey.com/boards/viewtopic.php?f=76&t=57683
#MenuMaskKey vk07 ; vk07 is unassigned. https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=0

; Sent from streamdeck
; Copy 1, 2, 3
SC062::ClipBoard_1 := GetFromClipboard() ;zoom
vk2A::ClipBoard_2 := GetFromClipboard()	 ;Printer
SC16B::ClipBoard_3 := GetFromClipboard() ;launch (0)

; Paste 1, 2, 3
;I might have to use proper functions to get these to type faster
SC16D::SendInput {Raw}%ClipBoard_1%		;launch_media
vk2B::SendInput {Raw}%ClipBoard_2%		;Execute
SC121::SendInput %ClipBoard_3% 	;launch (1)

currentTool = "v"

; Pause/break, for debugging
^sc045::
+sc045::
!sc045::
sc045::
tooltip, Pause/break
Sleep 100
tooltip,
KeyHistory
return 

#include "Keyboards/2nd_keyboard.ahk"
; #include "Keyboards/jelly_numpad.ahk" ; Replace with streamdeck
#include "Keyboards/primary_2nd_layer.ahk"
#include "Keyboards/3rd_keyboard.ahk"
; Note: normal keyboard assignments (from the primary keyboard, a.k.a no wrapping key) must be below the other keyboards. Otherwise, both the normal hotkeys and 2nd keyboard hotkeys will be called, which is problematic.




; Function keys in programs


; Firefox
#IfWinActive ahk_class MozillaWindowClass
!F1::Send ^+{pgup} ; Move tab left
!F2::Send ^+{pgdn} ; Move tab right
; F2 & f20::Send ^+{pgdn}

F2::Send ^{tab} ; Switch to next tab
F1::Send ^+{tab} ; Switch to previous tab

F3::Send ^w Close tab
F4::Send {MButton} ; Open link in new tab

; For APMmusic.ca surfing
PgDn::Send ^{tab} ; Switch to next tab
End::Send ^+{tab} ; Switch to previous tab
PgUp::Send ^w ; Close tab

F18::up ; Macro key G8, labeled as horizontal anchor.
F15::down ; Macro key G11, labeled as vertical anchor

F17::enter ; Macro key G9, labeled as rotation
;idk if this is the corect assignment now that i moved keys.
;also i dont remember why i did that

; For APMmusic.ca
F15::Lbutton ; Macro key G11

; Macro key G12
F14::Send, {F11} ; Fullscreen


; Chrome
#IfWinActive ahk_class Chrome_WidgetWin_1
F2::Send ^{tab} ; Switch to next tab 
F1::Send ^+{tab} ; Switch to previous tab 
F3::Send ^w ; Close tab
F4::Send {MButton} ; Open link in new tab

F14::Send, {F11}

; For APMmusic.ca surfing.
F18::up ; Macro key G8, labeled as horizontal anchor.
F15::down ; Macro key G11, labeled as vertical anchor


; For APMmusic.ca
F15::Lbutton ; Macro key G11

; Macro key G12
F14::Send, {F11} ; Fullscreen


; After Effects
#IfWinActive ahk_exe AfterFX.exe
F1::twirlAE(1)
F2::twirlAE(0)

#IfWinActive ahk_exe notepad++.exe
F2::Send ^{tab} ; Switch to next tab 
F1::Send ^+{tab} ; Switch to previous tab 
F3::Send ^w 
F4::F2
#IfWinActive


 ; Screenshots
scrolllock::+printscreen ; ShareX Copy region to clipboard

^scrolllock::
+scrolllock::scrolllock ; Send scrolllock normally



; Explorer shortcuts

#IfWinActive ahk_class Progman ; Desktop
!F4::return ; No Alt+F4 shutdown dialog on desktop


#IfWinActive, ahk_group ExplorerGroup ; Explorer
^+!d::
Sleep 10
SendInput !d
Sleep 10
return

; No need, "ahk_class #32770" added to ExplorerGroup
; #if WinActive("ahk_class #32770") and WinActive("ahk_exe firefox.exe") ; Save/load dialog in Firefox
; `::Send !{up} ; Up one folder
; ~left & right::Send, {LCtrl down}{NumpadAdd}{LCtrl up} ; Expand name field
; Media_Next::Send, {LCtrl down}{NumpadAdd}{LCtrl up} ; Expand name field
; F6::RemoveDashes() ;when saving Audioblocks sound effects, because filenames with dashes or underscores in them cannot be searched for in Windows' file system, which is also stupid. So this makes it so  that i don't have to manaully remove those or retype the filenames.

; #if WinActive("ahk_class #32770") and WinActive("ahk_exe 4kvideodownloader.exe") 
; `::Send !{up} ; Up one folder
; ~left & right::Send, {LCtrl down}{NumpadAdd}{LCtrl up} ; Expand name field
; Media_Next::Send, {LCtrl down}{NumpadAdd}{LCtrl up} ; Expand name field

; #if WinActive("ahk_class #32770") and WinActive("ahk_exe WINWORD.exe")
; `::Send !{up} ; Up one folder
; ~left & right::Send, {LCtrl down}{NumpadAdd}{LCtrl up} ; Expand name field
; Media_Next::Send, {LCtrl down}{NumpadAdd}{LCtrl up} ; Expand name field

; #if WinActive("ahk_class #32770") and WinActive("ahk_exe chrome.exe") ; Save/load dialog in Chrome
; `::Send !{up} ; Up one folder

; #if WinActive("ahk_class #32770") and WinActive("ahk_exe ShareX.exe") ; ShareX save/load dialog
; `::SendInput, !{up} ; Up one folder

; ; #IfWinActive, ahk_class #32770 ahk_exe Adobe Premiere Pro.exe ; Premiere's save/load dialog OR Export Settings
; #if WinActive("ahk_class #32770") and WinActive("ahk_exe Adobe Premiere Pro.exe") and WinActive("Save Project") ; Premiere's Save Project dialog, not Export Settings
; `::SendInput, !{up} ; Up one folder

; #if WinActive("ahk_class #32770") and WinActive("ahk_exe Adobe Premiere Pro.exe") and WinActive("Save As") ; Premiere's Save As dialog, not Export Settings
; `::Send !{up} ; Up one folder
; ~Left & Right::Send, {LCtrl down}{NumpadAdd}{LCtrl up} ; Expand name field
; Home::Send {alt}vo{down}{enter} ; Sort by date modified
; #if 

F1::switchToFirefox()

; F2:: ; Rename (Built in)

F3:: ; Close explorer
Send {alt down}
Sleep 10
Send {F4}
Sleep 10
Send {alt up}
Return
; There is a deliberate delay added, since in SOME situations, ALT would be recognised, but not F4. Adding a delay takes care of that.

; F3 by default: "Search for a file or folder in File Explorer"
; F4:: Highlight address bar (Built in)
; F5:: Refresh (Built in)
F6::RemoveDashes() ; In explorer, by default, F6 is "Cycle through screen elements in a window or on the desktop". Useless, since Tab already does that
; F7 is free
; F8 is free
; F9 is free
F10::return ; Activates the Menu bar in the active app. This is the same as Alt menu acceleration, disabled.
F11::return ; Fullscreen, disabled
; F12 is free

`:: ; Up one folder
SendInput, {alt Down}
Sleep, Delay 5
SendInput, {up}
Sleep, Delay 5
SendInput, {alt Up} 
return

+`::Send !{left} ; Back

~left & right::Send, {LCtrl down}{NumpadAdd}{LCtrl up} ; Expand name field
Media_Next::Send, {LCtrl down}{NumpadAdd}{LCtrl up} ; Expand name field

Home::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	ExplorerViewChange_Window(exphWnd) ; List mode
return

End::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	ExplorerViewChange_ICONS(exphWnd) ; Icon mode
return


PgUp::
sortByName() ; Does not work both ways
Send, {LCtrl down}{NumpadAdd}{LCtrl up} ; Expand name field
return

PgDn::sortByDate()
#IfWinActive



; All programs

; ^!+f::Run, %comspec% /c "taskkill.exe /F /IM firefox.exe",, hide ; Force close firefox, without warnings dialogs
; ^!+p::Run, %comspec% /c "taskkill.exe /IM /Adobe Premiere Pro.exe /T /F",, hide ; Force close premiere, without warnings dialogs

; Function hotkeys paired with control

SC064::back() ; Macro key G13 -> F13 (= SC064)
; Scan code is more reliable, probably because F13 is used already


^F1::switchToFirefox() ; Macro key G16
+^F1::switchToOtherFirefoxWindow()

^F2::switchToExplorer() ; Macro key G17

!^F2::closeAllExplorers()

^F3::switchToPremiere() ; Macro key G18
+^F3::Send, {F12} ; Fullscreen

^F4::switchToWord() ; Macro key G15
;^F4::switchToWordPad()
;^F4::switchToSumatraPDF()

+^F4::switchWordWindow() ; AKA, ^+F4 ^+{F4}

;No K95 macro key assigned
^F5::switchToChrome()
+^F5::switchToOtherChromeWindow() ; Note, chrome works weirdly when the function uses ^Tab to switch tabs, probably should switch hotkey to !F5

^F6::windowSwitcher(savedCLASS, savedEXE) ; Macro key G14

+^F6::
windowSaver()
MsgBox,,, savedCLASS = %savedCLASS% `nsavedEXE = %savedEXE%, 0.6
Return

;^F7 is Everything search.

;No K95 macro key assigned
; ^F8::windowSwitcher("ahk_exe AfterFX.exe","C:\Program Files\Adobe\Adobe After Effects CC 2017\Support Files\AfterFX.exe") ;NOTE: was used for toggle all video tracks in premiere.

; ^F9 is free
; ^F10::windowSwitcher("ahk_exe StreamDeck.exe","C:\Program Files\Elgato\StreamDeck\StreamDeck.exe")
; ^F11 used by filemover.ahk
; ^F12 used by filemover.ahk













; Function hotkeys

#z::
Send #b{left}{left}{enter} ; Clock/calendar
Return

; Joy1 is free
; Joy2 is free
; Joy3 is free
; Xbutton1 is free outside Premiere
; Xbutton2 is free outside Premiere



F21 & F1::search() ; Macro key G1 on K95

; TODO: Note that i have other premiere extended function key assignments somewhere around line 2090. Yeah it's a bit of a mess.
	
F21 & F2:: ; Macro key G2 on K95
KeyWait, %A_priorhotkey% ;avoid stuck modifiers
IfWinActive, ahk_exe Adobe Premiere Pro.exe
{
	easeInAndOut()
}
else IfWinActive, ahk_exe AfterFX.exe
{
	sendinput, {F9} ;F9 is 'ease in and out' in after effects.
}
else
{
	; F21 & F2 (Macro key G2) is free outside Premiere
}
return


;~^+K::preset("Warp Stabilizer Preset") ; Macro key G2 used to be the stabilizer preset.
;~^+=::effectsPanelType("presets") ;Used to be Macro key G3. ;I have canceled this one in favor of a global pause/play. 

F21 & F3::stopPlaying() ; Macro key G3 on the K95
; Outside of premiere, it will STILL work to pause/play the timeline, due to some other code somewhere else...

#ifWinNotActive ahk_exe Adobe Premiere Pro.exe

;F21 & F4 (Macro key G4) is free outside Premiere
;F21 & F5 (Macro key G5) is free outside Premiere


; For APMmusic.ca
;F21 & F6::Lbutton ; Macro key G6

#IfWinActive ahk_exe chrome.exe
F19::SendInput, !+5 ; Strikethrough (Google Docs) ; Macro key G10

; For YouTube
Media_Next::+.
Media_Play_Pause::k
Media_Prev::+,

#ifWinActive ahk_exe firefox.exe
;!x::!+x ; Nuke Anything Enhanced
F19::SendInput, !+5 ; Strikethrough (Google Docs) ; Macro key G10

; For YouTube
Media_Next::+.
Media_Play_Pause::k
Media_Prev::+,

#IfWinActive ahk_exe vivaldi.exe
; For YouTube
Media_Next::+.
Media_Play_Pause::k
Media_Prev::+,

#IfWinActive ahk_exe msedge.exe
; For YouTube
Media_Next::+.
Media_Play_Pause::k
Media_Prev::+,

#IfWinActive ahk_exe winword.exe
~F14::F2 ; Go to previous comment
;;;;NEW assignment: Macro key G6, currently labeled "reselect."
;;;;F21 & F6::F2 ;F2 is set to "go to previous comment" in Word.
F18::^k ; Strikethrough


#IfWinActive ahk_exe winword.exe
F11:: ; Open URLs. Default Word URL handling is bad

; Deselect text
SendInput, {escape}
Sleep 10
SendInput, {left}
Sleep 10

Send, ^{Click} ; Make sure caret is on the URL, using ctrl to click on it without opening the URL (Note: you have to change settings so that ctrl is not needed to open links)
Sleep 10

Send, {F8} ; Extend mode. https://www.zdnet.com/pictures/six-clicks-microsoft-word-tricks-to-make-you-an-instant-expert/4/
Sleep 10
Send, {F8} ; Pressing F8 twice highlights the word with the caret
Sleep 10
Send, {F8} ; Pressing F8 thrice highlights the sentence, the URL
Sleep 10

Send ^c ; Copy to clipboard

Sleep 20
Send ^r ; Change text to Red (needs to be configured in settings). This is done to not make the link have a purple color
; Options > Customize Ribbon, Keyboard shortcuts:custom, select "all commands", find "color" and then choose color: red

Sleep 20
Send, {escape} ; Disable extend mode (without deselecting)
Sleep 10
switchToChrome() ; switchToFirefox()

SendInput, Keys, ^t ; New tab
Sleep 30

SendInput, ^l ; Select address bar
Sleep 30

SendInput, ^v ; Paste

SendInput, {enter} ; Open pasted URL
return




#IfWinActive ahk_exe winword.exe
F12:: ; Put Word comment into a lengthend marker in Premiere

BlockInput, On
BlockInput, SendandMouse
SendInput, ^a ; Select all
Sleep 80
SendInput, ^c ; Copy to clipboard
Sleep 15
WinActivate ahk_class Premiere Pro
Sleep 20
prFocus("timeline")
Sleep 30

; Unstick modifiers
Send, {LCtrl up}
Send, {RCtrl up}
Send, {RAlt up}
Send, {RAlt up}
Send, {LShift up}
Send, {RShift up}
Sleep 10

Send, ^!d ; Deselect all clips on timeline
Sleep 20

Send, ^!+k ; Shuttle stop
Sleep 30

Send, ^!+k ; Shuttle stop (sometimes it doesn't register when pressed once)
Sleep 20

Send, ^` ; Add marker
Sleep 10

Send, ^!+k ; Shuttle stop
Sleep 10

Send, ^` ; Open the comment
Sleep 50

Send, {left}
Send, ^v ; Paste into marker title

Sleep 10
Send, ^!+k ; Shuttle stop

Send, +{tab} ; Highlight the "duration" field
Sleep 10

Send, 00:00:04:00
Sleep 10

Send, ^!+k ; Shuttle stop
Sleep 10

; Unstick modifiers
Send, {LCtrl up}
Send, {RCtrl up}
Send, {RAlt up}
Send, {RAlt up}
Send, {LShift up}
Send, {RShift up}
Sleep 10

Send, {Enter}
Sleep 10
Send, ^!+k ; Shuttle stop
Sleep 1

BlockInput, MouseMoveOff
BlockInput, Off
return

#IfWinActive




; Premiere hotkeys




#IfWinActive ahk_exe Adobe Premiere Pro.exe
appskey::SendInput, ^!k ; Clear selected markers ;; Note: Assigning it to appskey directly in Premiere would trigger windows Alt menu acceleration

;^w::closeTitler()

; Note: Assigning the below keys to Alt+W/Q directly in Premiere would trigger windows Alt menu acceleration
!w::^!+w ; Trim Next Edit to Playhead
!q::^!+q ; Trim Previous Edit to Playhead

!f::return
!e::return
!c::return
!s::return
!m::return
!g::return
!v::SendInput, ^!+v ; Paste on highest enabled track (Excalibur)
!h::return

^+r::Send ^r{tab}{tab}{space}{enter} ; Reverse selected clip

; No longer used
; ^g::Send ^r200{Enter} ; Make 200% speed
; ^h::Send ^r50{Enter} ; Make 50% speed


; !space:: ; This prevents excalibur from working, since it uses !space ;; Use tilde (~) notation to make it show in keystroke visualizer, but this notation may cause cross-talk
RWin:: ; Stop, rewind 3 seconds, play. Premiere's implemention is bad since it brings you back to where you started
Send s ; Shuttle stop
Send +{left} ; Step back many frames (Configure to 10 in settings)
Send +{left}
Send +{left}
Sleep 10
Send d ; Shuttle right
return



; Premiere function hotkeys



#IfWinActive ahk_exe Adobe Premiere Pro.exe
F1:: ; Ripple delete clip at playhead
Send ^!s ; Select clip at playhead
Sleep 1
Send ^+!d ; Ripple delete
Sleep 1
return

;F2 is set in premiere to the [GAIN] panel
;F3 is set in premiere to the [MODIFY CLIP] panel

; Note: note to self, move this to premiere_functions already
; Note: this is NOT suposed to stop the video playing when you use it, but now it does for some reason....
F4:: ; Instant cut at cursor (on key release)
Send, b ; Razor tool
Send, {Shift down} ; Modify all unlocked tracks modifier for razor tool
KeyWait, F4 ; Waits for the key to go up
Send, {LButton} ; Apply cut
Send, {Shift up}
Sleep 10
Send, v ; Selection tool
return

F5::clickTransformIcon2()
F6::cropClick()

;F7:: is export frame (to .png)
;F8:: is also export frame (to .png)

F9:: ; Delete clip at cursor
prFocus("timeline") ; Focus the timeline
Send, ^!d ; Deselect clips
Send, v ; Selection tool
Send, {Alt down}
Send, {LButton}
Send, {Alt up}
Send, c ; Clear
return

; F10 is free
F10::return ; Note: F10 will induce menu acceleration if not assigned to anything, thus assigned to return for the time being

;F11 is Toggle Full Screen
;F12 is Enable Transmit. This displays a copy of the program monitor onto another, even more accurate monitor




; Premiere EXTENDED function hotkeys



; F13 ; Macro key G13, "back" in windows mods script

~F14:: ; Note: If you are experiencing cross-talk, try `~VK7DSC065`, instead of `~F14`
global VFXkey = "F14"
instantVFX("scale")
return

~F15:: ; Macro key G11
global VFXkey = "F15"
instantVFX("anchor_point_vertical")
return

;F16 is free

~F17:: ; Macro key G7
global VFXkey = "F17"
instantVFX("rotation")
return

~F18:: ; Macro key G8
global VFXkey = "F18"
instantVFX("anchor_point")
return

~F19::tracklocker() ; Macro key G7
~+F19::tracklocker()

F20::Home ; Disable (clip) ;; Note: In iCue, CapsLock is remapped to F20

; End is free
; F21 is used as a function key (on all windows). This is to avoid the stuck modifiers bug associated with pairing keystrokes with CTRL, SHIFT, and/or ALT (cross-talk)




; After Effects EXTENDED function hotkeys





#IfWinActive ahk_exe AfterFX.exe

F14::Send, +s ; Add scale parameter
F15::Send, +a ; Vertical anchor
F18::Send, +p ; Horizontal anchor
F17::Send +r

; Macro key G7
F19::SendInput, ^{up} ; Select previous layer

; Macro key G10
F21 & F9::SendInput, ^{down} ; Select next layer


; F21 combinations


#ifWinActive ahk_exe Adobe Premiere Pro.exe

; TODO: Note that i have other premiere extended function key assignments somewhere around line 2090. Yeah it's a bit of a mess.

F21::return

;^+,:: ; Note: If using the hotkey on this line, then you must add "Sleep 11" at the beginning of the hotkey (unless you also remove the 10ms delay inside of iCue). Otherwise, cross-talk (stuck modifiers) will occur
F21 & F4:: ; Macro key G4
; Sleep 11
; audioMonoMaker("left") ; No longer works as well anymore
preset("90 IRE") ; preset("50%")
return

;^+.:: ; Note: If using the hotkey on this line, then you must add "Sleep 11" at the beginning of the hotkey (unless you also remove the 10ms delay inside of iCue). Otherwise, cross-talk (stuck modifiers) will occur
F21 & F5:: ; Macro key G5
; Sleep 11
; audioMonoMaker("right"); No longer works as well anymore
preset("50%") ; TBD. Temporary assignment until I can get a better thing for this key
return

; Macro key G6
F21 & F6::
; Sleep 11 
SendInput, ^+U ; Super purple
; reSelect() ; TBD. Commented out because the function has (maybe) stopped working
return

F21 & F1:: ; Macro key G1
; Sleep 11
search()
return


F21 & F9:: ; Macro key G10
; Sleep 11
preset("a0p0 pan down")
; Send {F2}7{Enter} ; Adds 7 gain
return

;F22... is free?

;F23 is the K120 keyboard
;F24 is the Azio macro keyboard











~^e:: ; Remind to create a EDL when exporting (to submit to APMmusic.ca)
SetTitleMatchMode Slow
WinGetTitle, title, A
itsLTT := InStr(title, "1. Linus Tech Tips")
itsTL := InStr(title, "2. Tech Linked")
if (itsLTT or itsTL)
{
	TrayTip, Make an EDL, Hey did you export an EDL yet, 2, 32 ;THIS IS THE NOTIFICAITON
}
return


Xbutton1:: ; Cut single clip at cursor

; For EasyWindowDrag_(KDE).ahk. If not using it, delete the 3 lines below
tellme := isPremiereUnderCursor(yesno)
if (tellme = 0)
	return

Send, ^!d ; Deselect clips
Send, b ; Razor tool

Send, {Alt down}
KeyWait, %A_thishotkey% ; Wait for key to be released
Send, {LButton}
Send, {Alt up}
Sleep 10
Send, %currentTool%
return




Xbutton2:: ; Disable single clip at cursor

; If you are not using EasyWindowDrag_(KDE).ahk then you can delete the 3 lines below

tellme := isPremiereUnderCursor(yesno) ; When hitting the button with Premiere active, and hovering over another program, it will send keystrokes to the hovered program. Hence, we return if premiere is not being hovered
if (tellme = 0)
	return
	
; For compatibility with EasyWindowDrag_(KDE).ahk
; MouseGetPos,,,KDE_id
; WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
; ; If KDE_Win
;     ; return ;I am not sure exactly what this is for
; WinGetClass,fancyclass,ahk_id %KDE_id%
; If (fancyclass != "Premiere Pro")
; {
; 	WinActivate, ahk_id %KDE_id%
; 	goto skipitAMKA
; }


Send, ^!d ; Deselect clips
Send, v ; Selection tool
Send, {Alt down}
Send, {LButton}
Send, {Alt up}

Send, {Home} ; Disable

Sleep 10

Send, %currentTool%

; skipitAMKA:
return




; CURRENT TOOL REMEMBERER
~v::
~t::
~r::
~y::
~b::
~x::
~h::
~p::
currentTool = %A_thishotkey%
return



; Premiere Media hotkeys

Media_Stop:: ; Instant audio and video re-linker
; Note: Everything must be unlinked for it to work? and "Linked selection" must be enabled on top right of the timeline for it to have any effect
Send, {down} ; Go to next edit point
Sleep 10
Send, u ; Select clip at playhead
Sleep 10
Send, 0 ; Link
Sleep 10
return


; Label colors
Media_Prev::^numpad7 ; Select label group
Media_Play_Pause::^numpad9 ; Super green color
Media_Next::^numpadMult ; Magenta color

;Volume_Mute::^numpadDiv









; Photoshop hotkeys





#if WinActive("ahk_exe Photoshop.exe")

^j::PhotoshopExport() ; (as jpeg)

F2::SendInput, ^{tab} ; Switch to next tab
F1::SendInput, ^+{tab} ; Switch to previous tab
F3::SendInput, ^o ; Ctrl+W is used for duplicating layers, cannot use here

;F4:: Show pixel grid (Built in)

F5:: ; Super rasterize layers
SendInput, {F5} ; Rasterize > Layer
Sleep 1
SendInput, ^!+{F5} ; Rasterize > Layer style
Sleep 10
SendInput, ^!k ; Layer Mask > Apply
return

;F6:: convert to sRGB
;F7:: convert to LAB
;F8:: is now My MAKE VECTOR MASK(/layer mask?) ACTION. (The default is the Info window.)

;F9:: is  "convert to smart object" shortcut... not an action.

;F10:: is now SAVE AS JPEG

;F11:: is EXPAND SELECTION by 1
;+F11 should make CONTRACT SELECTION by 1

; F12:: is 200% nearest
; ^F12 is 300% Nearest
; +F12 is 50% bicubic sharper?
; ^+F12 is 50% Nearest? Maybe switch with the previous one.


; Macro key G12
F14:: ; Photoshop brush resize
SendInput {LAlt down}
SendInput {RButton down}
Sleep 1
KeyWait, F14 ; Wait for F14 to be released
Sleep 1
SendInput {RButton up}
SendInput {LAlt up}
return

; I think i need to use COM here to detect if the user has a brush, eraser, rubber stamp, etc etc... and if they do NOT, then i can change to the brush tool?
; Here's a whole thread about this, which i found later.
; https://community.adobe.com/t5/photoshop/changing-brush-size-shortcuts-ctrl-alt-second-click-and-drag/td-p/8922180
; I think I'm going to code my own overlay which will work even when not above the canvas, and will have better control over small brushes. I can do this using the photoshop COM or OLE objects and the AHK gui to make my own shapes and things... and package it up into a exe for other poeple and it'll be just great. will take a LOT of coding but it is possible in theory, i think.
;this could be useful for the offsets that i need, but it has no COM integration sadly. https://www.carbodydesign.com/archive/2008/09/30-photoshop-brush-controller/3/
; that's a project for another time...
; https://www.ps-scripts.com/viewtopic.php?f=53&t=24088&start=10
; https://www.adobe.com/content/dam/acom/en/devnet/scripting/estk/javascript_tools_guide.pdf
; newbrush()
; https://www.ps-scripts.com/viewtopic.php?f=77&t=22770&p=143524&hilit=brushes#p143524

;https://community.adobe.com/t5/photoshop/how-to-read-out-current-brush-size-in-javascript/m-p/8045339

; function getCurrentBrushInfo() {
    ; var brsh = {};
    ; var ref = new ActionReference();

    ; ref.putEnumerated(charIDToTypeID("capp"), charIDToTypeID("Ordn"), charIDToTypeID("Trgt"));
    ; var currentBrush = executeActionGet(ref).getObjectValue(stringIDToTypeID("currentToolOptions")).getObjectValue(charIDToTypeID('Brsh'));

    ; brsh.diameter = currentBrush.getDouble(charIDToTypeID('Dmtr'));
    ; brsh.hardness = currentBrush.getDouble(charIDToTypeID('Hrdn'));
    ; brsh.angle = currentBrush.getDouble(charIDToTypeID('Angl'));
    ; brsh.roundness = currentBrush.getDouble(charIDToTypeID('Rndn'));
    ; brsh.spacing = currentBrush.getDouble(charIDToTypeID('Spcn'));

    ; return brsh
; }
;https://stackoverflow.com/questions/44508493/photoshop-javascript-how-to-change-the-brush-mode-with-javascript
;https://www.ps-scripts.com/viewtopic.php?t=7046






;----------------------------------------------------







; Macro key G11, vertical anchor
F15:: ; For the color picker hud

;https://www.autohotkey.com/boards/viewtopic.php?f=5&t=4236#p23679
ComObjActive("Photoshop.application").currentTool := "paintbrushTool"

SendInput {LAlt down}
SendInput {LShift down}
SendInput {Rbutton down}
Sleep 1
KeyWait, F15 ; Wait for F15 to be released
Sleep 1
SendInput {Rbutton up}
SendInput {LShift up}
SendInput {LAlt up}
return

; Zoom using your mouse movement (alternative assignment)
F19::
SendInput {RCtrl down}
SendInput {Space down}
SendInput {LButton down}
Sleep 1 
KeyWait, F19 ; Wait for F19 to be released
Sleep 1
SendInput {Lbutton up}
SendInput {Space up}
SendInput {RCtrl up}
return


F20::return ;this caused issues with CapsLock being rapidly toggled on and off... meaning photoshop might have hardware level access to know what key I'm actually pressing; weird.
; ; Zoom using your mouse movement.
; F20::
; ;note that I've rebound my CapsLock to be F20, using iCue. So it becomes a very useful extra key right on homerow.
; ;in this case, I'm gonna use it for zooming around in photoshop using the mouse. usually you have to press ctrl, space, and left click, all at the same time, and THEN moving the mouse will do stuff. With this macro, you press one key instead of 3.
; sendinput {Rctrl down}
; sendinput {space down}
; sendinput {Lbutton down}
; ;sleep 1 ;just because. Maybe this is a bad idea though.
; KeyWait, F20 ;waits for F20 to be released
; sleep 1
; sendinput {Lbutton up}
; sendinput {space up}
; sendinput {Rctrl up}
; return

; Zoom using your mouse movement
F17::
SendInput {RCtrl down}
SendInput {Space down}
SendInput {LButton down}
Sleep 1
KeyWait, F17 ; Wait for F17 to be released
Sleep 1
SendInput {LButton up}
SendInput {Space up}
SendInput {RCtrl up}
return


; Instant hand tool using your mouse movement
F18::
SendInput {Space down}
SendInput {Lbutton down}
Sleep 1
KeyWait, F18 ; Waits for F18 to be released
Sleep 1
SendInput {Lbutton up}
SendInput {Space up}
return


; No CTRL for zooming
-::
if WinActive("ahk_class #32770") and WinActive("ahk_exe Photoshop.exe") and WinActive("Save As")
{
	Send, - ; Normal - keystroke
}
else
{
	Send, ^- ; Zoom out
Sleep 5
}
; Send, {ctrl up} ;I've had issues with modifier keys getting stuck
return

=::
Send, ^= ; Zoom in
Sleep 5
; Send, {ctrl up} ;I've had issues with modifier keys getting stuck
return


; Macro key G4
;F21 & F4::

; Macro key G5
F21 & F5::Send, !{backspace} ; Fill with foreground

; Macro key G6
F21 & F6::Send, ^{backspace} ; Fill with background


; https://twitter.com/TaranVH/status/1129206615515705344
; https://forums.adobe.com/thread/1453594
; Block some of these shortcuts
; WAARNING: The below code will mess up Wacom tablet shortcuts, wacom steals these obscure shortcuts from photoshop, and the below code breaks it
; ; !F13:: ; Rotate 15 degrees clockwise
!F14:: ; Rotate 15 degrees counter clockwise
!F15:: ; Zoom out
; !F16:: ; Zoom in
; !F17::
return

; F1::SendInput, {alt down}iac{alt up}

#IfWinActive




; Fix CapsLock ;; Note: Tilde (~) notation causes cross-talk
RShift & LShift::CapsLock
LShift & RShift::CapsLock
^CapsLock::CapsLock ; Only ^CapsLock will toggle CapsLock, such that the CapsLock key to be used as a modifier key
^F20::CapsLock ; Required for the above line, since CapsLock is remapped to F20 in iCue
~F20 & LCTRL::CapsLock ; In case the CapsLock key goes down first
CapsLock::F20 ; Note: If you have a corsair keyboard you can remap it directly with iCue, which is a cleaner solution that this




















MouseClick, left,,, 1, 0, U ; Release the mouse button. 
; https://jacksautohotkeyblog.wordpress.com/2016/03/08/windows-volume-control-using-your-mouse-wheel-and-the-autohotkey-if-directive-beginning-hotkeys-part-6/




; Macro for moving Google Sheets or Excel's B-roll matrix information into Word

#if WinActive("ahk_exe EXCEL.exe") or WinActive("ahk_exe firefox.exe") or WinActive("ahk_exe chrome.exe")

; Macro key G7
F17::
; TODO: This is supposed to put the shot BEFORE the other stuff on the comment, but word 365 doesn't work that way
doAnEnter := 1
SendInput, ^c
Sleep 100
;WinActivate ahk_exe firefox.exe
; send ^{F4} ; Activate word, and if active, move to next comment
; TODO: MsgBox, The above code closes the tab, fix this cross talk
if WinActive("ahk_exe EXCEL.exe")
	doAnEnter := 0 ; If you're copying out of Excel rather than Google Sheets, the copied cell has it's own "return" (enter). Hence, don't add another one

switchToWord()

Sleep 100
Send ^v
Sleep 100

if (doAnEnter = 1)
	sendinput, {enter}
Sleep 100

SendInput, {F3} ;in word, "go to next comment."
Sleep 10
;WinActivate ahk_class MozillaWindowClass
;TODO: Sometimes this code activates the paragraph thingy (Ctrl Shift 8), fix this cross talk
return

#IfWinActive


; #ifWinActive ahk_exe SumatraPDF.exe
; F14::Send, {F11} ; Fullscreen
; #IfWinActive

!`:: ; Check window IDs
WinGet, ActiveId, ID, A
MsgBox, %ActiveId%
ControlGetFocus, OutputVar, A
MsgBox, %OutputVar%
Return

^+end::checkFullness()

; Script reloader
#ifwinactive ahk_class Notepad++
^r::
Send ^s
Sleep 10
Soundbeep, 1000, 500
Reload
Return

F10::return ; No menu acceleration
F11::return ; No fullscreen
F12::return ; No topbar removal shortcut

; #IfWinActive



F9::ConvertSentence() ; https://autohotkey.com/board/topic/24431-convert-text-uppercase-lowercase-capitalized-or-inverted/
; ^+F9::Convert_Cap()

; Convert_Cap()
; {
 ; Clip_Save:= ClipboardAll                                                 ; save original contents of clipboard
 ; Clipboard:= ""                                                           ; empty clipboard
 ; Send ^c{delete}                                                          ; copy highlighted text to clipboard
 ; StringLower Clipboard, Clipboard                                         ; convert clipboard to desired case
 ; Send %Clipboard%                                                         ; send desired text
 ; Len:= Strlen(Clipboard)
 ; Send +{left %Len%}                                                       ; highlight text
 ; Clipboard:= Clip_Save                                                    ; restore clipboard
; }

ConvertSentence()
{
	click left
	click left
	clipSave := Clipboard
	Clipboard = ; Empty the clipboard so that ClipWait has something to detect
	SendInput, ^c ;copies selected text
	ClipWait
	StringReplace, Clipboard, Clipboard, `r`n, `n, All ;Fix for SendInput sending Windows linebreaks 
	StringLower, Clipboard, Clipboard
	Clipboard := RegExReplace(Clipboard, "(((^|([.!?]+\s+))[a-z])| i | i')", "$u1")
	Len:= Strlen(Clipboard)
    SendInput, ^v ;pastes new text
	Send +{left %Len%}
    VarSetCapacity(OutputText, 0) ;free memory
	Clipboard := clipSave
}


;;;;;;;**************this is where I had a blank, 4th, "F22" keyboard all set up, but I moved it. **************
;;;;I don't actaully use 4 total keyboards in my work. Well, not yet.









:*:--- ::{Asc 0151}

; Three dashes -> EM dash. https://superuser.com/questions/857338/how-to-add-the-em-dash-to-my-keyboard
; https://www.experts-exchange.com/questions/29046416/Favorite-way-to-make-an-em-dash.html
; ^-:: ;en dash (150/x96)
; Send –
; Return

; !-:: ;em dash (151/x97)
; Send —
; Return

; !^-:: ;bullet (149/x95)
; Send •
; Return

#IfWinActive ahk_exe winword.exe
:*:--- ::{Asc 0151}

;;;Script to use F11 and F12 to scroll down and up! Useful for wacom tablet users who don't have a scroll wheel.
;;i found the code here https://stackoverflow.com/questions/24001634/how-can-i-bind-my-mouse-wheel-to-scroll-down-with-a-key-and-this-key-is-ahk
; *F11::
; While GetKeyState("F11", "p")
; {
    ; SendInput, {WheelDown}
    ; Sleep, 10 ; Add a delay if you want to increase the interval between keystokes.
; }
; return

; F12::
; ;MsgBox,,,you pressed F9,0.6
; While GetKeyState("F12", "p")
; {
    ; SendInput, {Wheelup}
    ; Sleep, 10 ; Add a delay if you want to increase the interval between keystokes.
; }
; return

;;;----------

; #IfWinActive

; ;control alt shift T -- click on the address bar for any youtube video, and this will link you to the thumbnail!
; ^!+T::
; Send {end}{left 11}{backspace 40}https://i.ytimg.com/vi/{right 11}/sddefault.jpg{enter}
; ; Send {end}{left 11}{backspace 40}https://i.ytimg.com/vi/{right 11}/maxresdefault.jpg{enter}

; ;EXAMPLE: https://i.ytimg.com/vi/L-zDtBINvzk/hqdefault.jpg
; ;http://img.youtube.com/vi/<insert-youtube-video-id-here>/maxresdefault.jpg
; return

;;MODS - script to fix stuck modifier keys
;this is ANY key though
; KeyList := "Shift|a|b|c|d|e|f|g|h|i|j" ; and so on

; Loop, Parse, KeyList, |
; {
    ; If GetKeystate(A_Loopfield, "P")
        ; Send % "{" A_Loopfield " Up}"
; }

; KeyList := "Shift|ctrl|alt" ; and so on

; Loop, Parse, KeyList, |
; {
    ; If GetKeystate(A_Loopfield, "P")
        ; Send % "{" A_Loopfield " Up}"
; }

#ifwinactive

^+!t::
;always on top toggle / in front
Winset, Alwaysontop, , A
tooltip, ALWAYS ON TOP TOGGLE
Sleep 100
tooltip,
return

;;i used this to delete premiere title styles quickly.
; numpadsub::
; click right
; sleep 5
; send d
; sleep 5
; send d
; sleep 5
; send {enter}
; sleep 5
; send {enter}
; return

; ^+!Escape::ExitApp

;^+/::SendInput, !{F9}
;
;


; ~VK3D::
; tooltip, what
; sleep 50
; tooltip,
; return

#ifwinactive

; SC0EB::tooltip, gonna see if keys can be tirggered when i am inside of another function.
; SC0E8::tooltip, sc0e8 EIGHT


; ; ; testing a thing.
;;;;;https://autohotkey.com/board/topic/56123-horizontal-scroll-wheelleftwheelright-in-windows-2003xp/
; ; WheelDown::
; ; send, {WheelRight}
; ; return
; ; WheelUp::
; ; send, {WheelLeft}
; ; return


;testing...



^+F12::
WinGet, the_current_id, ID, A

MsgBox,,,the_current_id = %the_current_id%, 2.5

; ("AHK needed","https://docs.google.com/document/d/1xsjjKYggXYig_4lfBMJ6LDGRZ9VOvDd7SCSTSi7GwN8/edit")

vRet := JEE_ChromeFocusTabByName(, "AHK needed", 2)

MsgBox,,,vRet = %vRet%, 0.5

return



#ifwinactive
;END::SendInput, {numlock}
;this is for PARSEC only. it's a temporary thing. gotta control numlock somehow!




;;;;;;;;THE BELOW CODE IS FOR SUPER SLOW SCROLLING IN FIREFOX. SADLY, IT TURNS OUT TO NOT BE AS SMOOTH AS AUTOSCROLLING (USING MIDDLE CLICK AND THEN MOVING THE CURSOR SLIGHTLY) SO I'M NOT USING IT FOR NOW...
; F9::
; tooltip, is it working
; ;PostMessage 0x20A, 0x780000, (mY<<16)|mX, %Ctrl%, ahk_id %WinID%
; MouseGetPos mX, mY, WinID, Ctrl
; ;PostMessage 0x20A, 0x780000, (mY<<16)|mX, %Ctrl%, ahk_id %WinID%
; ;PostMessage 0x20A, -0x780000, (mY<<16)|mX, %Ctrl%, ahk_id %WinID%
; PostMessage 0x20A, -0x780000, (30)|mX, %Ctrl%, ahk_id %WinID%
; return

; CoordMode, Mouse, Screen
; return

; WheelUp::
	; MouseGetPos, m_x, m_y
	; hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

	; ; WM_MOUSEWHEEL
	; ;	WHEEL_DELTA = 120
	; SendMessage, 0x20A, 12 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
; return


;WheelDown::




; F8::
; CoordMode, Mouse, Screen


; WheelUp::
	; CoordMode, Mouse, Screen
	; MouseGetPos, m_x, m_y
	; hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

	; ; WM_MOUSEWHEEL
	; ;	WHEEL_DELTA = 120
	; SendMessage, 0x20A, 120 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
; return

; WheelDown::
	; CoordMode, Mouse, Screen
	; MouseGetPos, m_x, m_y
	; hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

	; ; WM_MOUSEWHEEL
	; ;	WHEEL_DELTA = 120
	; SendMessage, 0x20A, -120 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
; return

/*
F9::
;;https://www.autohotkey.com/boards/viewtopic.php?t=68578
;,PostMessage, 0x20A, 1<<16, 0,, A ;WM_MOUSEWHEEL := 0x20A
	
While GetKeyState("F9", "p")
{
	
	;;;;https://autohotkey.com/board/topic/16505-sending-wheeldown-to-a-control/
    MouseGetPos, m_x, m_y
	hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

	; WM_MOUSEWHEEL
	;	WHEEL_DELTA = 120
	; SendMessage, 0x20A, -2 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
	; SendMessage, Msg  , wParam  , lParam   , Control, WinTitle, [WinText, ExcludeTitle, ExcludeText, Timeout]
	;SendMessage, 0x20A  , -2 << 16  , 1700 << 16|2100 ,, A ;with this, it won't work until window X is 430 or greater. So fuckin weird.
	SendMessage, 0x20A  , -4 << 16  , 700 << 16|700 ,, A ;with this, it won't work until window Y is more than 280. also fuckin weird. also x must be below 695. ugh note i had line 1458 active, uuuugh.
	
	
    Sleep, 5 ; Add a delay if you want to increase the interval between keystokes.
}

return
*/	

;;;;;;; BE SUPER CAREFUL WITH    */   ... IF YOU DO    ;*/    IT LOOKS LIKE IT STILL CANCELS THE COMMENT AREA, ACCORDING TO THE SYNTAX HIGHLIGHTING IN NOTEPAD++ ... BUT IT DOESN'T. THE COMMENT AREA STILL ENXTENDS ALL THE WAY UNTIL A TRUE */ OR TO THE BOTTOM OF THE DOCUMENT.

; ;;https://www.autohotkey.com/boards/viewtopic.php?p=157799#p157799
; #IfWinActive ahk_class MozillaWindowClass
; ;note: tested on Firefox v69
; ;note: the cursor must be over the Firefox window for WM_MOUSEWHEEL/WM_MOUSEHWHEEL to work

; ^+w:: ;mozilla firefox - scroll up/down
; PostMessage, 0x20A, 1<<16, 0,, A ;WM_MOUSEWHEEL := 0x20A
; ;PostMessage, 0x115, 0, 1,, A ;WM_VSCROLL := 0x115 ;SB_LINEUP := 0
; return


;;;/////////END OF FIREFOX SUPER SLOW SCROLLING EXPERIMENT//////////////
