;;
;; An AutoHotKey script for Emacs-like key-bindings on Windows
;;
#InstallKeybdHook
#UseHook

;https://gist.github.com/Danik/5808330
#Persistent
SetCapsLockState, AlwaysOff

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay 0

; turns to be 1 when ctrl-x is pressed
is_pre_x = 0
; turns to be 1 when ctrl-space is pressed
is_pre_spc = 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target()
{
  IfWinActive,ahk_class ConsoleWindowClass ; Cygwin
    Return 1
  IfWinActive,ahk_class MEADOW ; Meadow
    Return 1
  IfWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0
    Return 1
  IfWinActive,ahk_class MozillaUIWindowClass ; keysnail on Firefox
    Return 1
  ; Avoid VMwareUnity with AutoHotkey
  IfWinActive,ahk_class VMwareUnityHostWndClass
    Return 1
  IfWinActive,ahk_class Vim ; GVIM
    Return 1
;  IfWinActive,ahk_class SWT_Window0 ; Eclipse
;    Return 1pr
;   IfWinActive,ahk_class Xming X
;     Return 1
;   IfWinActive,ahk_class SunAwtFrame
;     Return 1
;   IfWinActive,ahk_class Emacs ; NTEmacs
;     Return 1  
;   IfWinActive,ahk_class XEmacs ; XEmacs on Cygwin
;     Return 1
  Return 0
}

delete_char()
{
  Send {Del}
  global is_pre_spc = 0
  Return
}

delete_backward_char()
{
  Send {BS}
  global is_pre_spc = 0
  Return
}

kill_line()
{
  Send {ShiftDown}{END}{SHIFTUP}
  Sleep 50 ;[ms] this value depends on your environment
  Send ^x
  global is_pre_spc = 0
  Return
}

open_line()
{
  Send {END}{Enter}{Up}
  global is_pre_spc = 0
  Return
}

; Escape (or another key) to cancel selection mode
Esc::
{
    selectionMode := false
    return
}

quit()
{
  Send {ESC}
  global is_pre_spc = 0  
  Return
}

newline()
{
  Send {Enter}
  global is_pre_spc = 0
  Return
}

indent_for_tab_command()
{
  Send {Tab}
  global is_pre_spc = 0
  Return
}

newline_and_indent()
{
  Send {Enter}{Tab}
  global is_pre_spc = 0
  Return
}

isearch_forward()
{
  Send ^f
  global is_pre_spc = 0
  Return
}

isearch_backward()
{
  Send ^f
  global is_pre_spc = 0
  Return
}

kill_region()
{
  Send ^x
  global is_pre_spc = 0
  Return
}

kill_ring_save()
{
  Send ^c
  global is_pre_spc = 0
  Return
}

yank()
{
  Send ^v
  global is_pre_spc = 0
  Return
}

undo()
{
  Send ^z
  global is_pre_spc = 0
  Return
}

find_file()
{
  Send ^o
  global is_pre_x = 0
  Return
}

save_buffer()
{
  Send, ^s
  global is_pre_x = 0
  Return
}

kill_emacs()
{
  Send !{F4}
  global is_pre_x = 0
  Return
}

move_beginning_of_line()
{
  global
  if is_pre_spc
    Send +{HOME}
  Else
    Send {HOME}
  Return
}

move_end_of_line()
{
  global
  if is_pre_spc
    Send +{END}
  Else
    Send {END}
  Return
}

previous_line()
{
  global
  if WinActive("ahk_class Framework::CFrame")
  {
    Send ^{Up}
    Return
  }
  if is_pre_spc
    Send +{Up}
  Else
    Send {Up}
  Return
}

next_line()
{
  global
  if WinActive("ahk_class Framework::CFrame")
  {
    Send ^{Down}
    Return
  }
  if is_pre_spc
    Send +{Down}
  Else
    Send {Down}
  Return
}

forward_char()
{
  global
  if is_pre_spc
    Send +{Right}
  Else
    Send {Right}
  Return
}

backward_char()
{
  global
  if is_pre_spc
    Send +{Left}
  Else
    Send {Left}
  Return
}

scroll_up()
{
  global
  if is_pre_spc
    Send +{PgUp}
  Else
    Send {PgUp}
  Return
}

scroll_down()
{
  global
  if is_pre_spc
    Send +{PgDn}
  Else
    Send {PgDn}
  Return
}

CapsLock & f::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
      forward_char()
  }
  Return
 
CapsLock & c:: Send ^c
CapsLock & s:: Send ^s
CapsLock & v:: Send ^v
CapsLock & z:: Send ^z
CapsLock & x:: Send ^x
CapsLock & t:: Send ^t
CapsLock & l:: Send ^l
CapsLock & w:: Send ^w

CapsLock & k::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_line()
  Return

CapsLock & a::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_beginning_of_line()
  Return

CapsLock & e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_end_of_line()
  Return

CapsLock & p::
  If is_target()
    Send %A_ThisHotkey%
  Else
    previous_line()
  Return

CapsLock & n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    next_line()
  Return

CapsLock & b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    backward_char()
  Return

CapsLock & Space::
  If is_target()
     Send %A_ThisHotkey%
  Else
     Send ^{space}

CapsLock & d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {Del}
  Return

CapsLock & h::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_backward_char()
  Return

CapsLock & m::
  If is_target()
    Send %A_ThisHotkey%
  Else
    newline()
  Return

CapsLock & y::
  If is_target()
    Send %A_ThisHotkey%
  Else
    yank()
  Return

^m::
  If is_target()
    Send %A_ThisHotkey%
  Else
    newline()
  Return

^h::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_backward_char()
  Return

^a::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_beginning_of_line()
  Return

^e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_end_of_line()
  Return

^p::
  If is_target()
    Send %A_ThisHotkey%
  Else
    previous_line()
  Return

^n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    next_line()
  Return

^b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    backward_char()
  Return

^k::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_line()
  Return

^f::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
      forward_char()
  }
  Return

^d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {Del}
  Return

select_all()
{
  Send, ^a
  global is_pre_x = 0
  Return
}

Alt & a::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
      select_all()
  }
  Return

alt_copy()
{
  Send, ^c
  global is_pre_x = 0
  Return
}

Alt & c::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
      alt_copy()
  }
  Return

alt_paste()
{
  Send, ^v
  global is_pre_x = 0
  Return
}

Alt & v::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
      alt_paste()
  }
  Return

alt_search()
{
  Send, ^f
  global is_pre_x = 0
  Return
}

Alt & f::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
      alt_search()
  }
  Return
  
 alt_x()
{
  Send, ^x
  global is_pre_x = 0
  Return
}

Alt & x::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
      alt_x()
  }
  Return

^y::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
      alt_paste()
  }
  Return
      
  Alt & w::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_region()
  Return
  
  ^v::
  If is_target()
    Send %A_ThisHotkey%
  Else
    scroll_down()
  Return
  
  Alt & b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    scroll_up()
  Return
  
^w::
{
    Send ^x  ; Sends Ctrl+X to cut the selected text
    return
}

^i::  ; Ctrl+Shift+W to copy the word under the cursor
{
    ; Save the original clipboard
    ClipSaved := ClipboardAll
    Clipboard := ""  ; Clear clipboard

    ; Move to the start of the word and select it
    Send ^{Left}  ; Move to start of current/previous word
    Send ^+{Right}  ; Select the word

    ; Copy the selection
    Send ^c
    ClipWait, 1  ; Wait up to 1 second for clipboard to update
    if ErrorLevel
    {
        MsgBox Failed to copy word.
    }
    else
    {
        ; Optional: show tooltip
        ToolTip Copied: %Clipboard%
        SetTimer, HideToolTip, -1000
    }

    ; Restore original clipboard if needed (optional)
    ; Clipboard := ClipSaved		
    return
}

^-::  ; Ctrl + Shift + 8 = *
{
    Send ^z  ; Send Ctrl+Z for undo
    return
}

; Global flag for selection mode
selectionMode := false

; Ctrl+Space toggles selection mode ON/OFF
^Space::
{
    selectionMode := !selectionMode
    if (selectionMode) {
        ToolTip Selection Mode ON
    } else {
        ToolTip Selection Mode OFF
    }
    SetTimer, HideToolTip, -1000
    return
}

; Ctrl+G exits selection mode and also sends Escape (quit)
^g::
{
    if (selectionMode) {
        selectionMode := false
        ToolTip Selection Mode OFF
        SetTimer, HideToolTip, -1000
    }
    Send {Esc}  ; Send Escape to quit/cancel
    return
}

; Movement keys while in selection mode
#If (selectionMode)
^n::Send +{Down}
^p::Send +{Up}
^f::Send +{Right}
^b::Send +{Left}
^a::Send +{Home}  
#If

HideToolTip:
ToolTip
return
