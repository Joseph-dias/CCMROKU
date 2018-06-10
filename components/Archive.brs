sub init()
    print "Show the series List"
    m.top.setFocus(true)
    m.newCall = CreateObject("roSGNode", "APICall")  'Create an object to call the API
    m.info = m.top.findNode("infoLBL")
    m.data = m.top.findNode("data")
    m.newCall.ObserveField("returnedobject", "APIReturn")
    m.newCall.control = "RUN"
end sub

'Deal with the returned ContentNode (Should have a bunch of GridItemData nodes as children)
sub APIReturn()
    print "The API returned"
    m.data.content = m.newCall.returnedobject
    m.info.visible = false
    m.data.visible = true
    m.data.setFocus(true)
end sub

'Deal with selection
function onKeyEvent(key as string, press as Boolean) as Boolean
    if press then
        if key = "OK" 'The user selected a button
            print "The user pressed OK"
            buttonPressed = m.data.content.getChild(m.data.itemFocused).seriesID 'Get the series id that was selected
            m.nextScreen = CreateObject("roSGNode", "vidList")
            m.nextScreen.seriesID = buttonPressed
            m.nextScreen.picURL = m.data.content.getChild(m.data.itemFocused).picURL
            m.nextScreen.control = "RUN"
        else if key = "back"
            print "The user pressed back"
            return false
        end if
    end if
    return true
end function