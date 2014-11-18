# placetel-phonebook

[![Build Status](https://travis-ci.org/MMore/placetel-phonebook.svg)](https://travis-ci.org/MMore/placetel-phonebook)

Generates a phonebook via the Placetel API.
Besides that it enables you to initiate calls which can be used together with a Click2Dial browser extension.


## Configuration

* Open phonebook.rb and set the
  * placetel_api_key and a
  * title
* Done!

## Setup

* Ruby
  * Install bundler if required `gem install bundler`
  * Install dependencies `bundle install`
* Angular
  * Install Bower `npm install -g bower`
  * Install AngularJS `bower install`

## Run

Just start the application with `ruby phonebook.rb` and open **http://localhost:4567** in a browser. Or use something
like passenger or unicorn to serve it.

## Initiate Calls

* Install a browser extension like Telify (http://www.codepad.de/de/software/firefox-add-ons/telify.html)
* Telify Configuration
  * Set "Used protocol" to "Own URL"
  * Set URL to "http://$1/initiate_call/$2/$0"
  * Set parameter $1 to your host that runs "placetel-phonebook"
  * Set parameter $2 to your Sip UID (sth. like 777XXXXXXXX@sip.finotel.com) -> phone that should initiate the call
  * Parameter $0 is the number you`re about to dial
* Done!

Now you can easily click on a number in your browser to dial it.

## Copyright and License

Made by Mathias Nestler (c) 2013-2014. Feel free to contribute!

Released under the GNU GPLv2
