;____________________________________________________________________
;                                                                    
;		  3ND KEYBOARD USING INTERCEPTION (Mechanical Jelly Numpad)
;____________________________________________________________________

#if
; https://www.reddit.com/r/MechanicalKeyboards/comments/4kf2gk/review_jellycomb_mechanical_numpad/
; https://autohotkey.com/board/topic/29542-rebinding-alt-061/

; this is for the jellycomb numpad 4th keyboard's TOP ROW of keys:
$*~LAlt::
Loop 10
	Hotkey, % "*Numpad" A_Index-1, HandleNum, on
keywait, LAlt ; replace with "Sleep 100" for an alternative
Loop 10
	Hotkey, % "*Numpad" A_Index-1, HandleNum, off
If (Ascii_Unicode_Input = "061")
	{
	msgbox,,, you pressed the equals key!,1
	; ;InputBox, password, Enter Password, (your input will be hidden), hide 
	; InputBox, UserInput, Phone Number, Please confirm murdering of premiere, , 640, 480
	; if UserInput = "="
		; {
		; MsgBox, You entered "%UserInput%"
		; Run, %comspec% /c "taskkill.exe /F /IM Adobe Premiere Pro.exe",, hide 
		; }	
	; else***
		; return
	}
If (Ascii_Unicode_Input = "040")
{
	prFocus("Effect Controls") ;the following shortcut only works if the Effect Controls panel is in focus...
	send ^!p ; Pin to clip
	prFocus("timeline")
}
If (Ascii_Unicode_Input = "041")
	; msgbox,,, you pressed the close parenthisesis key!,1
Ascii_Unicode_Input := ""
return

HandleNum:
Ascii_Unicode_Input .= SubStr( A_ThisHotkey, 0 )
return
#if