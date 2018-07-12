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
            buttonPressed = m.data.content.getChild(m.data.itemFocused).messageNum 'Get the message number that was selected (Located in the messageItem node)
            m.nextScreen = CreateObject("roSGNode", "showVid")
            m.nextScreen.messageNum = buttonPressed
            m.nextScreen.vid_name = m.data.content.getChild(m.data.itemFocused).title
            m.nextScreen.control = "RUN"
        else if key = "back"
            print "The user pressed back"
            return false
        end if
    end if
    return true
end function

sub displayMSG()
    if m.top.empty = "true"
        m.info.visible = false
        m.data.visible = false
        m.top.findNode("emptyLBL").visible = true
    end if
end sub