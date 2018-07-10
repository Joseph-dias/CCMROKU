'HomeScene
'This is the first scene that the user comes to

sub init()
    print "Initializing HomeScene"
    m.top.setFocus(true)
   m.buttons = m.top.findNode("ButtonList") 'Get the list of buttons
    m.buttons.setFocus(true)
end sub

function onKeyEvent(key as string, press as Boolean) as Boolean
    if press then
        if key = "OK" 'The user selected a button
            print "The user pressed OK"
            buttonPressed = m.buttons.findNode("Buttons").getChild(m.buttons.itemFocused).id 'Get the id of the selected button
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