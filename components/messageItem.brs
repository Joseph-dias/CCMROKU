sub init()
    m.pic = m.top.findNode("seriesPic")
    m.txt = m.top.findNode("infoLBL")
    m.desc = m.top.findNode("descLBL")
end sub

'Set this node's data to the given values.  ItemContent should be a MessageData node.
function itemContentChanged() as void
    m.pic.uri = m.top.itemContent.pic
    m.txt.text = m.top.itemContent.title
    m.desc.text = m.top.itemContent.description
end function