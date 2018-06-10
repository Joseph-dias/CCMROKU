sub init()
    m.top.functionName = "showList"
end sub

sub showList()
    print "Attempting to show the list of sermons"
    screen2 = CreateObject("roSGScreen") 'Create the screen object
    m.port2 = CreateObject("roMessagePort")
    screen2.setMessagePort(m.port2)
    scene2 = screen2.CreateScene("selectedSeries") 'Create the Live Scene
    screen2.show() 'Show the screen
    data = getList()
    if data <> invalid then
        toReturn = CreateObject("roSGNode", "ContentNode") 'Parent Node to return
        while data.Count() > 0
            myData = data.pop()
            newNode = toReturn.CreateChild("MessageData") 'Create a GridItemData child node
            newNode.title = myData.Title 'Set child node's data
            newNode.Description = myData.Description
            newNode.ArchiveID = myData.Media_Archive_Archive_ID
            newNode.dateString = setDateString(myData.MessageDate)
            newNode.pic = m.top.picURL
        end while

        scene2.vidObject = toReturn
    end if

    while(true)
        msg = wait(0, m.port2)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
        if msg.isScreenClosed() then return
        end if
    end while
end sub

function getList() as object
    request = CreateObject("roUrlTransfer")
    print "Printing " + m.top.seriesID.ToStr()
    url = "https://my.calvaryccm.com/ministryplatformapi/tables/Media_Archive_Items?%24filter=roku%3D'true'%20and%20Media_Archive_Series_ID%3D'" + m.top.seriesID.ToStr() + "'"
    request.SetUrl(url)
    request.SetRequest("GET")
    request.SetCertificatesFile("pkg:/source/ca-bundle.crt")
    request.InitClientCertificates()
    request.AddHeader("Accept", "application/json")
    'TODO: Find out how to correctly authorize into the API
    request.AddHeader("Authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IlROaEFCQnRxaURCZnJoM2F1OElDQmZIXzN6TSIsImtpZCI6IlROaEFCQnRxaURCZnJoM2F1OElDQmZIXzN6TSJ9.eyJpc3MiOiJGb3JtcyIsImF1ZCI6IkZvcm1zL3Jlc291cmNlcyIsImV4cCI6MTUyODQ3NzA4NCwibmJmIjoxNTI4NDczNDg0LCJjbGllbnRfaWQiOiJQbGF0Zm9ybS5XZWIuU2VydmljZXMiLCJzY29wZSI6Imh0dHA6Ly93d3cudGhpbmttaW5pc3RyeS5jb20vZGF0YXBsYXRmb3JtL3Njb3Blcy9hbGwiLCJzdWIiOiJiOTZlMmM1Mi0yMjY2LTRmOWUtYTIzZS01OWFiZDk4OTJlNGUiLCJhdXRoX3RpbWUiOjE1Mjg0NzM0ODQsImlkcCI6Imlkc3J2IiwibmFtZSI6InN0YXNoNTAwMCIsImFtciI6WyJwYXNzd29yZCJdfQ.uI5TysqIOwc-rulkCqinkXdmMTr6tW4rDaMoO-tb45Hdfi29mPY2uXEY4gR6otxbavPCDFuk2djjQj-aJT1GE5BFFik7G-Efuc-AZ7D3zVslqrbMmRLPYsVjq0D6EYaTsApKV3Xgp_eLwoo8_0nNEcRI_NehX_QPjZg50q_Tbq1cjiDIfn5vZFyWeepazTKPHMcRMgOcBgE1IBXgLKJHBS3TqQawP18bb6-ygVFZPsIoKznZfqjnr4b7r0sB-gxhu7ZlNi9HTg3qol9kFrPZaRiUAFh5_68caf_YY2Wx_qXCuKkMb4F3uvhZGc3MnFzxEwrC1DundigWF4D6wvniUA")
    print "Sending the request to the API"
    returned = request.GetToString()
    if returned <> "" then 
        return ParseJson(returned) 
    end if
    return invalid
end function

function setDateString(theDate) as string
    toReturn = theDate.Split("T")
    return strReplace(toReturn[0], "-", "")
end function

'******************************************************
'Replace substrings in a string. Return new string
'******************************************************
Function strReplace(basestr As String, oldsub As String, newsub As String) As String
    newstr = ""

    i = 1
    while i <= Len(basestr)
        x = Instr(i, basestr, oldsub)
        if x = 0 then
            newstr = newstr + Mid(basestr, i)
            exit while
        endif

        if x > i then
            newstr = newstr + Mid(basestr, i, x-i)
            i = x
        endif

        newstr = newstr + newsub
        i = i + Len(oldsub)
    end while

    return newstr
End Function