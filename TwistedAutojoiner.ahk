#Requires AutoHotkey v2.0
SendMode("Event")
SetTitleMatchMode(2)

running := false
attemptCount := 0
instructionsShown := false

ShowInstructions() {
    global instructionsShown

    hasShown := RegRead("HKEY_CURRENT_USER\Software\TwistedAutoJoin", "InstructionsShown", 0)
    if hasShown
        return

    instrGui := Gui("+AlwaysOnTop +Border", "Setup Instructions")
    instrGui.BackColor := "0x1a1a1a"
    instrGui.SetFont("s10 c0xFFFFFF", "Segoe UI")

    instrGui.SetFont("s12 Bold c0x4CAF50")
    instrGui.AddText("x20 y15 w360", "IMPORTANT: Cursor Alignment Required")

    instrGui.SetFont("s10 c0xFFFFFF", "Segoe UI")
    instrGui.AddText("x20 y50 w360", "Before clicking START, you must:")
    instrGui.AddText("x20 y75 w360", "1. Position your cursor over the OK button")
    instrGui.AddText("x20 y95 w360", "2. The script will click at that exact location")
    instrGui.AddText("x20 y115 w360", "3. Make sure Roblox window is visible")
    instrGui.AddText("x20 y135 w360", "4. Enable Navigation key in Roblox settings")

    instrGui.SetFont("s9 Bold c0xFFFF00")
    instrGui.AddText("x20 y160 w360", "The cursor position will be saved after you click I Understand")

    instrGui.AddText("x20 y190 w360 h1 Background0x444444")

    instrGui.SetFont("s10 c0xFFFFFF", "Segoe UI")
    okBtn := instrGui.AddButton("x140 y205 w120 h35 Background0x4CAF50 c0xFFFFFF", "I Understand")
    okBtn.OnEvent("Click", CloseInstructions)

    instrGui.Show("w400 h260 Center")

    CloseInstructions(*) {
        instrGui.Destroy()
        RegWrite(1, "REG_DWORD", "HKEY_CURRENT_USER\Software\TwistedAutoJoin", "InstructionsShown")
        instructionsShown := true
    }
}

ui := Gui("+AlwaysOnTop -Caption +Border", "Twisted AutoJoin")
ui.BackColor := "0x1a1a1a"
ui.SetFont("s10 c0xFFFFFF", "Segoe UI")

titleBar := ui.AddText("x0 y0 w200 h30 Background0x2d2d2d Center 0x200", "Twisted AutoJoin")
closeBtn := ui.AddText("x200 y0 w30 h30 Background0x2d2d2d Center 0x200", "X")
closeBtn.SetFont("s12 Bold c0xFF0000")
closeBtn.OnEvent("Click", (*) => CloseApp())

titleBar.OnEvent("Click", MakeDraggable)

startBtn := ui.AddButton("x15 y40 w90 h35 Background0x4CAF50 c0xFFFFFF", "Start")
stopBtn  := ui.AddButton("x125 y40 w90 h35 Background0xf44336 c0xFFFFFF", "Stop")
statusText := ui.AddText("x10 y85 w210 h20 Background0x1a1a1a c0x00ff00 Center", "Stopped")
attemptText := ui.AddText("x10 y105 w210 h20 Background0x1a1a1a c0x888888 Center", "Attempts: 0")

posX := RegRead("HKEY_CURRENT_USER\Software\TwistedAutoJoin", "PosX", 200)
posY := RegRead("HKEY_CURRENT_USER\Software\TwistedAutoJoin", "PosY", 200)
ui.Show("x" . posX . " y" . posY . " w230 h135")

MakeDraggable(*) {
    PostMessage(0xA1, 2,,, "A")
}

startBtn.OnEvent("Click", StartLoop)
stopBtn.OnEvent("Click", StopLoop)

FindRobloxWindow() {
    local tests := [
        "ahk_exe RobloxPlayerBeta.exe",
        "ahk_exe RobloxPlayer.exe",
        "ahk_exe Bloxstrap.exe",
        "ahk_exe RobloxLauncher.exe",
        "Roblox",
        "Roblox Player"
    ]
    for k, v in tests {
        id := WinExist(v)
        if id
            return id
    }
    return 0
}

ControlSendToWin(winId, text) {
    if !winId
        return false
    try {
        ControlSend("", text, "ahk_id " . winId)
        return true
    } catch {
        return false
    }
}

TryDismissOk(winId) {
    if winId {
        ControlSendToWin(winId, "{Enter}")
        Sleep(80)
        try {
            ControlClick("Button1", "ahk_id " . winId)
        }
        Sleep(60)
        try {
            ControlClick("OK", "ahk_id " . winId)
        }
        Sleep(100)
        Click()
        Sleep(100)
        Click()
    } else {
        Send("{Enter}")
        Sleep(100)
        Click()
        Sleep(100)
        Click()
    }
}

StartLoop(*) {
    global running, statusText, attemptCount, attemptText, instructionsShown

    if !instructionsShown {
        ShowInstructions()
        Sleep(3000)
    }

    if running
        return

    running := true
    attemptCount := 0
    statusText.Value := "Starting..."
    attemptText.Value := "Attempts: 0"
    Sleep(3000)

    while running {
        attemptCount++
        attemptText.Value := "Attempts: " . attemptCount

        win := FindRobloxWindow()
        if win {
            WinActivate("ahk_id " . win)
            Sleep(150)
            Send("\")
            Sleep(80)
            Send("{Enter}")
        } else {
            Send("\")
            Sleep(80)
            Send("{Enter}")
        }

        Sleep(2000)
        TryDismissOk(win)

        statusText.Value := "Running..."
        Sleep(5000)
    }

    statusText.Value := "Stopped"
}

StopLoop(*) {
    global running, statusText
    running := false
    statusText.Value := "Stopped"
}

CloseApp() {
    global running, ui
    running := false

    ui.GetPos(&posX, &posY)
    RegWrite(posX, "REG_DWORD", "HKEY_CURRENT_USER\Software\TwistedAutoJoin", "PosX")
    RegWrite(posY, "REG_DWORD", "HKEY_CURRENT_USER\Software\TwistedAutoJoin", "PosY")

    ExitApp
}
