#Requires AutoHotkey v2.0

; ========================================================
; Emacs-like keybindings for Windows (AHK v2)
; ========================================================

SetCapsLockState("AlwaysOff")
#UseHook

; --------------------------------------------------------
; Global flags
; --------------------------------------------------------
global gIsCtrlXPressed := false
global gIsMarkDown := false
global gIsEscapePressed := false
global gIsSearching := false
global gRedoMode := false

; --------------------------------------------------------
; Utility functions
; --------------------------------------------------------
reset_pre_keys() {
    global gIsCtrlXPressed, gIsEscapePressed
    gIsCtrlXPressed := false
    gIsEscapePressed := false
}

reset_all_status() {
    global gIsMarkDown, gIsSearching
    reset_pre_keys()
    gIsMarkDown := false
    gIsSearching := false
}

delete_char() {
    Send("{Del}")
    reset_all_status()
}

delete_backward_char() {
    Send("{BS}")
    reset_all_status()
}

kill_line() {
    Send("{Shift Down}{End}{Shift Up}")
    Sleep 50
    Send("^x")
    reset_all_status()
}

open_line() {
    Send("{End}{Enter}{Up}")
    reset_all_status()
}

newline() {
    Send("{Enter}")
    reset_all_status()
}

indent_for_tab_command() {
    Send("{Tab}")
    reset_all_status()
}

newline_and_indent() {
    Send("{Enter}{Tab}")
    reset_all_status()
}

isearch_forward() {
    global gIsSearching
    if gIsSearching
        Send("{F3}")
    else {
        Send("^f")
        gIsSearching := true
    }
    reset_pre_keys()
}

isearch_backward() {
    global gIsSearching
    if gIsSearching
        Send("+{F3}")
    else {
        Send("^f")
        gIsSearching := true
    }
    reset_pre_keys()
}

kill_region() {
    Send("^c")
    reset_all_status()
}

kill_ring_save() {
    Send("^c")
    reset_all_status()
}

yank() {
    Send("^v")
    reset_all_status()
}

undo() {
    Send("^z")
    reset_all_status()
}

find_file() {
    Send("^o")
    reset_all_status()
}

save_buffer() {
    Send("^s")
    reset_all_status()
}

save_all_buffers() {
    Send("^!s")
    reset_all_status()
}

kill_window() {
    Send("!{F4}")
    reset_all_status()
}

beginning_of_buffer() {
    global gIsMarkDown
    if gIsMarkDown
        Send("+^{Home}")
    else
        Send("^{Home}")
    reset_pre_keys()
}

end_of_buffer() {
    global gIsMarkDown
    if gIsMarkDown
        Send("+^{End}")
    else
        Send("^{End}")
    reset_pre_keys()
}

kill_buffer() {
    Send("^w")
    reset_all_status()
}

move_beginning_of_line() {
    global gIsMarkDown
    if gIsMarkDown
        Send("+{Home}")
    else
        Send("{Home}")
    reset_pre_keys()
}

move_end_of_line() {
    global gIsMarkDown
    if gIsMarkDown
        Send("+{End}")
    else
        Send("{End}")
    reset_pre_keys()
}

previous_line() {
    global gIsMarkDown
    if gIsMarkDown
        Send("+{Up}")
    else
        Send("{Up}")
    reset_pre_keys()
}

next_line() {
    global gIsMarkDown
    if gIsMarkDown
        Send("+{Down}")
    else
        Send("{Down}")
    reset_pre_keys()
}

forward_char() {
    global gIsMarkDown
    if gIsMarkDown
        Send("+{Right}")
    else
        Send("{Right}")
    reset_pre_keys()
}

backward_char() {
    global gIsMarkDown
    if gIsMarkDown
        Send("+{Left}")
    else
        Send("{Left}")
    reset_pre_keys()
}

scroll_up() {
    global gIsMarkDown
    if gIsMarkDown
        Send("+{PgUp}")
    else
        Send("{PgUp}")
    reset_pre_keys()
}

scroll_down() {
    global gIsMarkDown
    if gIsMarkDown
        Send("+{PgDn}")
    else
        Send("{PgDn}")
    reset_pre_keys()
}

HideToolTip() {
    ToolTip()
}

; --------------------------------------------------------
; Hotkeys
; --------------------------------------------------------

; -----------------------
; CapsLock-based keys
; -----------------------
CapsLock & f:: forward_char()
CapsLock & b:: backward_char()
CapsLock & p:: previous_line()
CapsLock & n:: next_line()
CapsLock & a:: move_beginning_of_line()
CapsLock & e:: move_end_of_line()
CapsLock & k:: kill_line()
CapsLock & d:: delete_char()
CapsLock & h:: delete_backward_char()
CapsLock & m:: newline()
CapsLock & r:: {
    if WinActive("ahk_exe WindowsTerminal.exe") or WinActive("ahk_exe powershell.exe") or WinActive("ahk_exe Cursor.exe")
        Send("^r")
    else
        isearch_backward()
}
CapsLock & s:: {
    global gIsCtrlXPressed
    if WinActive("ahk_exe WindowsTerminal.exe") or WinActive("ahk_exe powershell.exe") or WinActive("ahk_exe Cursor.exe")
        Send("^s")
    else if gIsCtrlXPressed
        save_buffer()
    else
        isearch_forward()
}
CapsLock & w:: kill_ring_save()
CapsLock & y:: yank()
CapsLock & l:: Send("^l")
CapsLock & g:: {
    global gRedoMode
    if WinActive("ahk_exe WindowsTerminal.exe") or WinActive("ahk_exe powershell.exe") or WinActive("ahk_exe Cursor.exe")
        Send("^g")
    else {
        gRedoMode := !gRedoMode
    }
}
CapsLock & Space:: {
    global gIsMarkDown
    gIsMarkDown := !gIsMarkDown
}

; -----------------------
; Ctrl-based keys
; -----------------------
^f:: forward_char()
^b:: backward_char()
^p:: previous_line()
^n:: next_line()
^a:: move_beginning_of_line()
^e:: move_end_of_line()
^k:: kill_line()
^d:: delete_char()
^h:: delete_backward_char()
^m:: newline()
^i:: indent_for_tab_command()
^y:: yank()
^z:: undo()

^x:: {
    global gIsCtrlXPressed
    gIsCtrlXPressed := true
    return
}

^s:: {
    global gIsCtrlXPressed
    if WinActive("ahk_exe WindowsTerminal.exe") or WinActive("ahk_exe powershell.exe") or WinActive("ahk_exe Cursor.exe") {
        Send("{Blind}^s")
        return
    }
    if gIsCtrlXPressed
        save_buffer()
    else
        isearch_forward()
}

^r:: {
    if WinActive("ahk_exe WindowsTerminal.exe") or WinActive("ahk_exe powershell.exe") or WinActive("ahk_exe Cursor.exe")
        Send("^r")
    else
        isearch_backward()
}

^Space:: {
    global gIsMarkDown
    gIsMarkDown := !gIsMarkDown
}

^g:: {
    global gIsMarkDown
    if WinActive("ahk_exe WindowsTerminal.exe") or WinActive("ahk_exe powershell.exe") or WinActive("ahk_exe Cursor.exe")
        Send("^g")
    else {
        gIsMarkDown := false
        Send("{Esc}")
    }
}

^w:: kill_region()
!w:: kill_ring_save()
^o:: find_file()
!v:: scroll_up()
^v:: scroll_down()

; -----------------------
; Escape key
; -----------------------
Esc:: {
    global gIsEscapePressed
    if gIsEscapePressed {
        Send "{Esc}"
        gIsEscapePressed := false
    } else {
        gIsEscapePressed := true
    }
}

; -----------------------
; Alt-based keys
; -----------------------
Alt & a:: Send("^a") ; select all
Alt & c:: Send("^c")
Alt & v:: Send("^v")
Alt & f:: Send("^f")
LAlt & x:: Send("^x")
Alt & w:: kill_region()
Alt & b:: scroll_up()
Alt & p:: scroll_up()   ; Page Up
Alt & n:: scroll_down() ; Page Down

; --------------------------------------------------------
; Initialize
; --------------------------------------------------------
SetCapsLockState("AlwaysOff")

; CapsLock + - → undo veya redo
CapsLock & -:: {
    global gRedoMode
    if (gRedoMode) {
        Send("^y")   ; redo (Ctrl+Y is standard redo)
        gRedoMode := false
    } else {
        Send("^z")   ; undo
    }
    reset_pre_keys()
}

; CapsLock+X → set flag (for save-all sequence)
CapsLock & x:: {
    global gIsCtrlXPressed
    gIsCtrlXPressed := true
    return
}

; CapsLock+X → s  =  save-all
s:: {
    global gIsCtrlXPressed
    if gIsCtrlXPressed {
        gIsCtrlXPressed := false
        save_all_buffers()
    } else
        Send("{Blind}s")
}

; C-x < → beginning of buffer
,:: {
    global gIsCtrlXPressed
    if gIsCtrlXPressed
        beginning_of_buffer()
    else
        Send("{Blind},")
}

; C-x . → end of buffer
.:: {
    global gIsCtrlXPressed
    if gIsCtrlXPressed
        end_of_buffer()
    else
        Send("{Blind}.")
}
