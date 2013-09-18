##Asterisk Directory

This application is intended as a basic searchable directory for an Asterisk PBX. It can be used to quickly look up names and numbers on the system and to check the status of phones.

### Requirements

The application requires the following:

* A database with a table named "user" that contains the columns "name" and "extension". If you're using FreePBX you should already have this and can point the application at that database.
* A login for Asterisk AMI. If this isn't configured you can find out more [here](http://www.voip-info.org/wiki/view/Asterisk+manager+API). 

### What it does

The application presents a single text input box into which you can type part of a name or extension number. It will dynamically present a list as you type. It will check the status of all displayed extensions and update these dynamically every two seconds.

