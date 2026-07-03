\# VLC Borderless \& Draggable



A tiny \[AutoHotkey v2](https://www.autohotkey.com/) script that strips the title bar and border from any window (built with VLC in mind) and lets you drag it around by holding the \*\*Windows key\*\* — restoring the movement you'd normally lose along with the title bar.



Perfect for tucking a video into a corner or onto a second monitor while you work, without the window chrome getting in the way.



\---



\## Why this exists



VLC has a built-in frameless mode, but it comes with a dealbreaker: once the window decorations are gone, \*\*you can't move the window\*\* — there's no title bar to grab. This script fixes that by adding a "drag from anywhere" shortcut, so you get a truly borderless \*and\* movable window with no bloated third-party apps.



Although it's aimed at VLC, the script works on \*\*any\*\* window that has a standard title bar.



\---



\## Features



\- \*\*Toggle borderless\*\* — remove/restore the title bar and border of the focused window with one hotkey.

\- \*\*Drag from anywhere\*\* — hold `Win` + left-click-drag to move a borderless window (or any window).

\- Lightweight, no installation beyond AutoHotkey itself, no background bloat.



\---



\## Requirements



\- \*\*Windows\*\* (tested on Windows 10 / 11)

\- \*\*\[AutoHotkey v2](https://www.autohotkey.com/)\*\* — this script uses v2 syntax and will \*\*not\*\* run on v1.



\---



\## Installation



1\. Download and install \*\*AutoHotkey v2\*\* from \[autohotkey.com](https://www.autohotkey.com/).

2\. Download `vlc-borderless.ahk` from this repo (or copy the script below into a new `.ahk` file).

3\. Double-click the `.ahk` file to run it. A green \*\*H\*\* icon appears in your system tray (Windows 11 may hide it behind the `^` arrow) — that means it's running.



\---



\## Usage



| Hotkey | Action |

| --- | --- |

| `Ctrl` + `Alt` + `B` | Toggle the border/title bar on the focused window |

| `Win` + left-drag | Move the window under your cursor from anywhere |



\*\*Typical VLC workflow:\*\*



1\. Open your video in VLC (normal windowed mode — leave VLC's own frameless settings \*off\*; the script handles the border).

2\. Click the VLC window so it's focused.

3\. Press `Ctrl + Alt + B` — the title bar and border vanish.

4\. Hold `Win` and left-drag anywhere on the video to position it.

5\. Press `Ctrl + Alt + B` again to bring the border back.



> \*\*Tip:\*\* Combine with VLC's own `Ctrl + H` (minimal interface) to also hide VLC's menu and control bar, leaving just the video.



\---



\## The script



```autohotkey

\#Requires AutoHotkey v2.0

\#SingleInstance Force



; Ctrl+Alt+B  ->  toggle the border/title bar on the focused window

^!b:: {

&#x20;   WinSetStyle("^0xC40000", "A")   ; toggles caption (title bar) + sizing frame

}



; Hold Win + left-drag anywhere on a window  ->  move it

\#LButton:: {

&#x20;   MouseGetPos(\&startX, \&startY, \&win)

&#x20;   if !win

&#x20;       return

&#x20;   WinGetPos(\&winX, \&winY, , , win)

&#x20;   offsetX := startX - winX

&#x20;   offsetY := startY - winY

&#x20;   while GetKeyState("LButton", "P") {

&#x20;       MouseGetPos(\&curX, \&curY)

&#x20;       WinMove(curX - offsetX, curY - offsetY, , , win)

&#x20;   }

}

```



\---



\## Run at startup (optional)



To have the script available every time you log in:



1\. Press `Win + R`, type `shell:startup`, and press Enter.

2\. Drop a shortcut to your `.ahk` file into that folder.



It'll now launch automatically at login.



\---



\## Antivirus false positives



Some antivirus programs (Avast, AVG, and others) may flag AutoHotkey scripts like this one as suspicious or as a virus. \*\*This is a known false positive\*\*, not an actual infection.



The reason: to drag a window by its body and to toggle window styles, the script installs a system-wide input hook — it watches mouse/keyboard input and acts on it. That's mechanically the same technique keyloggers use, so heuristic antivirus engines flag it on suspicion, even though the script does nothing malicious. The full source is right here for you to read.



\*\*If your antivirus flags it:\*\*



\- Make sure you installed AutoHotkey from the official \*\*\[autohotkey.com](https://www.autohotkey.com/)\*\*.

\- Review the script above — it's short and does exactly what it says.

\- If you trust it, add an \*\*exception/exclusion\*\* for the script (and the AutoHotkey folder) in your antivirus settings.



> \*\*Note on lag:\*\* Some antivirus tools aggressively inspect the input hook in real time, which can make your mouse and keyboard feel extremely slow while the script runs. If that happens, a file-level exception may not be enough — you may also need to add an exclusion in your antivirus's \*\*behavior-monitoring / behavior-shield\*\* component specifically. If input becomes unresponsive, open \*\*Task Manager\*\* (`Ctrl + Alt + Del` still works) and end the AutoHotkey process to instantly restore normal input.



\*\*Never disable your antivirus entirely\*\* to run a script. Only add a targeted exception, and only if you've read the source and trust it.



\---



\## Troubleshooting



| Problem | Fix |

| --- | --- |

| No \*\*H\*\* icon in the tray | Check behind the `^` (show hidden icons) arrow on the taskbar. If still nothing, AutoHotkey may not be installed, or your antivirus removed it — reinstall from autohotkey.com. |

| Double-clicking the `.ahk` does nothing / opens Notepad | The file isn't associated with AutoHotkey. Right-click → \*\*Open with\*\* → AutoHotkey, or reinstall AHK to fix the association. |

| `Ctrl + Alt + B` does nothing | Another app may have claimed that hotkey. Change it in the script (see Customization). |

| Mouse/keyboard become very slow | Antivirus is inspecting the input hook — add a behavior-shield exception, or end the AHK process in Task Manager. |

| Window won't drag | Make sure you're holding the \*\*Windows key\*\* while left-dragging, and that the target window isn't maximized. |



\---



\## Customization



\*\*Change the toggle hotkey.\*\* Edit the `^!b` line. In AutoHotkey, `^` = Ctrl, `!` = Alt, `+` = Shift, `#` = Win. For example, `^!v` would be Ctrl+Alt+V.



\*\*Keep the resize border, drop only the title bar.\*\* Change the style value from `0xC40000` to `0xC00000`. That removes just the caption (`0xC00000`) and leaves the sizing frame (`0x40000`) intact.



\*\*Change the drag modifier.\*\* The `#LButton` line uses the Win key. Swap `#` for `!` (Alt) or `^` (Ctrl) if you prefer a different modifier for dragging.



\---



\## License



Released under the \[MIT License](LICENSE). Use it, fork it, tweak it freely.

