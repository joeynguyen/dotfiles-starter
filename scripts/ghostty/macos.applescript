#!/usr/bin/osascript
-- See https://ghostty.org/docs/features/applescript

set dirDownloads to POSIX path of (path to downloads folder from user domain)
set dirDocuments to POSIX path of (path to documents folder from user domain)
set dirApplications to "/Applications"

tell application "Ghostty"
    activate

    --------------------------------------------------
    -- Tab 1: ~/Downloads — 3 panes, 'top' in middle (reuse current tab if Ghostty already open)
    --------------------------------------------------
    set reuseFirstTab to false
    if (count of windows) = 0 then
        set cfgDl to new surface configuration
        set initial working directory of cfgDl to dirDownloads
        set win to new window with configuration cfgDl
        set tabDownloads to selected tab of win
    else
        set reuseFirstTab to true
        set win to front window
        set tabDownloads to selected tab of win
        set cfgDl to new surface configuration
        set initial working directory of cfgDl to dirDownloads
    end if

    select tab tabDownloads
    set tLeft to focused terminal of tabDownloads
    if reuseFirstTab then
        input text "cd " & dirDownloads to tLeft
        send key "enter" to tLeft
    end if
    set tMid to split tLeft direction right with configuration cfgDl
    set tRight to split tMid direction right with configuration cfgDl
    perform action "equalize_splits" on tLeft

    input text "clear" to tMid
    send key "enter" to tMid
    input text "top" to tMid
    send key "enter" to tMid

    input text "clear" to tRight
    send key "enter" to tRight
    my ghosttySetTabTitle(dirDownloads, tabDownloads, tLeft)

    --------------------------------------------------
    -- Tab 2: ~/Documents (2 panes)
    --------------------------------------------------
    set win to front window
    set cfgDocs to new surface configuration
    set initial working directory of cfgDocs to dirDocuments
    set tabDocuments to new tab in win with configuration cfgDocs

    select tab tabDocuments
    set docsLeft to focused terminal of tabDocuments
    input text "clear" to docsLeft
    send key "enter" to docsLeft
    set docsRight to split docsLeft direction right with configuration cfgDocs
    perform action "equalize_splits" on docsLeft

    input text "clear" to docsRight
    send key "enter" to docsRight
    focus docsLeft
    my ghosttySetTabTitle(dirDocuments, tabDocuments, docsLeft)

    --------------------------------------------------
    -- Tab 3: /Applications (single pane)
    --------------------------------------------------
    set win to front window
    set cfgApps to new surface configuration
    set initial working directory of cfgApps to dirApplications
    set tabApplications to new tab in win with configuration cfgApps

    select tab tabApplications
    set termApplications to focused terminal of tabApplications
    input text "clear" to termApplications
    send key "enter" to termApplications
    my ghosttySetTabTitle(dirApplications, tabApplications, termApplications)

    --------------------------------------------------
    -- Focus first tab, first pane
    --------------------------------------------------
    select tab tabDownloads
    focus tLeft

end tell

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
