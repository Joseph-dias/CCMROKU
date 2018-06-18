'getToken
'Calls the authentication server to obtain a token.
'Set the Client ID and the Client Secret in setClientData()


sub init()
    m.top.functionName = "getTheToken"
end sub

sub setClientData()
    'API authentication data
    m.ClientID = "[Client ID]"
    m.ClientSecret = "[Client Secret]"
    'End API authentication data
end sub

sub getTheToken()
    'Get token from server
    tokenRequest = CreateObject("roUrlTransfer")
    tokenRequest.SetRequest("POST")
    setClientData()
    params = "grant_type=client_credentials&client_id=" + m.ClientID + "&client_secret=" + m.ClientSecret + "&scope=http://www.thinkministry.com/dataplatform/scopes/all"
    tokenRequest.SetUrl("https://my.calvaryccm.com/ministryplatformapi/oauth/connect/token")
    port = CreateObject("roMessagePort")
    tokenRequest.SetMessagePort(port)
    tokenRequest.SetCertificatesFile("pkg:/source/ca-bundle.crt")
    tokenRequest.InitClientCertificates()
    tokenRequest.AddHeader("Accept","application/json")
    tokenRequest.AddHeader("Content-Type", "application/x-www-form-urlencoded")
    theReturn = waitMSG(tokenRequest, params, port)
    m.top.token = theReturn.access_token
end sub

function waitMSG(theRequest, param, port)
    if (theRequest.AsyncPostFromString(param))
        while (true)
            msg = wait(0, port)
            if (type(msg) = "roUrlEvent")
                code = msg.GetResponseCode()
                if (code = 200)
                    return ParseJSON(msg.GetString())
                else 
                    print msg.GetFailureReason()
                    return "Failure"
                end if
            else if (event = invalid)
                request.AsyncCancel()
            end if
        end while
    end if
end function