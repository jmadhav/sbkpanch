// Entry point for the build script in your package.json
import './add_jquery'
//import * as bootstrap from "bootstrap"
import "jquery-ui" 
import './old-bootstrap'

$(function(){
    console.log("Hello World!");
})
