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

Install the selenium-standalone package if you don't already have it:

    npm install -g selenium-standalone

In one tab, install and start a standalone server:

    selenium-standalone install
    selenium-standalone start

Then in another run:

    npm run itest
