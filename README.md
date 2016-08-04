#Tic Tac Toe in Elm

###Dependencies
####[Elm 0.17.0](http://elm-lang.org/install)
    
    npm install -g elm@0.17.0

###To Run Program Locally:
    elm-package install
    npm install
    npm start

then navigate to ```http://localhost:8080```

###To run unit tests:

    npm test

###To run integration tests (in Firefox):

Make sure program is running locally (```npm start```)

In one tab, start selenium server:

    java -jar selenium-server-standalone-2.53.1.jar wdio.conf.js

Then in another run:

    npm run itest
