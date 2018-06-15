'showLive
'This is a task that shows the LiveScene

sub init()
    m.top.functionName = "showLiveScreen"
end sub

function showLiveScreen() as void
    print "Attempting to show the live screen"
    screen2 = CreateObject("roSGScreen") 'Create the screen object
    m.port2 = CreateObject("roMessagePort")
    screen2.setMessagePort(m.port2)
    scene2 = screen2.CreateScene("LiveScene") 'Create the Live Scene
    screen2.show() 'Show the screen

    while(true)
        msg = wait(0, m.port2)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
        if msg.isScreenClosed() then return
        end if
    end while
end function