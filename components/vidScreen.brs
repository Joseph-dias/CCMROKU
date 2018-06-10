sub init()
    print "Initializing Video Scene"
    m.vid = m.top.findNode("VideoPlayer") 'Get the video node
    m.vid.setFocus(true)
    m.vid.content = setVideo() 'Set the video content to the live video
    m.top.observeField("url", "changeUrl")
    m.top.observeField("Title", "changeTitle")
    m.vid.observeField("errorMSG", "printError")
end sub

'Set and return the live video ContentNode object
function setVideo() as object
    m.service = CreateObject("roSGNode", "ContentNode")
    m.service.streamformat = "mp4"
    return m.service
end function

sub changeUrl()
    m.service.url = m.top.url
    setPlay()
end sub

sub changeTitle()
    m.service.Title = m.top.Title
    setPlay()
end sub

sub setPlay()
    if m.service.url <> "" and m.service.Title <> "" then
        m.vid.control = "play"
    else if m.service.url <> ""
        m.vid.control = "prebuffer"
    end if
end sub

sub printError()
    print m.vid.errorMSG
end sub