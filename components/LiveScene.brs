'LiveScene
'This scene displays the live service to the user.

sub init()
    print "Initializing LiveScene"
    m.vid = m.top.findNode("VideoPlayer") 'Get the video node
    m.info = m.top.findNode("infoTXT") 'Get the label node
    m.time = CreateObject("roSGNode", "Timer")
    m.time.duration = 60
    m.time.repeat = true
    m.time.observefield("fire", "onTimerFire")
    m.vid.setFocus(true)
    m.vid.content = setVideo() 'Set the video content to the live video
    m.vid.control = "play" 'Play the video
    if not checkState(m.vid) 'Make sure the video is actually playing
        m.vid.visible = false 'Hide the video and show the label
        m.info.visible = true
        m.top.setFocus(true)
    end if
    m.vid.observefield("state", "onStateChange") 'Observe when the video state changes
end sub

'Set and return the live video ContentNode object
function setVideo() as object
    service = CreateObject("roSGNode", "ContentNode")
    service.url = "https://wowzaprod150-i.akamaihd.net/hls/live/587494/8216d2a0/playlist.m3u8"
    service.Title = "Live Service"
    service.live = True
    service.streamformat = "hls"
    return service
end function

'Check the state of the video
'Return true if the video is playing or is about to play
'Return false otherwise
function checkState(service) as Boolean
    if service.state = "playing" or service.state = "buffering" or service.state = "paused" or service.state = "stopped"
        return true
    else
        return false
    end if
end function

function onStateChange() as void
    if checkState(m.vid)
        m.vid.visible = true 'Show the video and hide the label
        m.time.control = "stop"
        m.vid.setFocus(true)
        m.info.visible = false
    else
        m.vid.visible = false 'Hide the video and show the label
        m.time.control = "start"
        m.info.visible = true
        m.top.setFocus(true)
    end if
end function

sub onTimerFire()
    m.vid.control = "play"
end sub