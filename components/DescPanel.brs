'DescPanel
'This panels holds a label inside of a rectangle.
'The text is dynamically changed by the HomeScene.

sub init()
    print "Initializing the Description Panel"
    m.top.panelSize = "medium" 'Setting panel info
    m.top.focusable = false
    m.top.hasNextPanel = false
    m.top.rightOnly = true
    m.top.createNextPanelOnItemFocus = false
end sub