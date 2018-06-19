'vidScreen
'This scene creates a video node, sets the url, stream format, and title of the video, and plays the video.


sub init()
    print "Initializing Video Scene"
    m.top.setfocus(true)
end sub

'Set and return the live video ContentNode object
sub itemContentChanged()
    'Creating video content
    videoContent = CreateObject("roSGNode", "ContentNode")
    videoContent.title = m.top.itemContent.title
    videoContent.url = "http://video.calvaryccm.com/main/mp4/" + m.top.itemContent.id + ".mp4"
    videoContent.streamformat = "mp4"
    'Creating the video node and setting the content
    m.vid = m.top.CreateChild("Video")
    m.vid.content = videoContent
    m.vid.setfocus(true)
    m.vid.control = "play"
end sub