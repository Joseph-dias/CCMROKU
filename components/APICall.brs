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
    'TODO: Find out how to correctly authorize into the API
    request.AddHeader("Authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IlROaEFCQnRxaURCZnJoM2F1OElDQmZIXzN6TSIsImtpZCI6IlROaEFCQnRxaURCZnJoM2F1OElDQmZIXzN6TSJ9.eyJpc3MiOiJGb3JtcyIsImF1ZCI6IkZvcm1zL3Jlc291cmNlcyIsImV4cCI6MTUyODQ3NzA4NCwibmJmIjoxNTI4NDczNDg0LCJjbGllbnRfaWQiOiJQbGF0Zm9ybS5XZWIuU2VydmljZXMiLCJzY29wZSI6Imh0dHA6Ly93d3cudGhpbmttaW5pc3RyeS5jb20vZGF0YXBsYXRmb3JtL3Njb3Blcy9hbGwiLCJzdWIiOiJiOTZlMmM1Mi0yMjY2LTRmOWUtYTIzZS01OWFiZDk4OTJlNGUiLCJhdXRoX3RpbWUiOjE1Mjg0NzM0ODQsImlkcCI6Imlkc3J2IiwibmFtZSI6InN0YXNoNTAwMCIsImFtciI6WyJwYXNzd29yZCJdfQ.uI5TysqIOwc-rulkCqinkXdmMTr6tW4rDaMoO-tb45Hdfi29mPY2uXEY4gR6otxbavPCDFuk2djjQj-aJT1GE5BFFik7G-Efuc-AZ7D3zVslqrbMmRLPYsVjq0D6EYaTsApKV3Xgp_eLwoo8_0nNEcRI_NehX_QPjZg50q_Tbq1cjiDIfn5vZFyWeepazTKPHMcRMgOcBgE1IBXgLKJHBS3TqQawP18bb6-ygVFZPsIoKznZfqjnr4b7r0sB-gxhu7ZlNi9HTg3qol9kFrPZaRiUAFh5_68caf_YY2Wx_qXCuKkMb4F3uvhZGc3MnFzxEwrC1DundigWF4D6wvniUA")
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