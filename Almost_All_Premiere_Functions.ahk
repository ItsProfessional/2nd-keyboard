SetWorkingDir, C:\AHK\2nd-keyboard\support_files

#NoEnv
Menu, Tray, Icon, shell32.dll, 283 ; This changes the tray icon to a little keyboard
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance Force
#MaxHotkeysPerInterval 2000
#WinActivateForce

; The variable below exists for the purpose of communicaiton with gui.ahk if a script is launched from the Stream Deck
TargetScriptTitle = "C:\AHK\2nd-keyboard\gui.ahk ahk_class AutoHotkey"

recallTransition(foo) ; This was a part of the Luamacros scripts
{
	; Do nothing
}


#IfWinActive ahk_exe Adobe Premiere Pro.exe




monitorKeys(whichMonitor, shortcut, useSpace := 1)
{
	KeyWait, %A_PriorHotkey%
	if WinActive("ahk_exe Adobe Premiere Pro.exe") ;AHA, it is better to use the EXE, because if you are in a secondary monitor window, then the CLASS is not active even though the EXE still is, mildly interesssstting.
	{

		;IDK if I need to set a coordmode here?
		; CoordMode, Pixel, Window
		; CoordMode, Mouse, Window
		; CoordMode, Caret, Window

		if (whichMonitor = "source") ; Source monitor
		{
			x := "1800"
			y := "500"
			; coordinates that are very likely to be within my Source Monitor's usual area
		}
		else ; Program monitor
		{
			x := "3300"
			y := "500"
			whichMonitor = "program"
			; coordinates that are very likely to be within my Program Monitor's usual area
		}

		ActiveHwnd := WinExist("A")
		windowWidth := CoordGetControl(x,y, ActiveHwnd)

		if (windowWidth < 2000) ; Check that monitor is not maximized
		{
			if (whichMonitor = "source")
				prFocus("source") ; Note: it switches to the effects panel first
			else
				prFocus("program") ; Note: it switches to the effects panel first

			Sleep, 20
		}

		Sleep, 30 ; Sometimes these shortcuts don't "take" without a bit of delay
		SendInput, %shortcut%

		; if (shortcut = "^{numpad3}") or if (shortcut = "^+1")
		; {
		; 	Sleep, 30
		; 	SendInput, %shortcut%
		; 	; Premiere 12.0.1 is SLOOOWWW to react to these shortcuts in particular. (Source monitor resolution to 1/4) and (program monitor res to 1/1) So I gotta WAIT AROUND and send this TWICE.
		; }

		; if (shortcut = "^{numpad2}")
		; {
		; 	Send, {CTRL UP}
		; 	Sleep, 10
		; 	Send, {CTRL DOWN}
		; 	Sleep, 10
		; 	Send, {CTRL UP}
		; 	Sleep, 10
		; }



		;THE CODE BELOW IS SUPER OPTIONAL
		if (windowWidth > 2000) ; Check that monitor is maximized
		{
			;Then it's not obvious which monitor it is, and it's possible that I misremembered, and pressed the wrong button. Therefore, I will ALSO send the shortcut that corresponds to the alternative monitor.

			;Also, it's possible that the window is not in focus. I want to send a middle click to it without moving the mouse, since coordinates arent well supported on other monitors. For this, controlfocus or controlclick MIGHT work...

			;ControlClick , x1800 y500, WinTitle, WinText, MIDDLE, 1, Pos

			if (shortcut = "^{numpad1}")
				SendInput, ^+1

			else if (shortcut = "^{numpad2}")
				SendInput, ^+2

			else if (shortcut = "^{numpad5}")
				SendInput, ^+2

			else if (shortcut = "^{numpad3}")
				SendInput, ^+3


			else if (shortcut = "^+1")
				SendInput, ^{numpad1}

			else if (shortcut = "^+2")
				SendInput, ^{numpad2}

			else if (shortcut = "^+3")
				SendInput, ^{numpad3}

			; For the safe margins
			else if (shortcut = "^!+[")
				SendInput, ^!+]

			else if (shortcut = "^!+]")
				SendInput, ^!+[


			if (windowWidth < 2000) ; Check that monitor is not maximized
				if not (whichMonitor = "source") ; Stay on the source monitor if it is active
					prFocus("timeline")


			; This allows the new playback resolution to take effect.
			if (useSpace = "1")
			{
				SendInput, {space} ; Pause/play
				Sleep, 50
				SendInput, {space} ; Pause/play
			}
		}
	}
}




effectsPanelFindBox()
{
prFocus(effects)
SendInput, ^b ; Select find box
}



effectsPanelType(item := "x")
{
	; MODSL() ; Might not be needed anymore

	SendInput, ^+!7 ; Select effects panel
	Sleep, 20
	SendInput, ^b ; Select find box

	SendInput, +{backspace} ;shift backspace deletes any text that may be present. It is much less dangerous than sending "delete" or "backspace" alone.
	Sleep, 10
	SendInput, %item%

	; This is also Select find box. Except it doesn't have the annoying windows sound which happens when pressing ^b when its already selected. However, alt may be dangerous if stuck
	SendInput, ^!b ; Reselect
	}



	#if


	MODSL() ; Unstick left modifiers ;; Note: Not used anymore
	{
	Sleep, 1
	SendInput,{blind}{LCtrl up}{LAlt up}{LShift up}
	}


	MODSR() ; Unstick right modifiers ;; Note: Not used anymore
	{
	Sleep, 1
	SendInput, {blind}{RCtrl up}{RAlt up}{RShift up}
}




preset(item)
{
	; Note: Preset must be in folders (otherwise, change the coordinates) and be unique for it to work

	KeyWait, KeyName [, Options], %A_PriorHotKey% ; Not waiting for it to be released can disrupt commands like SendInput, and cause cross-talk with modifier keys

	; Keyshower(item,"preset")
	; if IsFunc("Keyshower")
	; {
		; Func := Func("Keyshower")
		; RetVal := Func.Call(item,"preset") 
	; }

	ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	{
		goto theEnding ; If launched outside of premiere, exit function
	}


	CoordMode, Pixel, Window
	CoordMode, Mouse, Window
	CoordMode, Caret, Window

	; Temporarily block the mouse and keyboard from sending any information
	BlockInput, SendAndMouse
	BlockInput, MouseMove
	BlockInput, On

	SetKeyDelay, 0 ; No typing delay

	; If the video is playing it can mess up the script.
	SendInput, ^!+k ; Shuttle stop
	Sleep, 10
	SendInput, ^!+k ; Shuttle stop
	Sleep, 5


	MouseGetPos, xposP, yposP

	SendInput, {MButton} ;this will MIDDLE CLICK to bring focus to the panel underneath the cursor (which must be the timeline). I forget exactly why, but if you create a nest, and immediately try to apply a preset to it, it doesn't work, because the timeline wasn't in focus...? Or something. IDK.
	Sleep, 5

	prFocus("effects")

	Sleep, 15

	SendInput, ^b ; Select find box
	Sleep, 5


	; If no caret found waits until it is found
	if (A_CaretX = "")
	{
		waiting2 = 0 ; Waiting is taken elsewhere
		Loop
		{
			waiting2 ++
			Sleep, 33
			if (A_CaretX <> "")
				break

			if (waiting2 > 40)
			{
				ToolTip, Error: Caret could not be found
				Sleep, 200
				ToolTip,

				Sleep, 20
				goto theEnding
			}
		}
		Sleep, 1
		ToolTip,
	}

	MouseMove, %A_CaretX%, %A_CaretY%, 0 ; Move cursor to caret
	Sleep, 5

	MouseGetPos, , , Window, classNN
	WinGetClass, class, ahk_id %Window%

	ControlGetPos, XX, YY, Width, Height, %classNN%, ahk_class %class%, SubWindow, SubWindow 

	; Move cursor to the magnifying glass of in the find box
	;MouseMove, XX-25, YY+10, 0 ; For 150% DPI
	MouseMove, XX-15, YY+10, 0 ; For 100% DPI
	Sleep, 5

	SendInput, %item%
	Sleep, 5

	; Move cursor to the preset icon
	; MouseMove, 62, 95, 0, R ; For 150% DPI
	MouseMove, 41, 63, 0, R ; For 100% DPI
	Sleep, 5



	; In case there are duplicate entires (due to a premiere bug), use the following workaround to fix it
	MouseGetPos, iconX, iconY, Window, classNN
	WinGetClass, class, ahk_id %Window%

	ControlGetPos, xxx, yyy, www, hhh, %classNN%, ahk_class %class%, SubWindow, SubWindow

	MouseMove, www/4, hhh/2, 0, R ; Move to the center of the effects panel
	Sleep, 5

	MouseClick, left, , , 1 ; Click the center of effects panel. Now the duplicate entries should be gone
	Sleep, 5

	MouseMove, iconX, iconY, 0 ; Move cursor back to the preset icon
	Sleep, 5





	MouseClickDrag, Left, , , %xposP%, %yposP%, 0 ; Drag preset to clip that was being hovered before this function was called
	Sleep, 5
	MouseClick, middle, , , 1 ; Focus the timeline

	BlockInput, MouseMoveOff
	BlockInput, off

	
	; If the preset is a crop preset, move cursor to the crop control in the Effect Controls panel
	IfInString, item, CROP
	{
		Sleep, 320
		cropClick() ; Click the crop transform button in the effect controls panel
	}

	theEnding:
}



DrakeynPreset(item) ; 2nd preset function
{
; https://github.com/Drakeyn/AdobeMacros/blob/master/Premiere%20Pro/Functions/ApplyPreset.ahk

SendMode Event

; KeyWait, %A_PriorHotKey% ; Waits to make sure any previous hotkeys have been released

;Just in case we're not in Premiere Pro
if(WinActive("ahk_exe Adobe Premiere Pro.exe") = 0)
	goto apEnd

;Sets up the coord modes, making sure our pixel distances are consistent
CoordMode, Pixel, Window
CoordMode, Mouse, Window
CoordMode, Caret, Window

; Disables mouse and keyboard input to make sure the function runs properly
BlockInput, SendAndMouse
BlockInput, MouseMove
BlockInput, On

;Sets the keypress delay for Send/SendInput commands to be zero.
SetKeyDelay, 0

;Gets the current position of the mouse and stores it in ox and oy (Original X and Original Y)
MouseGetPos, oX, oY 

effectsPanelFindBox()

;Types the preset we're looking for into the find box
Send %item%

; Wait for Premiere to update the presets list
; If it is already opened, Premiere will instantly update the list. Otherwise it takes some time
; To make it reliable no matter whether its already open or not, we need to add a delay
Sleep, 70

; Get effects panel position
ControlGetPos, cX, cY, cW, cH, %wdEffectsPanel%, ahk_class Premiere Pro
MsgBox, %cX%, %cY%, %cW%, %cH%

; Find top preset icon
ImageSearch, iX, iY, cX, cY, cX + cW, cY + cH, C:\AHK\2nd-keyboard\support_files\preset.png
MsgBox, %ErrorLevel%
if(ErrorLevel == 1)
	goto apEnd
if(ErrorLevel == 2)
	goto apEnd

; Move mouse to preset
MouseMove, iX, iY + 5, 0

; Drag preset back
MouseClickDrag, Left, , , oX, oY, 0

apEnd:

; Resets and pre-opens the presets list for easier editing
effectsPanelFindBox()

; Send, XYZ

; Puts the mouse back where it started
MouseMove oX, oY, 0

; Re-selects the timeline panel
MouseClick, middle, , , 1 

; Re-enables input
BlockInput, MouseMoveOff 
BlockInput, off 
}




prFocus(panel)
{
	SendInput, ^!+7 ; Focus the effects panel. Otherwise, if the panel that is to be focused is already focused, it may switch sequences, etc. But this does not happen in the effects panel. Hence, switch to the effects panel (no consequences if it's already focused) and then switch to the desired panel
	Sleep, 12

	SendInput, ^!+7 ; If a panel was maximized before running this function, sending the effects panel shortcut would unmaximize the maximized panel, but would not switch to the effects panel. This line ensures that it switches to the effects panel
	Sleep, 5


	if (panel = "effects")
		goto theEnd ; Switching to the effects panel here is unnecessary, since the function switches to it above

	else if (panel = "timeline")
		SendInput, ^!+3

	else if (panel = "program")
		SendInput, ^!+4

	else if (panel = "source")
		SendInput, ^!+2

	else if (panel = "project")
		SendInput, ^!+1

	else if (panel = "effect controls")
		SendInput, ^!+5

	theEnd:
}


; Note: no longer used
savepreset(presetname){
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
	Sleep, 20

	SendInput, {c up}{Ctrl up}
	Sleep, 20

	presetname = %clipboard%
	return presetname
}



insertSFX(leSound)
{
	ifWinNotActive ahk_exe Adobe Premiere Pro.exe
		goto sfxEnding
		
	;keyShower(leSound, "insertSFX") ;the following is used instead of this line.
	if IsFunc("Keyshower") ;checks to see if you have the Keyshower function defined.
	{
		Func := Func("Keyshower")
		RetVal := Func.Call(leSound, "insertSFX") 
	}

	CoordMode, Mouse, Screen
	CoordMode, Pixel, Screen
	CoordMode, Caret, screen

	BlockInput, Mouse
	BlockInput, MouseMove
	BlockInput, On

	SetKeyDelay, 0 ;for instant writing of text

	MouseGetPos, xpos, ypos
	Send ^+x ; Remove in/out points
	Sleep, 10
	Send ^+9 ; Source assignment preset 4 (sets it to A3)
	Sleep, 10

	Send ^!+1 ; Project panel
	Sleep, 20

	Send ^b ; Select find box ;; Note: make sure there are no conflicts, otherwise it will not work
	; Send +{backspace} ; Delete search text

	Send %leSound%
	Send ^+9 ; Source assignment preset 4
	Sleep, 400

	MouseMove, -6000, 250, 0 ; Moves the mouse to the bin that becomes highlighted from the "project" keyboard shortcut
	MouseClick, left
	Sleep, 10

	send ^+9 ; Source assignment preset 4
	Sleep, 5

	Send ^b ; Select find box
	Sleep, 10

	Send +{backspace} ; Delete search text
	Sleep, 10

	MouseMove, %xpos%, %ypos%, 0 ; Move mouse back to original coordinates
	Sleep, 10

	Send ^+9 ; Source assignment preset 4. The preset has V3 and A4 selected as sources
	Sleep, 50

	Send ^/ ; Overrite
	Sleep, 30

	; Send MButton ; Refocus previous panel before execution of this function
	send ^!+7 ; Effects panel
	Sleep, 30

	send ^!+3 ; Timeline

	BlockInput, off
	BlockInput, MouseMoveOff
	sfxEnding:
}




; Note: insideclipboard.exe must be installed and paths correctly configured
; Note: You have to restart after installing insideclipboard.exe
#ifwinactive ahk_exe Adobe Premiere Pro.exe
saveClipboard(int) { ; Clip(s)/Transition clipboard save to file
	StringReplace, int, int, +, , All ; Replace + with nothing. This is just in case A_thishotkey contains + if shift was used
	StringReplace, int, int, !, , All ; Replace ! with nothing. This is just in case A_thishotkey contains ! if alt was used
	StringReplace, int, int, ^, , All ; Replace ^ with nothing. This is just in case A_thishotkey contains ^ if ctrl was used

	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
	Sleep, 20

	ClipWait, 0.25 ;
	SendInput, {c up}{Ctrl up}

	Sleep, 20
	saveToFile("clip" . int . ".clp")

	Sleep, 1000
	saveToFile("clip" . int . ".clp")
}




#IfWinActive, ahk_exe Adobe Premiere Pro.exe
recallClipboard(int, transition := 0) { ; Clip(s)/Transition clipboard paste from file
	; keyShower(int, "recallClipboard")
	if IsFunc("Keyshower") {
		Func := Func("Keyshower")
		RetVal := Func.Call(int, "recallClipboard") 
	}

	WinActivate, Adobe Premiere Pro
	prFocus("timeline")

	; Send ^!d ; Deselect clips

	; Set clipboard to some text (cannot be empty). This way, AutoHotkey can now clear the clipboard since it is text
	; Note: To create this file, copy some text (it cannot be empty), use insideclipboard.exe to save it as clipTEXT.clp
	loadFromFile("clipTEXT.clp") ;
	Sleep, 15

	; loadFromFile("clipTEXT.clp") ; The clipboard must be loaded twice, or it won't work about 70% of the time
	; Sleep, 15

	; Note: AutoHotkey cannot clear the clipboard if it is not text. Thus, the above is necessary
	clipboard = ; Clear clipboard
	Sleep, 10
	
	; Paste empty clipboard into Premiere. Otherwise, Premiere will use the previous clipboard entry before loading from file

	WinActivate, Adobe Premiere Pro ; Premiere has to be actived after using insideclipboard.exe, otherwise it may paste into Command Prompt, etc.

	; Note: This is a much better way to paste than to send ^v
	SendInput, {Shift Down}{Shift Up}
	Sleep, 10
	SendInput, {Ctrl Down}{v Down} 
	Sleep, 5
	SendInput, {v Up}{Ctrl Up}
	Sleep, 20
	


	loadFromFile("clip" . int . ".clp") 
	Sleep, 15

	; loadFromFile("clip" . int . ".clp"); The clipboard must be loaded twice, or it won't work about 70% of the time
	; Sleep, 15

	WinActivate, Adobe Premiere Pro ; Premiere has to be actived after using insideclipboard.exe, otherwise it may paste into Command Prompt, etc.
	
	; if (transition = 0)
	; {
		; target("v1", "off", "all", 5) ;this will disable all video layers, and enable only layer 5.
		; ToolTip, only layer 5 was turned on should be
		; Sleep, 150
		
	; }

	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down}
	Sleep, 5
	SendInput, {v Up}{Ctrl Up}
	Sleep, 10
	
	; The following code doesn't work very well
	/*

	Sleep, 100
	If (transition = 1){
		; Note: none of the label colors will be correct (due to a premiere bug). To work around it, delete what was pasted, and then paste it again
		prFocus("timeline")

		SendInput, +{delete} ; Ripple delete
		Sleep, 100
		
		; Now that the label colors have loaded, paste it again
		Sleep, 30
		SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down}
		ClipWait, 0.50
		SendInput, {v Up}{Ctrl Up}
		Sleep, 10
	}
	*/
	
	
	if (transition = 0)
		target("v1", "on", "all")

	Sleep, 10
	; Send ^{F9} ; Toggle video tracks (hopefully off)
	; Send ^+{F9} ; Toggle audio tracks (hopefully off)
	Send, ^!{F11} ; Deselect clips
}

#IfWinActive



; Note: It doesn't work very well
Target(v1orA1, onOff, allNoneSolo := 0, numberr := 0) ; Target/Untarget arbitrary tracks
{
	; BlockInput, on
	; BlockInput, MouseMove
	; MouseGetPos xPosCursor, yPosCursor
	prFocus("timeline")
	wrenchMarkerX := 400
	wrenchMarkerY := 800 ;the upper left corner for where to begin searching for the timeline WRENCH and MARKER icons -- the only unique and reliable visual i can use for coordinates.
	targetdistance := 98 ;Distance from the edge of the marker Wrench to the left edge of the track targeting graphics

	CoordMode Pixel, Screen
	CoordMode Mouse, Screen

	ImageSearch, xTime, yTime, wrenchMarkerX, wrenchMarkerY, wrenchMarkerX+600, wrenchMarkerY+1000, %A_WorkingDir%\timelineUniqueLocator2.png
	if ErrorLevel = 0
	{
		; Do nothing, continue
		xTime := xTime - targetdistance
		;MouseMove, xTime, yTime, 0
	}
	else
	{
		; ImageSearch failed
		goto resetTrackTargeter
	}



	ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_unlocked_targeted_alone.png
	if ErrorLevel = 1
		ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_locked_targeted_alone.png

	if ErrorLevel = 2
	{
		; Targeted V1 Not Found
		goto trackIsUntargeted
	}

	if ErrorLevel = 3
	{
		; Could not conduct the Targeted v1 search
		goto resetTrackTargeter
	}

	if ErrorLevel = 0
	{
		; Targeted V1 found

		if (v1orA1 = "v1")
		{
			Send +9 ; Toggle all video track targeting
			Sleep, 10
			if (onOff = "on")
				send +9 ; Sending it twice targets everything

			Sleep, 10
			if (numberr > 0)
				Send +%numberr%
		}
		else if (v1orA1 = "a1")
		{
			Send !9 ; Toggle all audio track targeting
			Sleep, 10
			if (onOff = "on")
				send !9 ; Send twice to target everything

			Sleep, 10
			if (numberr > 0)
				Send !%numberr%
		}

		goto resetTrackTargeter
	}

	trackIsUntargeted:
	if ErrorLevel = 1
		ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_locked_untargeted_alone.png
	if ErrorLevel = 1
		ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_unlocked_untargeted_alone.png
	if ErrorLevel = 0
	{
		; Untargeted V1 found
		
		if (v1orA1 = "v1")
		{
			Send ^{F9} ; send +9 ; Toggle all video track targeting
			Sleep, 10
			if (onOff = "off")
				send +9 ; Send twice to untarget everything
			Sleep, 10
			if (numberr > 0)
				Send +%numberr%
		}
		if (v1orA1 = "a1")
			{
			Send ^{F9} ; send +9 ; Toggle all video track targeting
			Sleep, 10
			if (onOff = "off")
				Send !9 ; Send twice to untarget everything
			Sleep, 10
			if (numberr > 0)
				Send !%numberr%
			}
		goto resetTrackTargeter
		}

	resetTrackTargeter:
	; MouseMove, xPosCursor, yPosCursor, 0
	; BlockInput, Off
	; BlockInput, MouseMoveOff
	; Sleep, 1000
}

#ifwinactive


saveToFile(name) {
	RunWait, %comspec% /c C:\AHK\2nd-keyboard\insideclipboard\InsideClipboard.exe /saveclp %name%, C:\AHK\2nd-keyboard\insideclipboard\clipboards\
}

loadFromFile(name) {
	RunWait, %comspec% /c C:\AHK\2nd-keyboard\insideclipboard\InsideClipboard.exe /loadclp %name%, C:\AHK\2nd-keyboard\insideclipboard\clipboards\
}

#IfWinActive ahk_exe Adobe Premiere Pro.exe


; Open the Audio Channels box, and use the cursor to put both tracks on [left/right], turning stereo sound into mono (with the [right/right] track as the source)
audioMonoMaker(track)
{
	ifWinNotActive ahk_exe Adobe Premiere Pro.exe
		goto monoEnding

	Sleep, 3
	CoordMode,Mouse,Screen
	CoordMode,pixel,Screen

	BlockInput, SendAndMouse
	BlockInput, On
	BlockInput, MouseMove

	; Keyshower(track,"audioMonoMaker")
	if IsFunc("Keyshower") {
		Func := Func("Keyshower")
		RetVal := Func.Call(track,"audioMonoMaker") 
	}

	global tToggle = 1
	if (track = "right")
	{
		addPixels = 36 ; For 150% DPI
	}
	else if (track = "left")
	{
		addPixels = 0
	}

	SendInput, {F3} ; Audio channels
	Sleep, 15

	; SendInput, {F3} ; Send twice because sometimes it fails
	; Sleep, 15

	MouseGetPos, xPosAudio, yPosAudio

	MouseMove, 2222, 1625, 0 ; Move cursor to OK button

	MouseGetPos, MouseX, MouseY

	waiting = 0
	
	; Loops until the color under cursor changes to the specified color, indicating that the OK button is being hovered
	Loop
	{
		waiting ++
		Sleep, 50
		ToolTip, waiting = %waiting%`npixel color = %thecolor%
		MouseGetPos, MouseX, MouseY
		PixelGetColor, thecolor, MouseX, MouseY, RGB

		if (thecolor = "0xE8E8E8")
			break ; Color was found
			
		if (waiting > 10)
			goto, ending
	}
		
	CoordMode, Mouse, Client
	CoordMode, Pixel, Client

	; Move cursor to first checkbox
	MouseMove, 165 + addPixels, 295, 0 ; For 150% DPI
	Sleep, 50

	MouseGetPos, Xkolor, Ykolor
	Sleep, 50
	PixelGetColor, kolor, %Xkolor%, %Ykolor%

	If (kolor = "0x1d1d1d" || kolor = "0x333333") ; Empty checkbox
	{
		MouseClick, left, , , 1
		Sleep, 10
	}
	else if (kolor = "0xb9b9b9") ; Checked box
	{
		; Do nothing
	}

	Sleep, 5

	; Move cursor to second checkbox
	MouseMove, 165 + addPixels, 329, 0
	Sleep, 30

	MouseGetPos, Xkolor2, Ykolor2
	PixelGetColor, k2, %Xkolor2%, %Ykolor2%

	If (k2 = "0x1d1d1d" || k2 = "0x333333") ; Empty checkbox ;; Note: Both of these are potential dark grey background panel colors
	{
		MouseClick, left, , , 1
		Sleep, 10
	}
	else if (k2 = "0xb9b9b9") ; Checked box
	{
		; Do nothing
	}

	Send {enter}

	ending:
	CoordMode, Mouse, Screen
	CoordMode, Pixel, Screen
	MouseMove, xPosAudio, yPosAudio, 0

	BlockInput, off
	BlockInput, MouseMoveOff

	monoEnding:
}


#ifwinactive





; Click the crop transform button in the effect controls panel
cropClick()
{
	CoordMode Pixel, Screen
	CoordMode Mouse, Screen

	BlockInput, on
	BlockInput, MouseMove
	MouseGetPos xPosCursor, yPosCursor


	; Effect controls location
	effectControlsX = 10
	effectControlsY = 200

	; ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+200, effectControlsY+800, %A_WorkingDir%\CROP_transform_button_D2019.png
	ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+200, effectControlsY+800, %A_WorkingDir%\CROP_transform_2020.png
	if ErrorLevel = 2
	{
		; ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+400, effectControlsY+1200, %A_workingDir%\CROP_transform_button_D2019.png
		ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+400, effectControlsY+1200, %A_workingDir%\CROP_transform_2020.png
	}

	if ErrorLevel = 1
	{
		; No crop found
		goto resetcropper
	}

	if ErrorLevel = 2
	{
		; Could not conduct the crop search
		goto resetcropper
	}

	if ErrorLevel = 0
	{
		MouseMove, FoundX+10, FoundY+10, 0 ; Move cursor to icon
		Sleep, 5
		Click Left
	}

	resetcropper:
	MouseMove, xPosCursor, yPosCursor, 0
	BlockInput, Off
	BlockInput, MouseMoveOff

	return
}


; Note: This was useful when selections in Premiere were buggy. It is fixed now. Thus, this function is unnecessary
reselect()
{
if WinActive("ahk_exe Adobe Premiere Pro.exe")
	{
		Send ^!+k ; Shuttle stop
		Sleep, 5

		Send ^!+7 ; Effects panel
		Sleep, 5

		Send ^!+3 ; Timeline
		Sleep, 5

		Send ^!d ; Deselect clips
		Sleep, 10

		Send ^p
		Sleep, 1

		Send ^p ; Toggle "selection follows playhead"
	}
}


addGain(amount := 7)
{
Send {F2}
Sleep, 5
Send %amount%
Sleep, 5
Send {enter}
}



marker(){
SendInput, ^!+k ; Shuttle stop
Sleep, 5
Send ^{SC027} ; Create marker ;; Note: SC027 is Semicolon
}


closeTitler()
{
	CoordMode, Mouse, Screen
	CoordMode, Pixel, Screen
	MouseGetPos, xpos, ypos

	CoordMode, Mouse, Client
	CoordMode, Pixel, Client
	WinGetActiveStats, Title, Width, Height, X, Y

	Title := """" . Title . """"

	IfInString, Title, "Marker @"
	{
		Send, +{tab}
		Sleep, 10
		send {enter}
	}
	else
	{
		MouseMove, Width-35, -15, 0 ; Move cursor to X button

		Click left
		Sleep, 50

		CoordMode, Mouse, screen
		CoordMode, Pixel, screen
		MouseMove, %xpos%, %ypos%, 0 ; Move cursor to original coordinates
		ToolTip, 
	}
}



; Clicks transform icon in effect controls ;; Note: This function actually does everything that "Activate Direct Manipulation in Program Monitor" should do
clickTransformIcon2()
{
	; Determining whether a clip is selected or not would waste time, thus the method below
	; prFocus("Effect Controls")
	; SendInput, {F10} ; Effect controls
	; Sleep, 10

	; Send {tab}
	; if (A_CaretX = "")
	; {
	; 	; No caret found. Therefore, no clip is selected.
	; 	; Select the top clip at the playhead
	; 	Send ^p ; Selection follows playhead
	; 	Sleep, 10
	; 	Send ^p
	; }

	SendInput, {F5} ; Activate Direct Manipulation in Program Monitor. In case a MOGRT is selected

	Sleep, 5

	BlockInput, On
	BlockInput, MouseMove
	SetKeyDelay, 0

	SendInput, {F22} ; Effect controls

	Sleep, 20
	MouseGetPos, xpos, ypos
	ControlGetPos, X, Y, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro, DroverLord - TabPanel Window ; Effect controls ;; Note: The ClassX changes when moving panels around

	; X := X+85 ; For 150% DPI
	; Y := Y+100 ; For 150% DPI

	X := X+56 ;For 100% DPI
	Y := Y+66 ;For 100% DPI

	MouseMove, X, Y, 0
	MouseClick, Left

	MouseMove, %xpos%, %ypos%, 0 ; Move cursor to original coordinates

	BlockInput, Off
	BlockInput, MouseMoveOff

	Sleep, 20

	SendInput, {F16} ; Timeline
	Sleep, 10

	SendInput, {F5} ; Show direct clip manipulation. In case a MOGRT is selected

	Sleep, 10
	SendInput {F22} ; Effect controls
}





masterClipSelect() ; i never use this one
{
	BlockInput, On
	SetKeyDelay, 0
	SendInput ^!+5 ; Effect controls
	Sleep, 20

	;NEEDED - code that can tell if a clip is already selected or not. instantVFX uses that.

	; untwirl()
	Send {tab}
	if (A_CaretX = "")
	{
		; No caret found. Therefore, no clip is selected.
		; Select the top clip at the playhead
		Send ^p ; Selection follows playhead
		Sleep, 10
		Send ^p
	}

	MouseGetPos, xpos, ypos
	ControlGetPos, X, Y, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro, DroverLord - TabPanel Window

	X := X+85
	Y := Y+44

	MouseMove, X, Y, 0
	MouseClick, left

	; MouseMove, %xpos%, %ypos%, 0 ; Move cursor to original coordinates
	MouseMove, 250, 670, 0, R ; Moves cursor to the center of the master clip controls
	BlockInput, Off
}



; TODO: 
; ;EFFECT CONTROLS PANEL --- MOTION EFFECT TRIANGLE UNFURL CLICKER
; ;it's not intelligent though. it will only toggle.
; ;need to somehow combine this with the intelligent functionality below.
; ;watch the associated video for more information!
; ;   
; ~F4::
; Tippy("triangle unfurl - F4")
; BlockInput, on
; BlockInput, MouseMove
; SetKeyDelay, 0
; MouseGetPos, xpos, ypos
; ControlGetPos, X, Y, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro, DroverLord - TabPanel Window
; MouseMove, X+20, Y+94, 0
; MouseClick
; ;MouseMove, %xpos%, %ypos%, 0
; BlockInput, off
; BlockInput, MouseMoveOff
; Return


; Obsolete
clickTransformIcon()
{
	ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ;you will need to set this value to the window class of your own Effect Controls panel! Use window spy and hover over it to find that info.

	; Xcorner := Xcorner+83 ; For 150% DPI
	; Ycorner := Ycorner+98 ; For 150% DPI
	Xcorner := Xcorner+56 ; For 100% DPI
	Ycorner := Ycorner+66 ; For 100% DPI

	MouseMove, Xcorner, Ycorner, 0
	Sleep, 10
	MouseMove, Xcorner, Ycorner, 0 ; Move cursor twice, to make sure it moves
	MouseClick, left
}


;script to lock video and audio layers V1 and A1.
;I don't recommend that anyone else use this. It's really finnicky to set up. Requires a ton of very carefully taken screenshots in order to work...
tracklocker()
{
	BlockInput, On
	BlockInput, MouseMove
	MouseGetPos xPosCursor, yPosCursor

	xPos = 400
	yPos = 1050

	CoordMode Pixel, Screen
	CoordMode Mouse, Screen

	; if ErrorLevel = 1
		; ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_unlocked_untargeted_2018.png
	; if ErrorLevel = 1
		; ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_ALT_unlocked_untargeted_2018.png

	ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_ALT_unlocked_targeted_2019_ui100.png
	if ErrorLevel = 1
		ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_unlocked_targeted_2019_ui100.png

	if ErrorLevel = 1
	{
		; No unlocked was found
		goto try2
	}
	if ErrorLevel = 2
	{
		; Could not conduct the search
		goto resetlocker
	}
	if ErrorLevel = 0
	{
		MouseMove, FoundX+10, FoundY+10, 0 ; Move to V1
		Sleep, 5
		Click Left ; Click on V1
		MouseMove, FoundX+10, FoundY+60, 0 ; Move to A1
		Click Left ; Click on A1
		Sleep, 10
		goto resetlocker
	}
		
	try2:
	; ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, *2 %A_WorkingDir%\v1_ALT_locked_targeted_2018.1.png

	if ErrorLevel = 1
	{
		ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_ALT_locked_targeted_2019_ui100.png
	}
	if ErrorLevel = 1
	{
		; Alt Locked Targeted V1 could not be found on the screen
		ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\IDK_2.png
	}
	; if ErrorLevel = 1
	; {
		; Alt Locked Targeted V1 could not be found on the screen
		; ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_ALT_locked_untargeted.png
	; }
	if ErrorLevel = 2
	{
		; Could not conduct search
		goto resetlocker
	}
		
	if ErrorLevel = 0
	{
		; Found a locked lock
		MouseMove, FoundX_LOCK+10, FoundY_LOCK+10, 0 ; Move to A1
		Sleep, 5
		Click Left ; Click V1
		MouseMove, FoundX_LOCK+10, FoundY_LOCK+60, 0 ; Move to A1
		Click Left ; Click A1
		Sleep, 10
		goto resetlocker
	}

	resetlocker:
	MouseMove, xPosCursor, yPosCursor, 0 ; Move to original coordinates

	BlockInput, Off
	BlockInput, MouseMoveOff
	Sleep, 10
}


untwirl()
{
	dontrestart = 0

	prFocus("Effect Controls")
	Send {tab}
	if (A_CaretX = "")
	{
		; No caret found. Therefore, no clip is selected.
		; Select the top clip at the playhead
		Send ^p ; Selection follows playhead
		Sleep, 10
		Send ^p
		If (dontrestart = 0)
		{
			dontrestart = 1
			goto, restartPoint2
		}

		Return "reset"
	}



	restartPoint2:
	ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ; Effect controls ;; Note: The ClassX changes when moving panels around
	;I might need a far more robust way of ensuring the effect controls panel has been located, in the future.

	;move mouse to expected triangle location. this is a VERY SPECIFIC PIXEL which will be right on the EDGE of the triangle when it is OPEN.
	;This takes advantage of the anti-aliasing between the color of the triangle, and that of the background behind it.
	;these pixel numbers will be DIFFERENT depending upon the RESOLUTION and UI SCALING of your monitor(s)
	; YY := Ycorner+99 ; For 150% DPI
	; XX := Xcorner+19 ; For 150% DPI
	YY := Ycorner+66 ;For 100% DPI
	XX := Xcorner+13 ;For 100% DPI
	MouseMove, XX, YY, 0
	Sleep, 10

	PixelGetColor, colorr, XX, YY

	if (colorr = "0x353535") ; For 150% DPI
	if (colorr = "0x222222") ; For 100% DPI
	{ ; Opened triangle
		BlockInput, Mouse
		Click XX, YY
		Sleep, 5

		Return "untwirled"
		; clickTransformIcon()
		; findVFX(foobar)
	}
	;else if (colorr = "0x757575") ; For 150% DPI
	else if (colorr = "0x7A7A7A") ; For 100% DPI
	{ ; Closed triangle
		BlockInput, Mouse
		Sleep, 5
		; untwirled = 1
		
		Return "untwirled"
		; clickTransformIcon()
		; findVFX(foobar)
		
	}
	else if (colorr = "0x1D1D1D" || colorr = "0x232323")
	{ ; Normal panel color (no clip has been selected)
		; No caret found. Therefore, no clip is selected.
		; Select the top clip at the playhead
		Send ^p ; Selection follows playhead
		Sleep, 10
		Send ^p
			
		;resetFromAutoVFX()

		; The motion menu is now open. This label has to be ran once more
		If (dontrestart = 0)
		{
			dontrestart = 1
			goto, restartPoint2
		}

		Return "reset"
	}
	else
	{
		Return "reset"
		; resetFromAutoVFX()
	}
}



; Note: Text will be different if you change ClearType settings in Windows
instantVFX(foobar)
{
	dontrestart = 0
	restartPoint:
	BlockInput, SendAndMouse
	BlockInput, MouseMove
	BlockInput, On

	;-SendInput ^!+5

	;clickTransformIcon()

	prFocus("effect controls")
	Sleep, 10


	; Send {tab}
	; if (A_CaretX = "")
	; {
		; No caret found. Therefore, no clip is selected.
		; Select the top clip at the playhead
		; Send ^p ; Selection follows playhead
		; Sleep, 10
		; Send ^p
	; }


	MouseGetPos Xbeginlol, Ybeginlol
	global Xbegin = Xbeginlol
	global Ybegin = Ybeginlol

	ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ; Effect controls ;; Note: The ClassX changes when moving panels around

	; YY := Ycorner+99 ; For 150% DPI
	; XX := Xcorner+19 ; For 150% DPI
	YY := Ycorner+66 ; For 100% DPI
	XX := Xcorner+13 ; For 100% DPI

	MouseMove, XX, YY, 0 ; Move cursor to a pixel right on the edge of the triangle when it is open
	Sleep, 10

	PixelGetColor, colorr, XX, YY

	; if (colorr = "0x353535") ; For 150% DPI
	if (colorr = "0x222222") ; For 100% DPI
	{ ; Closed triangle
		BlockInput, Mouse
		Click XX, YY
		Sleep, 5
		clickTransformIcon()
		findVFX(foobar)
		Return
	}
	;else if (colorr = "0x757575") ; For 150% DPI
	else if (colorr = "0x7A7A7A") ; For 100% DPi
	{ ; Opened triangle
		BlockInput, Mouse
		Sleep, 5
		clickTransformIcon()
		findVFX(foobar)

		;untwirled = 1
		Return, untwirled
	}
	else if (colorr = "0x1D1D1D" || colorr = "0x232323")
	{ ; Normal panel color (no clip has been selected)
		; No caret found. Therefore, no clip is selected.
		; Select the top clip at the playhead
		Send ^p ; Selection follows playhead
		Sleep, 10
		Send ^p

		resetFromAutoVFX()

		; The motion menu is now open. This label has to be ran once more
		If (dontrestart = 0)
		{
			dontrestart = 1
			goto, restartPoint2
		}

		Return reset
	}
	else
	{
		resetFromAutoVFX()
		Return reset
	}

	return ; from autoscaler part 1
}




findVFX(foobar) ; searches for text inside of the Motion effect. requires an actual image.
{
	Sleep, 5
	MouseGetPos xPos, yPos
	; CoordMode Pixel, Screen

	; ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+500, %A_WorkingDir%\%foobar%_D2017.png
	; ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2018.png
	; ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2019.png

	ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2019_ui100.png
	;within 0 shades of variation (this is much faster)

	if ErrorLevel = 1
	{
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %A_WorkingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
		;MsgBox, whwhwuhuat
		ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %A_WorkingDir%\%foobar%_D2019_ui100.png
	}
	if ErrorLevel = 2
	{
		; Could not conduct the search
		resetFromAutoVFX()
		Return
	}
	if ErrorLevel = 1
	{
		; %foobar% could not be found on the screen
		resetFromAutoVFX()
		Return
	}
	else
	{
		MouseMove, FoundX, FoundY, 0
		Sleep, 5
		findHotText(foobar)
		Return
	}
}


;2d8ceb
findHotText(foobar)
{
	ToolTip, ; Remove any tooltips that might be in the way of the searcher.
	; CoordMode Pixel
	MouseGetPos, xxx, yyy

	if (foobar = "scale" ||  foobar = "anchor_point" || foobar = "rotation")
	{
		; PixelSearch, Px, Py, xxx+50, yyy, xxx+350, yyy+11, 0x3398EE, 30, Fast RGB
		PixelSearch, Px, Py, xxx+50, yyy, xxx+250, yyy+11, 0x2d8ceb, 30, Fast RGB ; Search to the right, looking the blueness of the scrubbable hot text. Unfortunately, it sees to start looking from right to left, so if your window is sized too small, it'll possibly latch onto the blue of the playhead/CTI. Technically, I could check to see the size of the Effect controls panel FIRST, and then allow the number that is currently 250 to be less than half that, but I haven't run into too much trouble so far...
	}
	else if (foobar = "anchor_point_vertical")
	{
		;ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019.png ; For 150% DPI
		ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019_ui100.png ; For 100% DPI
		if ErrorLevel = 1
			ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019_2.png
	}

	; ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, %A_WorkingDir%\anchor_point_D2017.png
	; ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, %A_WorkingDir%\anti-flicker-filter_000.png

	if ErrorLevel
	{
		; Blue not found
		Sleep, 100
		resetFromAutoVFX()
		return ;i am not sure if this is needed.
	}
	else
	{
		; A color within 30 shades of variation was found
		if (foobar <> "anchor_point_vertical")
			MouseMove, Px+10, Py+5, 0 ; Move the cursor to the scrubbable hot text

		else if (foobar = "anchor_point_vertical")
			MouseMove, Px+80, Py-20, 0 ; Move the cursor to the scrubbable hot text, this time, the vertical one instead of horizontal

		Click down left
		
		GetKeyState, stateFirstCheck, %VFXkey%, P
			
		if stateFirstCheck = U
		{ ; Some time has passed by now. Therefore, the user is long pressing the button. If so, manually enter values (or, previously, reset it to a hard coded value)
				Click up left
				Sleep, 10
				
				; The following code automatically resets values
				; if (foobar = "scale")
				; {
					; Send, 100
					; Sleep, 50
					; Send, {enter}
					; Sleep, 20
				; }
				; if (foobar = "rotation")
				; {
					; Send, 0
					; Sleep, 50
					; Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
					; Sleep, 20
				; }

				resetFromAutoVFX(0) ; 0 specifies to not click the timeline to focus it
				return
		}

		;Now we start the official loop, which will continue as long as the user holds down the VFXkey. They can now simply move the mouse to change the value of the hot text which has been automatically selected for them.
		Loop
		{
			BlockInput, off
			BlockInput, MouseMoveOff
			ToolTip, ; Remove tooltips
			Sleep, 15
			GetKeyState, state, %VFXkey%, P ; Note: This does not work if you are using parsec/teamviewer etc

			; NOW is when the user moves their mouse around to change the value of the hot text. You can also use SHIFT or CTRL to make it change faster or slower. Then release the VFX key to return to normal.
			
			if state = U
			{
				Click up left
				Sleep, 15
				resetFromAutoVFX(1) ; 0 specifies to not click the timeline to focus it
				MouseMove, Xbegin, Ybegin, 0
				Return
			}
		}
	}
}


resetFromAutoVFX(clicky := 0)
{
	global Xbegin
	global Ybegin
	MouseMove, Xbegin, Ybegin, 0
	
	if clicky = 1
	{
		Send, {MButton} ; Focus the panel that is being hovered
		clicky = 0
	}

	BlockInput, Off
	BlockInput, MouseMoveOff
}



SendKey(keyy, functionused := "", parameter := ""){
; keyShower(functionused, parameter)
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(functionused, parameter) 
}

SendInput {%keyy%}
Sleep, 100
}




stopPlaying() ; Play/pause Premiere when not in focus
{
	KeyWait, %A_priorhotkey% ; Avoid cross-talk

	; SendEvent, {blind}{lshift up}{lctrl up}{rshift up}{rctrl up}{ralt up}{lalt up}

	if WinActive("ahk_exe Adobe Premiere Pro.exe")
	{
		SendInput, {space}
		goto, stopPlayEND
	}

	if !WinActive("ahk_exe Adobe Premiere Pro.exe")
	{

	WinGetClass, lolclass, A

	; Keyshower("[WC1] pause/play Premiere when not active",,1,-400)
	if IsFunc("Keyshower") {
		Func := Func("Keyshower")
		RetVal := Func.Call("[WC1] pause/play Premiere when not active",,1,-400) 
	}

	; ControlFocus, DroverLord - Window Class3,ahk_exe Adobe Premiere Pro.exe ; The problem with this code is that it will focus the project panels on other monitors
	ControlFocus, DroverLord - Window Class3, Adobe Premiere Pro 2023 ; The title "Adobe Premiere Pro XXXX" is only present on the main window, not on other monitors
	; ControlFocus, DroverLord - Window Class46, Adobe Premiere Pro 2023 ; After adding frame.io and gettyimages extensions, the window class of the timeline changed.

	Sleep, 30

	; Switch to effect controls via shortcut, even if already in effect controls. This is to force the effect controls panel in case Window Class3 is not the effect controls panel anymore.
	ControlSend, DroverLord - Window Class3, ^+!5, Adobe Premiere Pro 2023 ; Effect Controls ;; Note: Switching to effect controls pauses videos in the source monitor, which is why it's here
	Sleep, 40

	ControlSend, DroverLord - Window Class3, ^+!5, Adobe Premiere Pro 2023
	Sleep, 10


	ControlSend,, {space}, ahk_exe Adobe Premiere Pro.exe
	; ControlSend, DroverLord - Window Class1, {space}, ahk_exe Adobe Premiere Pro.exe ; Might be a better solution


	; In case Premiere was activated, reactive the original window
	if not WinActive(lolClass)
		WinActivate, %lolclass%

	stopPlayEND:
	}
}



; Get information about a window without moving cursor to the coordinates
CoordGetControl(xCoord, yCoord, _hWin) ; _hWin is the ID of the active window
{
	; https://autohotkey.com/board/topic/84144-find-classnn-of-control-by-posxy-without-moving-mouse/
	
	CtrlArray := Object() 
	WinGet, ControlList, ControlList, ahk_id %_hWin%
	Loop, Parse, ControlList, `n
	{
		Control := A_LoopField
		ControlGetPos, left, top, right, bottom, %Control%, ahk_id %_hWin%
      right += left, bottom += top
		if (xCoord >= left && xCoord <= right && yCoord >= top && yCoord <= bottom)
			MatchList .= Control "|"
	}
	StringTrimRight, MatchList, MatchList, 1
	Loop, Parse, MatchList, |
	{
		ControlGetPos,,, w, h, %A_LoopField%, ahk_id %_hWin%
		Area := w * h
		CtrlArray[Area] := A_LoopField
	}
	for Area, Ctrl in CtrlArray
	{
		Control := Ctrl
		if A_Index = 1
			break
	}
	return w
}




easeInAndOut(){
	SendEvent, {blind}{LShift up}{LCtrl up}{RShift up}{RCtrl up}{RAlt up}{LAlt up} ; Unstick modifier keys

	Send, {blind}^+{f10} ; Ease in
	Sleep, 10
	Send, {blind}+{F10} ; Ease out
	Sleep, 5

	SendEvent, {blind}{LShift up}{LCtrl up}{RShift up}{RCtrl up}{RAlt up}{LAlt up} ; Unstick modifier keys

}

isPremiereUnderCursor(yesno := 1)
{
	MouseGetPos,,,KDE_id
	WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
	WinGetClass,fancyclass,ahk_id %KDE_id%

	If (fancyclass = "DroverLord - Window Class") ; When using a Premiere window that isn't connected to the main window
	{
		return 1
	}
	else If (fancyclass != "Premiere Pro")
	{
		WinActivate, ahk_id %KDE_id%
		return 0
	}
	else
		return 1
}