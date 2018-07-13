sub init()
    print "Initializing the messageItem"
    m.pic = m.top.findNode("seriesPic")
    m.txt = m.top.findNode("infoLBL")
    m.desc = m.top.findNode("descLBL")
end sub

'Set this node's data to the given values.  ItemContent should be a MessageData node.
function itemContentChanged() as void
    m.pic.uri = m.top.itemContent.pic
    m.txt.text = m.top.itemContent.title
    m.desc.text = m.top.itemContent.description
    changeWidth()
    changeHeight()
    m.top.itemContent.observeField("width", "changeWidth")
    m.top.itemContent.observeField("height", "changeHeight")
end function

'Change the width of the nodes
sub changeWidth()
    m.pic.width = m.top.itemContent.width
    m.txt.width = m.top.itemContent.width
    m.desc.width = m.top.itemContent.width
end sub

'Change the height of the nodes
sub changeHeight()
    m.pic.height = m.top.itemContent.height / 2
    m.txt.height = m.top.itemContent.height / 4
    m.desc.height = m.top.itemContent.height / 4
end sub