sub init()
    print "Initializing the messageItem"
    m.pic = m.top.findNode("seriesPic")
    m.txt = m.top.findNode("infoLBL")
    m.desc = m.top.findNode("descLBL")
    m.rec = m.top.findNode("backgroundRec")
    m.transColor = "#696969" 'This is the color of an unfocused item
    m.selectedColor = "#000000" 'This is the color of a focused item
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
    m.top.itemContent.observeField("focused", "focusChange")
end function

'Change the width of the nodes
sub changeWidth()
    m.pic.width = m.top.itemContent.width
    m.txt.width = m.top.itemContent.width
    m.desc.width = m.top.itemContent.width
    m.rec.width = m.top.itemContent.width
end sub

'Change the height of the nodes
sub changeHeight()
    m.pic.height = m.top.itemContent.height / 2
    m.txt.height = m.top.itemContent.height / 4
    m.desc.height = m.top.itemContent.height / 4
    m.rec.height = m.top.itemContent.height
end sub

sub focusChange()
    if m.top.itemContent.focused
        m.txt.font = "font:MediumBoldSystemFont"
        m.rec.color = m.selectedColor
    else
        m.txt.font = "font:SmallSystemFont"
        m.rec.color = m.transColor
    end if
end sub