# Elm Quickstart
This is a repository that can be cloned or copied in order to start a new basic
Elm application. It sets up the following:

* Basic HTML application with model, update, view and subscriptions.
* Small utility module used to demonstrate testing.
* npm setup to run build or tests.

To use this repository, you should follow these steps.

1. npm install -g elm

2. npm install -g elm-live

3. npm install -g elm-test

4. npm install

5. npm run test

6. npm run watch
	The port has been set to 8080 in:
        node_modules/elm-live/source/parse-args.js
	
	alt cli:
	elm-live src/*.elm --port=8080 --pushstate --output dist/bundle.js --debug
	open 8080 in chrome

The *watch* step will run the elm-live build process and launch the browser.
Future code changes will automatically trigger a rebuild and the browser will
live reload with your changes.


