#Requires AutoHotkey v2.0

; ========================================================
; Emacs-like keybindings for Windows (AHK v2)
; ========================================================

SetCapsLockState("AlwaysOff")
#UseHook
SendMode("Event")

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

clear_ctrl_x_pending() {
    global gIsCtrlXPressed
    gIsCtrlXPressed := false
}

set_ctrl_x_pending() {
    global gIsCtrlXPressed
    gIsCtrlXPressed := true
    ; Auto-clear after 2s so a missed follow-up key (s / , / .) doesn't
    ; leave the flag stuck true and swallow the next normal keystroke.
    SetTimer(clear_ctrl_x_pending, -2000)
}

reset_all_status() {
    global gIsMarkDown, gIsSearching
    reset_pre_keys()
    gIsMarkDown := false
    gIsSearching := false
}

IsTerminal() {
    try {
        winExe := WinGetProcessName("A")
        return (winExe = "WindowsTerminal.exe") or (winExe = "powershell.exe") or (winExe = "pwsh.exe")
    } catch {
        return false
    }
}

IsEmacsTerminal() {
    ; Use active window title - Windows Terminal sets it to the focused tab's title
    try {
        winExe := WinGetProcessName("A")
        if not ((winExe = "WindowsTerminal.exe") or (winExe = "powershell.exe"))
            return false
        winTitle := WinGetTitle("A")
        return InStr(winTitle, "emacs", false)
    } catch {
        return false
    }
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
    Send("+{End}{BS}")
    reset_all_status()
}

kill_line_backward() {
    Send("+{Home}{BS}")
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

; --------------------------------------------------------
; CapsLock = Ctrl passthrough for terminal (catch-all)
; Only active when Emacs is running inside the terminal
; --------------------------------------------------------
#HotIf IsEmacsTerminal()
CapsLock & a:: Send("{Blind}^a")
CapsLock & b:: Send("{Blind}^b")
CapsLock & c:: Send("{Blind}^c")
CapsLock & d:: Send("{Blind}^d")
CapsLock & e:: Send("{Blind}^e")
CapsLock & f:: Send("{Blind}^f")
CapsLock & g:: Send("{Blind}^g")
CapsLock & h:: Send("{Blind}^h")
CapsLock & i:: Send("{Blind}^i")
CapsLock & j:: Send("{Blind}^j")
CapsLock & k:: Send("{Blind}^k")
CapsLock & l:: Send("{Blind}^l")
CapsLock & m:: Send("{Blind}^m")
CapsLock & n:: Send("{Blind}^n")
CapsLock & o:: Send("{Blind}^o")
CapsLock & p:: Send("{Blind}^p")
CapsLock & q:: Send("{Blind}^q")
CapsLock & r:: Send("{Blind}^r")
CapsLock & s:: Send("{Blind}^s")
CapsLock & t:: Send("{Blind}^t")
CapsLock & u:: Send("{Blind}^u")
CapsLock & v:: Send("{Blind}^v")
CapsLock & w:: Send("{Blind}^w")
CapsLock & x:: Send("{Blind}^x")
CapsLock & y:: Send("{Blind}^y")
CapsLock & z:: Send("{Blind}^z")
CapsLock & Space:: Send("{Blind}^Space")
#HotIf

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
CapsLock & u:: kill_line_backward()
CapsLock & d:: delete_char()
CapsLock & h:: delete_backward_char()
CapsLock & m:: newline()
CapsLock & c:: {
    if IsTerminal()
        Send("{Blind}^c")
    else
        kill_region()
}
CapsLock & r:: {
    if IsTerminal()
        Send("{Blind}^r")
    else
        isearch_backward()
}
CapsLock & s:: {
    if IsTerminal()
        Send("{Blind}^s")
    else
        save_buffer()
}
CapsLock & w:: kill_ring_save()
CapsLock & y:: yank()
CapsLock & l:: Send("^l")
CapsLock & g:: {
    global gRedoMode
    gRedoMode := !gRedoMode
}
CapsLock & Space:: {
    global gIsMarkDown
    gIsMarkDown := !gIsMarkDown
}

; -----------------------
; Ctrl-based keys (pass through in terminal, emacs bindings elsewhere)
; -----------------------
^f:: {
    if IsTerminal()
        Send("{Blind}^f")
    else
        forward_char()
}
^b:: {
    if IsTerminal()
        Send("{Blind}^b")
    else
        backward_char()
}
^p:: {
    if IsTerminal()
        Send("{Blind}^p")
    else
        previous_line()
}
^n:: {
    if IsTerminal()
        Send("{Blind}^n")
    else
        next_line()
}
^a:: {
    if IsTerminal()
        Send("{Blind}^a")
    else
        move_beginning_of_line()
}
^e:: {
    if IsTerminal()
        Send("{Blind}^e")
    else
        move_end_of_line()
}
^k:: {
    if IsTerminal()
        Send("{Blind}^k")
    else
        kill_line()
}
^u:: {
    if IsTerminal()
        Send("{Blind}^u")
    else
        kill_line_backward()
}
^d:: {
    if IsTerminal()
        Send("{Blind}^d")
    else
        delete_char()
}
^h:: {
    if IsTerminal()
        Send("{Blind}^h")
    else
        delete_backward_char()
}
^m:: {
    if IsTerminal()
        Send("{Blind}^m")
    else
        newline()
}
^i:: {
    if IsTerminal()
        Send("{Blind}^i")
    else
        indent_for_tab_command()
}
^y:: {
    if IsTerminal()
        Send("{Blind}^y")
    else
        yank()
}
^z:: {
    if IsTerminal()
        Send("{Blind}^z")
    else
        undo()
}
^x:: {
    if IsTerminal() {
        Send("{Blind}^x")
        return
    }
    set_ctrl_x_pending()
}
^s:: {
    global gIsCtrlXPressed
    if IsTerminal() {
        Send("{Blind}^s")
        return
    }
    if gIsCtrlXPressed
        save_buffer()
    else
        isearch_forward()
}
^r:: {
    if IsTerminal()
        Send("{Blind}^r")
    else
        isearch_backward()
}
^Space:: {
    global gIsMarkDown
    gIsMarkDown := !gIsMarkDown
}
^g:: {
    global gIsMarkDown, gRedoMode
    if IsTerminal()
        Send("{Blind}^g")
    else {
        gIsMarkDown := false
        gRedoMode := !gRedoMode
    }
}
^w:: {
    if IsTerminal()
        Send("{Blind}^w")
    else
        kill_region()
}
^o:: {
    if IsTerminal()
        Send("{Blind}^o")
    else
        find_file()
}
^v:: {
    if IsTerminal()
        Send("{Blind}^v")
    else
        scroll_down()
}

; -----------------------
; Escape key
; -----------------------
Esc:: {
    global gIsEscapePressed
    if IsTerminal() {
        Send("{Blind}{Esc}")
        return
    }
    if gIsEscapePressed {
        Send "{Esc}"
        gIsEscapePressed := false
    } else {
        gIsEscapePressed := true
    }
}

; -----------------------
; Alt-based keys
; Outside Emacs terminal: Alt acts as Ctrl
; Inside Emacs terminal: Alt passes through as real Alt
; -----------------------
#HotIf !IsEmacsTerminal()
Alt & a:: Send("^a")
Alt & b:: Send("^b")
Alt & c:: Send("^c")
Alt & d:: Send("^d")
Alt & e:: Send("^e")
Alt & f:: Send("^f")
Alt & g:: Send("^g")
Alt & h:: Send("^h")
Alt & i:: Send("^i")
Alt & j:: Send("^j")
Alt & k:: Send("^k")
Alt & l:: Send("^l")
Alt & m:: Send("^m")
Alt & n:: Send("^n")
Alt & o:: Send("^o")
Alt & p:: Send("^p")
Alt & q:: Send("^q")
Alt & r:: Send("^r")
Alt & s:: Send("^s")
Alt & t:: Send("^t")
Alt & u:: Send("^u")
Alt & v:: Send("^v")
Alt & w:: Send("^w")
Alt & x:: Send("^x")
Alt & y:: Send("^y")
Alt & z:: Send("^z")
Alt & 1:: Send("^1")
Alt & 2:: Send("^2")
Alt & 3:: Send("^3")
Alt & 4:: Send("^4")
Alt & 5:: Send("^5")
Alt & 6:: Send("^6")
Alt & 7:: Send("^7")
Alt & 8:: Send("^8")
Alt & 9:: Send("^9")
Alt & 0:: Send("^0")
Alt & Tab:: Send("^{Tab}")
Alt & Enter:: Send("^{Enter}")
Alt & Space:: Send("^{Space}")
Alt & Left:: Send("^{Left}")
Alt & Right:: Send("^{Right}")
Alt & Up:: Send("^{Up}")
Alt & Down:: Send("^{Down}")
Alt & Home:: Send("^{Home}")
Alt & End:: Send("^{End}")
Alt & PgUp:: Send("^{PgUp}")
Alt & PgDn:: Send("^{PgDn}")
Alt & BS:: Send("^{BS}")
Alt & Del:: Send("^{Del}")
#HotIf

; --------------------------------------------------------
; Initialize
; --------------------------------------------------------
SetCapsLockState("AlwaysOff")

; CapsLock + - => undo or redo
CapsLock & -:: {
    global gRedoMode
    if (gRedoMode)
        Send("^y")
    else
        Send("^z")
    reset_pre_keys()
}

; CapsLock+X => set flag (or pass through in terminal)
CapsLock & x:: {
    if IsTerminal() {
        Send("{Blind}^x")
        return
    }
    set_ctrl_x_pending()
    return
}

; CapsLock+X then s => save-all
s:: {
    global gIsCtrlXPressed
    if gIsCtrlXPressed {
        gIsCtrlXPressed := false
        save_all_buffers()
    } else
        Send("{Blind}s")
}

; C-x , => beginning of buffer
,:: {
    global gIsCtrlXPressed
    if gIsCtrlXPressed
        beginning_of_buffer()
    else
        Send("{Blind},")
}

; C-x . => end of buffer
.:: {
    global gIsCtrlXPressed
    if gIsCtrlXPressed
        end_of_buffer()
    else
        Send("{Blind}.")
}

SC056::Send("``")
+SC056::Send("~")

#HotIf WinActive("ahk_exe chrome.exe")
^w::return        ; block Ctrl+W (close tab)
^t::return        ; block Ctrl+T (new tab)
^r::return        ; block Ctrl+R (refresh)
^l::return        ; block Ctrl+L (address bar)
CapsLock & -::return        ; block Ctrl+L (address bar)
#HotIf
