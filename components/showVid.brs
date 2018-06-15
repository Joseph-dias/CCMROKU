'   showVid
'   Creates the video scene, sets the video URL and title in the scene, and shows the scene


sub init()
    m.top.functionName = "showVideo"
end sub

sub showVideo()
    print "Attempting to show the video screen"
    screen2 = CreateObject("roSGScreen") 'Create the screen object
    m.port2 = CreateObject("roMessagePort")
    screen2.setMessagePort(m.port2)
    scene2 = screen2.CreateScene("vidScreen") 'Create the Video Scene
    scene2.Title = m.top.vid_name
    scene2.message = m.top.messageNum
    screen2.show() 'Show the screen

    while(true)
        msg = wait(0, m.port2)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
        if msg.isScreenClosed() then return
        end if
    end while
end sub