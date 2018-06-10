sub init()
    m.pic = m.top.findNode("seriesPic")
    m.txt = m.top.findNode("infoLBL")
end sub

'Set this node's data to the given values.  ItemContent should be a GridItemData node.
function itemContentChanged() as void
    m.pic.uri = m.top.itemContent.picURL
    m.txt.text = m.top.itemContent.title
end function