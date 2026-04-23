#!/usr/bin/osascript
-- See https://ghostty.org/docs/features/applescript

set homePath to POSIX path of (path to home folder)
set dirDotfiles to homePath & "git/dotfiles"
set dirNvim to homePath & "git/nvim"

tell application "Ghostty"
    activate

    --------------------------------------------------
    -- Tab 1: "dotfiles" layout: 3 panes, 'top' in middle (use current window tab if Ghostty already open)
    --------------------------------------------------
    set reuseDotfilesTab to false
    if (count of windows) = 0 then
        set cfgDotfiles to new surface configuration
        set initial working directory of cfgDotfiles to dirDotfiles
        set win to new window with configuration cfgDotfiles
        set tabDotfiles to selected tab of win
    else
        set reuseDotfilesTab to true
        set win to front window
        set tabDotfiles to selected tab of win
        set cfgDotfiles to new surface configuration
        set initial working directory of cfgDotfiles to dirDotfiles
    end if

    select tab tabDotfiles
    set tLeft to focused terminal of tabDotfiles
    -- Reused tab: existing pane was not created with cfgDotfiles; cd it so all three dotfiles panes use dirDotfiles.
    if reuseDotfilesTab then
        input text "cd " & dirDotfiles to tLeft
        send key "enter" to tLeft
    end if
    set tMid to split tLeft direction right with configuration cfgDotfiles
    set tRight to split tMid direction right with configuration cfgDotfiles
    -- Ghostty action: even out split sizes in this surface
    perform action "equalize_splits" on tLeft

    input text "clear" to tMid
    send key "enter" to tMid
    input text "top" to tMid
    send key "enter" to tMid

    input text "clear" to tRight
    send key "enter" to tRight
    my ghosttySetTabTitle(dirDotfiles, tabDotfiles, tLeft)

    --------------------------------------------------
    -- Tab 2: "nvim" (2 panes)
    --------------------------------------------------
    set win to front window
    set cfgApis to new surface configuration
    set initial working directory of cfgApis to dirNvim
    set tabApis to new tab in win with configuration cfgApis

    select tab tabApis
    set apisLeft to focused terminal of tabApis
    input text "clear" to apisLeft
    send key "enter" to apisLeft
    set apisRight to split apisLeft direction right with configuration cfgApis
    perform action "equalize_splits" on apisLeft

    input text "clear" to apisRight
    send key "enter" to apisRight
    -- make the first pane the one focused in this tab for when the user later navigates to this tab
    focus apisLeft
    my ghosttySetTabTitle(dirNvim, tabApis, apisLeft)


    --------------------------------------------------
    -- Put the focus back to dotfiles tab; first pane
    --------------------------------------------------
    select tab tabDotfiles
    focus tLeft

end tell

-- set_tab_title follows the focused tab; re-select and delay so it applies to the right tab.
-- Title uses the configured project path (same as surface pwd); `working directory` is often unset briefly on new tabs.
on ghosttySetTabTitle(dirPath, tabRef, termRef)
    tell application "Ghostty"
        activate
        set win to front window
        select tab tabRef
        focus termRef
        delay 0.12
        set tName to my basenameOfPOSIXPath(dirPath)
        if tName is not "" then
            set termNow to focused terminal of selected tab of win
            perform action ("set_tab_title:" & tName) on termNow
        end if
    end tell
end ghosttySetTabTitle

on basenameOfPOSIXPath(p)
    if p is "" then return ""
    set p to p as string
    if (p ends with "/") and ((length of p) > 1) then set p to text 1 thru -2 of p
    set delim to AppleScript's text item delimiters
    set AppleScript's text item delimiters to "/"
    set xs to text items of p
    set AppleScript's text item delimiters to delim
    if (count of xs) is 0 then return p
    return item (count of xs) of xs
end basenameOfPOSIXPath
