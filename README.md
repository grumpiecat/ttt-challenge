#Tic Tac Toe in Elm

    elm-package install
    npm install

###To Run Program Locally:

    npm start

then navigate to ```http://localhost:8080```

###To run unit tests:

    npm test

###To run integration tests:

Make sure program is running locally (```npm start```)

In one tab, start selenium server:

    java -jar selenium-server-standalone-2.53.1.jar wdio.conf.js

Then in another run:

    npm run itest
