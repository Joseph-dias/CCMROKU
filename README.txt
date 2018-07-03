IMPORTANT: WHEN DOWNLOADING AND RUNNING THIS PROGRAM, YOU MUST INPUT THE CLIENT ID AND THE CLIENT SECRET INTO THE GETTOKEN.BRS FILE (WHERE PROMPTED).  THOSE VALUES WERE REMOVED FOR SECURITY PURPOSES.


THIS DOCUMENT WILL EXPLAIN EACH FILE AND THE ROLE THAT IT PLAYS
THIS DOCUMENT WILL ALSO EXPLAIN THE FLOW OF THE PROGRAM


HOMESCENE
---------

This is the first scene that the user comes to when they open this app.
It defines the overhang, and it holds a couple of panels.  The buttonPanel and the DescPanel.


BUTTONPANEL 
-----------

This panel holds two buttons on the left side of the homescene.  One of the buttons takes the user to the LiveScene,
the other button takes the user to the archive.


DESCPANEL 
---------

This panel holds a label inside of a rectangle (on the right side of the homescene).
The text is dynamically changed from the HomeScene.  It can be changed there by the developer.


SHOWLIVE
--------

This is a task that creates and shows the LiveScene.


LIVESCENE 
---------

The user can watch the live service in this scene.


SHOWARCHIVE
-----------

This is a task that creates and shows the archive scene.


ARCHIVE 
-------

This is a scene that displays the series list to the user.  Allowing them to make a selection.


APICALL
-------

This is a task that calls the API to obtain the series list.


GETTOKEN
--------

This is a task that calls the authentication server to obtain a token.
Set the Client ID and the Client Secret here!


VIDLIST
-------

This is a task that calls the API to get the list of videos in a series.
It creates a selectedSeries scene, shows it, and sets the series list inside of it.


SELECTEDSERIES 
--------------

This is a scene that displays a list of videos (within the selected series) to the user.
The user, then, has the option to select one.


SHOWVID
-------

Creates a vidScreen scene, sets the necessary data inside the scene, and shows the scene.


VIDSCREEN 
---------

This scene creates and displays the selected video to the user.
