sub init()
    m.top.functionName = "showAScreen"
end sub

function showAScreen() as void
    print "Attempting to show the Archive screen"
    screen2 = CreateObject("roSGScreen") 'Create the screen object
    m.port2 = CreateObject("roMessagePort")
    screen2.setMessagePort(m.port2)
    scene2 = screen2.CreateScene("Archive") 'Create the Archive scene
    screen2.show() 'Show the screen

    while(true)
        msg = wait(0, m.port2)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
        if msg.isScreenClosed() then return
        end if
    end while
end function