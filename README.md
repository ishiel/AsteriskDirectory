##Asterisk Directory

This application is intended as a basic searchable directory for an Asterisk PBX. It can be used to quickly look up names and numbers on the system and to check the status of phones. It was created primarily for reception desk staff.

### Requirements

The application requires the following:

* A database with a table named "user" that contains the columns "name" and "extension". If you're using FreePBX you should already have this and can point the application at that database.
* A login for Asterisk AMI. If this isn't configured you can find out more [here](http://www.voip-info.org/wiki/view/Asterisk+manager+API).
* Ruby 1.8.7 (other versions may work but haven't been tested)
* You do not need to install this application on your Asterisk box, any server will do  

### What it does

The application presents a single text input box into which you can type part of a name or extension number. It will dynamically present a list as you type. It will check the status of all displayed extensions and update these dynamically every two seconds.

### Warning

This application makes direct queries to the PBX. In testing I found that if I tried to overload the server with requests it would fail to return data to the application but the PBX continued unaffected. While it appears to be safe to use in production, it may be possible to use this application to overload your PBX so it should be restricted to trusted users.

Use of this application is at your own risk. 

### Installation

* Copy and expand the zip file to your directory of choice. All the following commands are run from the root of this expanded folder.
* Copy or rename `config.yml.EXAMPLE` to `config.yml` and then enter the correct details in the file. 
* If you don't have it already then install bundler by running `gem install bundler`.
* Now run `bundle install` and this will install all the required gems.
* Set up your chosen web server so it can serve up this application. This [page](http://recipes.sinatrarb.com/p/deployment?#article) may help. 