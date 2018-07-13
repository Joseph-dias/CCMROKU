'vidList
'This is a task that creates a selectedSeries scene,
'calls the API to get the list of videos in a series,
'and sets that series list in the scene.

sub init()
    m.top.functionName = "showList"
end sub

sub showList()
    print "Attempting to show the list of sermons"
    screen2 = CreateObject("roSGScreen") 'Create the screen object
    m.port2 = CreateObject("roMessagePort")
    screen2.setMessagePort(m.port2)
    scene2 = screen2.CreateScene("selectedSeries") 'Create the Series Page
    screen2.show() 'Show the screen
    data = getList()
    if data <> invalid then
        toReturn = CreateObject("roSGNode", "ContentNode") 'Parent Node to return
        row1 = toReturn.CreateChild("ContentNode")
        if data.Count() = 0
            scene2.empty = "true"
        else
            while data.Count() > 0
                myData = data.pop()
                newNode = row1.CreateChild("MessageData") 'Create a MessageData child node
                newNode.title = myData.Title 'Set child node's data
                newNode.Description = myData.Description
                newNode.MessageNum = myData.Message_Number
                newNode.pic = m.top.picURL 'Ultimately set in Archive.brs
                'Set dimensions
                newNode.width = 200
                newNode.height = 400
                'End Widths
            end while
            scene2.vidObject = toReturn
        end if
    else
        scene2.empty = "true"
    end if

    while(true)
        msg = wait(0, m.port2)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
        if msg.isScreenClosed() then return
        end if
    end while
end sub

'Gets objects from the API
function getList() as object
    request = CreateObject("roUrlTransfer")
    print "Printing " + m.top.seriesID.ToStr()
    url = "https://my.calvaryccm.com/ministryplatformapi/tables/Media_Archive_Items?%24filter=roku%3D'true'%20and%20Media_Archive_Series_ID%3D'" + m.top.seriesID.ToStr() + "'"
    request.SetUrl(url)
    request.SetRequest("GET")
    request.SetCertificatesFile("pkg:/source/ca-bundle.crt")
    request.InitClientCertificates()
    request.AddHeader("Accept", "application/json")
    request.AddHeader("Authorization", "Bearer " + m.top.token)
    print "Sending the request to the API"
    returned = request.GetToString()
    if returned <> "" then 
        return ParseJson(returned) 
    end if
    return invalid
end function