var http        = require('http');
var sockjs      = require('sockjs');
var amqp        = require('amqp');
var node_static = require('node-static');
var util        = require('util');

var sockjs_opts = {sockjs_url: "http://cdn.sockjs.org/sockjs-0.2.min.js"};

// Sock JS Server
var stocks_server = sockjs.createServer(sockjs_opts);
stocks_server.on('connection', function(client) {
    amqp_connect(client);
});

// AMQP Adapter
function amqp_connect(client) {
    var connection = amqp.createConnection({'host': '127.0.0.1', 'port': 5672});

    connection.on('ready', function() {
        var args = {'exclusive': true, 'autoDelete': true};

        connection.queue('', args,
                         function(queue) {
                             queue.bind('amq.direct', 'stock.prices');
                             queue.subscribe(function(message) {
                                 client.write(message.data.toString());
                             });
                         });
    });
}

// Static files server
var static_directory = new node_static.Server(__dirname);

// Usual http stuff
var server = http.createServer();
server.addListener('request',
                   function(req, res) {
                       static_directory.serve(req, res);
                   });

server.addListener('upgrade',
                   function(req,res){
                       res.end();
                   });

stocks_server.installHandlers(server, {prefix:'[/]stocks'});
server.listen(8080);


