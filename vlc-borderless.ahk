#Requires AutoHotkey v2.0
#SingleInstance Force

; Ctrl+Alt+B  →  toggle the border/title bar on the focused window
^!b:: {
    WinSetStyle("^0xC40000", "A")   ; toggles caption (title bar) + sizing frame
}

; Hold Win + left-drag anywhere on a window  →  move it
#LButton:: {
    MouseGetPos(&startX, &startY, &win)
    if !win
        return
    WinGetPos(&winX, &winY, , , win)
    offsetX := startX - winX
    offsetY := startY - winY
    while GetKeyState("LButton", "P") {
        MouseGetPos(&curX, &curY)
        WinMove(curX - offsetX, curY - offsetY, , , win)
    }
}