sub init()
    m.top.functionName = "CallAPI"
end sub

'Call the API to get the series list, and create a GridItemData node for each
function CallAPI() as void
    request = CreateObject("roUrlTransfer")
    request.SetUrl("https://my.calvaryccm.com/ministryplatformapi/tables/Media_Archive_Series?%24filter=Display_On_Roku%3D'true'")
    request.SetRequest("GET")
    request.SetCertificatesFile("pkg:/source/ca-bundle.crt")
    request.InitClientCertificates()
    request.AddHeader("Accept", "application/json")
    request.AddHeader("Authorization", "Bearer " + m.top.token)
    print "Sending the request to the API"
    returned = request.GetToString()
    if returned <> "" then
        myObjects = ParseJson(returned)
        toReturn = CreateObject("roSGNode", "ContentNode") 'Parent Node to return
        while myObjects.Count() > 0
            myData = myObjects.pop()
            newNode = toReturn.CreateChild("GridItemData") 'Create a GridItemData child node
            newNode.title = myData.Series_Title 'Set child node's data
            newNode.picURL = myData.Image_Path
            newNode.seriesID = myData.Media_Archive_Series_ID
        end while
        m.top.returnedObject = toReturn 'Return the parent node
    end if
end function