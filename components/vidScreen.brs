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
    videoContent.url = "http://video.calvaryccm.com:1935/vod/_definst_/main/mp4/" + m.top.itemContent.id + "/playlist.m3u8"
    videoContent.streamformat = "hls"
    'Creating the video node and setting the content
    m.vid = m.top.CreateChild("Video")
    m.vid.width = "1280"
    m.vid.height = "720"
    m.vid.content = videoContent
    m.vid.setfocus(true)
    m.vid.control = "play"
end sub