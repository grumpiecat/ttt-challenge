// pull in desired CSS/SASS files
require( './main.scss' );

// inject bundled Elm app into div#main
var Elm = require( '../src/Main' );
Elm.Main.embed( document.getElementById( 'main' ) );
