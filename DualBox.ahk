#NoEnv
SendMode Input
#IfWinActive, AION Client
CoordMode, ToolTip, Client
Suspend

;Second character name here
global CharName := "RandomChanter"
global aionPID

;Here i get active window pid
TrayTip, Instructions:, Open the Aion window where you want to DualBox
loop
{
	IfWinActive, AION Client (64bit)
	{
		WinGet, aionPID, PID, A
		break
	}
	sleep, 500
}
TrayTip, Hooked!
return

;Hotkey to switch between clients
Ins::
Suspend
ShowTooltip()
return

;Hotkey to follow main character
Del::
SendCommand("/follow " CharName)
return

;Skill Hotkeys (They work with Ctrl,Shift,Alt Modifiers)
*1::
SendAion(1)
return

*2::
SendAion(2)
return

*3::
SendAion(3)
return

*4::
SendAion(4)
return

*5::
SendAion(5)
return

*6::
SendAion(6)
return

*7::
SendAion(7)
return

*8::
SendAion(8)
return

*9::
SendAion(9)
return

*0::
SendAion(0)
return


;Function to show if its enabled
ShowTooltip()
{
	global toggle
	if (!toggle)
	{
		tooltip, Sending to %CharName%, 0, 0
		toggle := true
	}
	else
	{
		tooltip
		toggle := false
	}		
}

;using workaround here because chat bugs otherwise
SendCommand(command)
{
	SendAion("{Enter}")
	SendAion(U(command))
	SendAion("{Enter}")
}

SendAion(keys)
{
	ControlSend,, %keys%, ahk_pid %aionPID%
}

;workaround from https://autohotkey.com/board/topic/92360-controlsend-messes-up-modifiers/
U(in)
{
    fi := A_FormatInteger
    SetFormat IntegerFast, Hex
    Loop Parse, in
        out .= "{U+" Asc(A_LoopField) "}"
    SetFormat IntegerFast, %fi%
    return "{Blind}" out
}