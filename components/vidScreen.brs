sub init()
    print "Initializing Video Scene"
    m.top.setfocus(true)
    m.vid = m.top.findNode("VideoPlayer") 'Get the video node
    m.top.observefield("message", "setVideo")
    m.top.observefield("Title", "setVideo")
end sub

'Set and return the live video ContentNode object
sub setVideo()
    if m.top.message <> "" and m.top.Title <> ""
        videoContent = CreateObject("roSGNode", "ContentNode")
        videoContent.url = "http://video.calvaryccm.com:1935/vod/_definst_/main/mp4/" + m.top.message + "/playlist.m3u8"
        videoContent.title = m.top.Title
        videoContent.streamformat = "hls"
        m.vid.observefield("bufferingStatus", "printBuffer")
        m.vid.observefield("state", "onStateChange")
        m.vid.content = videoContent
        m.vid.setfocus(true)
        m.vid.control = "play"
    end if
end sub

sub printBuffer()
    if m.vid.bufferingStatus <> invalid
        print "Buffer is " + m.vid.bufferingStatus.percentage.ToStr() + "%"
    else print "Buffer is invalid"
    end if
    print "Format is " + m.vid.videoformat
end sub

sub onStateChange()
    print "Current state is " + m.vid.state
end sub