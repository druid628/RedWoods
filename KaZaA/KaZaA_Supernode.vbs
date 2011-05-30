'KaZaA_SuperNode_fix - Fixes SuperNode Activity on KaZaA
'Version 1.0.2
'Thanks to CHRIS who broke it !!! Luzer
'(c)2002 Micah Breedlove
'This code may be freely distributed/modified

Option Explicit
On Error Resume Next

'Declare variables
Dim WSHShell, MyBox, p, q1, t, itemtype, thing
Dim jobfunc

'Set the Windows Script Host Shell and assign values to variables
Set WSHShell = WScript.CreateObject("WScript.Shell")
p = "HKEY_CURRENT_USER\Software\Kazaa\Advanced\SuperNode"
itemtype = "REG_DwORD"
q1 = 1

thing = WSHShell.RegRead(p)


If Len(thing) <> 0 Then
'WScript.Echo "The thing is: " & thing
	If thing = 0  Then
		WSHShell.RegWrite p, q1, "REG_DWORD"
		jobfunc = "KaZaA will no longer function as a supernode."
		t = "Confirmation"
		MyBox = MsgBox (jobfunc, 4096, t)
	Elseif thing = 1 Then
		jobfunc = "KaZaA is not functioning as a supernode."
		t = "Confirmation"
		MyBox = MsgBox (jobfunc, 4096, t)
	End If
Else
	jobfunc = "KaZaA does not exists on this machine."
	t = "KaZaA doesn't live here."
	MyBox = MsgBox (jobfunc, 4096, t)
End If
