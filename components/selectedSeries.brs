sub init()
    print "Show the series List"
    m.top.setFocus(true)
    m.info = m.top.findNode("infoLBL")
    m.data = m.top.findNode("data")
    m.top.ObserveField("vidObject", "changeInfo")
end sub

sub changeInfo()
    print "The videos were received"
    m.data.content = m.top.vidObject
    m.info.visible = false
    m.data.visible = true
    m.data.setFocus(true)
end sub

'Deal with selection
function onKeyEvent(key as string, press as Boolean) as Boolean
    if press then
        if key = "OK" 'The user selected a button
            print "The user pressed OK"
            buttonPressed = m.data.content.getChild(m.data.itemFocused).archiveID 'Get the series id that was selected
            m.nextScreen = CreateObject("roSGNode", "showVid")
            m.nextScreen.archiveID = buttonPressed
            m.nextScreen.vid_name = m.data.content.getChild(m.data.itemFocused).title
            m.nextScreen.date = m.data.content.getChild(m.data.itemFocused).dateString
            m.nextScreen.control = "RUN"
        else if key = "back"
            print "The user pressed back"
            return false
        end if
    end if
    return true
end function