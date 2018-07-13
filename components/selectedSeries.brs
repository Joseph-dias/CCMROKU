'selectedSeries
'This is a scene that creates and displays a list of videos in a series.
'Giving the user the option to select one.

sub init()
    print "Show the series List"
    m.top.setFocus(true)
    m.info = m.top.findNode("infoLBL")
    m.data = m.top.findNode("data")
    m.top.ObserveField("vidObject", "changeInfo")
    m.top.ObserveField("empty", "displayMSG")
    m.lastFocus = -1
end sub

sub changeInfo()
    print "The videos were received"
    m.data.content = m.top.vidObject 'Set the content.  It's a ContentNode (for the row) within a ContentNode (for the whole list).
    if m.top.count < 4 'Current display settings will not work if the teaching count is less than 4
        m.data.focusXOffset = [0] ' No offset if the child count is less than 4
        m.data.translation = [25, 50]
    end if
    m.info.visible = false
    m.data.visible = true
    m.data.ObserveField("rowItemFocused", "onNewFocus")
    m.data.setFocus(true)
end sub

'Set the width of the new focused item.  Reset the width of the old one
sub onNewFocus()
    print "Focused at: " + Str(m.data.rowItemFocused[1])
    if m.lastFocus <> -1
        lastNode = m.data.content.getChild(0).getChild(m.lastFocus)
        lastNode.width = 200
        lastNode.height = 400
    end if
    currFocus = m.data.content.getChild(0).getChild(m.data.rowItemFocused[1])
    currFocus.width = 400
    currFocus.height = 600
    m.lastFocus = m.data.rowItemFocused[1]
end sub

'Deal with selection
function onKeyEvent(key as string, press as Boolean) as Boolean
    if key = "OK" 'The user selected a button
        print "The user pressed OK"
        buttonPressed = m.data.content.getChild(0).getChild(m.data.rowItemFocused[1]).messageNum 'Get the message number that was selected (Located in the messageItem node)
        m.nextScreen = CreateObject("roSGNode", "showVid")
        m.nextScreen.messageNum = buttonPressed
        m.nextScreen.vid_name = m.data.content.getChild(0).getChild(m.data.rowItemFocused[1]).title
        m.nextScreen.control = "RUN"
        return true
    else if key = "back"
        print "The user pressed back"
    end if
    return false
end function

sub displayMSG()
    if m.top.empty = "true"
        m.info.visible = false
        m.data.visible = false
        m.top.findNode("emptyLBL").visible = true
    end if
end sub