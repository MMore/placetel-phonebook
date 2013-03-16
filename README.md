placetel-phonebook
==================

Generates a phonebook via the Placetel API.
Besides that it enables you to initiate calls which can be used together with a Click2Dial browser extension.


Configuration
--------------

* Open phonebook.rb
* Set...
  * placetel_api_key
  * title
* Done!


Run
-------------

Just start the application with `ruby phonebook.rb` and open **http://localhost:4567** in a browser. Or use something
like passenger or unicorn to serve it.


Initiate Calls
-------------

* Install a browser extension like Telify (http://www.codepad.de/de/software/firefox-add-ons/telify.html)
* Telify Configuration
  * Set "Used protocol" to "Own URL"
  * Set URL to "http://$1/initiate_call/$2/$0"
  * Set parameter #1 to your host that runs "placetel-phonebook"
  * Set parameter #2 to your Sip UID (sth. like 777XXXXXXXX@sip.finotel.com) -> phone that should initiate the call
* Done!

Now you can easily click on a number in your browser to dial the clicked number.
