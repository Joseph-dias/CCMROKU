sub init()
    m.pic = m.top.findNode("seriesPic")
    m.txt = m.top.findNode("infoLBL")
    m.desc = m.top.findNode("descLBL")
    changeWidths(200)
end sub

'Set this node's data to the given values.  ItemContent should be a MessageData node.
function itemContentChanged() as void
    m.pic.uri = m.top.itemContent.pic
    m.txt.text = m.top.itemContent.title
    m.desc.text = m.top.itemContent.description
end function

'Changing the widths of this item
sub changeWidths(num as float)
    m.top.SDItemWidth = num
    m.top.HDItemWidth = num
    m.top.FHDItemWidth = num
    m.pic.width = num
    m.txt.width = num
    m.desc.width = num
end sub

'Change the height based on the value of goUp
'If goUp is true: multiply heights by 2
'If goUp is false: divide heights by 2
sub changeHeight(goUp)
    if goUp
        m.pic.height = m.pic.height * 2
        m.txt.height = m.txt.height * 2
        m.desc.height = m.desc.height * 2
    else
        m.pic.height = m.pic.height / 2
        m.txt.height = m.txt.height / 2
        m.desc.height = m.desc.height / 2
    end if
end sub

sub switchSize()
    changeHeight(m.top.NewWidth > m.SDItemWidth) 'Increase the height if the new width is greater than the old one
    changeWidths(m.top.NewWidth)
end sub