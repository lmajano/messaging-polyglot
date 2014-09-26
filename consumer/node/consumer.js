var http        = require( 'http' );
var sockjs      = require( 'sockjs' );
var amqp        = require( 'amqp' );
var node_static = require( 'node-static' );
var util        = require( 'util' );

var sockjs_opts = { sockjs_url: "http://cdn.sockjs.org/sockjs-0.2.min.js" };

// Sock JS Server
var stocks_server = sockjs.createServer( sockjs_opts );
stocks_server.on('connection', function( client ) {
	//console.log( 'connection' + client );
    amqp_connect( client );
});

// AMQP Adapter
function amqp_connect( client ){
	// Connect to RabbitMQ
    var connection = amqp.createConnection({ 
		'host'	: 'localhost', 
		'port'	: 5672,
		'login'	: 'guest',
		'password': 'guest'
	});
	
	// on ready consume
    connection.on('ready', function() {
        var args = { 'exclusive': false, 'autoDelete': true, 'durable' : false };

        connection.queue( 'stock.prices', args, function( queue ) {
			//queue.bind( '', 'stock.prices' );
			queue.subscribe( function( message, headers, deliveryInfo, messageObject ){
				// Write it out to the socket
				client.write( message.data.toString() );
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

// SockJS install handlers
stocks_server.installHandlers( server, { prefix:'[/]stocks' } );

server.listen( 8080 );


