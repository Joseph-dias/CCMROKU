sub init()
    print "Initializing HomeScene"
    m.top.setFocus(true)
    m.panelSet = createObject("roSGNode", "PanelSet") 'Create a Panel Set
    m.top.appendChild(m.panelSet)
    m.buttonPanel = m.panelSet.createChild("buttonPanel") 'Create a button panel object as a child of the panel set
    m.descPanel = m.panelSet.createChild("DescPanel") 'Create a description panel object as a child of the panel set
    m.top.appendChild(m.panelSet)
    m.buttonPanel.list.observeField("itemFocused", "handleFocus") 'Observe when the item focus changes
    m.buttonPanel.setFocus(true)
end sub

function onKeyEvent(key as string, press as Boolean) as Boolean
    if press = true and key = "back" then
        return false
    else if not m.buttonPanel.hasFocus() then 'Make sure the button panel always has focus
        m.buttonPanel.setFocus(true)
    end if
    return true
end function

sub handleFocus()
    if m.buttonPanel.list.content.getChild(m.buttonPanel.list.itemFocused).id = "LiveBTN" then
        setTXT("Watch our live service!") 'Set descriptive text for the "Live Service" button
    else
        setTXT("See past Sermons") 'Set descriptive text for the "Archive" button
    end if
end sub

sub setTXT(txt)
    m.descPanel.findNode("infoLBL").text = txt 'Set the Description text to the given param
end sub