'buttonPanel
'This panel holds a couple of buttons on the left side of the homescene

sub init()
    print "Initializing the Button Panel"
    m.top.panelSize = "medium" 'Setting this panel up
    m.top.focusable = true
    m.top.hasNextPanel = true
    m.top.leftOnly = true
    m.top.createNextPanelOnItemFocus = false
    m.top.selectButtonMovesPanelForward = true
    m.bList = m.top.findNode("ButtonList")
    m.top.list = m.bList
end sub

function onKeyEvent(key as string, press as Boolean) as Boolean
    if press then
        if key = "OK" 'The user selected a button
            print "The user pressed OK"
            buttonPressed = m.bList.findNode("Buttons").getChild(m.bList.itemFocused).id 'Get the id of the selected button
            if buttonPressed = "LiveBTN" then
                m.newScreen = CreateObject("roSGNode", "showLive")  'Create an object to show the live screen
                m.newScreen.control = "RUN"
            else if buttonPressed = "aBTN" then
                m.newScreen = CreateObject("roSGNode", "showArchive") 'Create an object to show the archive screen
                m.newScreen.control = "RUN"
            end if
        else if key = "back"
            print "The user pressed back"
            return false
        end if
    end if
    return true
end function