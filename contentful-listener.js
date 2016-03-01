/**
 * Created by ilya on 16.02.16.
 */

// http://nodejs.org/api.html#_child_processes
var sys = require('sys');
var exec = require('child_process').exec;
function puts(error, stdout, stderr) { sys.puts(stdout); sys.puts(stderr); sys.puts(error) }


// Create server with default options
var server = require('contentful-webhook-server')({
    path: '/',
    username: 'user',
    password: 'pass'
});
// Start listening for requests on port 3000
server.listen(3000, function(){
    console.log('Contentful webhook server running on port ' + 3000)
});
// Handler for all successful requests
// Is not emitted when an error occurs
server.on('ContentManagement.*', function(topic, req){
    // topic is available as string
    // => e.g. ContentManagement.Asset.unpublish
    console.log('Request came in for: ' + topic);
    exec("git pull", puts);
    exec("middleman contentful", puts);
    exec("middleman build", puts);
    //exec("git add", puts);
    //exec("git commit 'AUTO: Content was updated via Contentful'", puts);
    //exec("git push", puts);
});