sub init()
    m.top.functionName = "CallAPI"
end sub

'Call the API to get the series list, and create a GridItemData node for each
function CallAPI() as void
    'Get token from server
    tokenRequest = CreateObject("roUrlTransfer")
    tokenRequest.SetRequest("POST")
    tokenRequest.SetUrl("https://my.calvaryccm.com/token")
    tokenRequest.SetCertificatesFile("pkg:/source/ca-bundle.crt")
    tokenRequest.InitClientCertificates()
    'tokenRequest.AddHeader("Accept", "application/json")
    tokenRequest.AddHeader("Content-Type","application/json")
    'tokenRequest.AddHeader("grant_type=", "client_credentials")
    'tokenRequest.AddHeader("client_id=", Escape(m.top.ClientID))
    'tokenRequest.AddHeader("client_secret=", Escape(m.top.ClientSecret))
    params = "grant_type=client_credentials&client_id=" + m.top.ClientID + "&client_secret=" + m.top.ClientSecret + "&scope=all"
    credResponse = tokenRequest.PostFromString(params)
    'Request data from api
    request = CreateObject("roUrlTransfer")
    request.SetUrl("https://my.calvaryccm.com/ministryplatformapi/tables/Media_Archive_Series?%24filter=Display_On_Roku%3D'true'")
    request.SetRequest("GET")
    request.SetCertificatesFile("pkg:/source/ca-bundle.crt")
    request.InitClientCertificates()
    request.AddHeader("Accept", "application/json")
    'TODO: Find out how to correctly authorize into the API
    request.AddHeader("Authorization", "OAuth " + m.top.ClientID + " " + m.top.ClientSecret)
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