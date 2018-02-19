#!/usr/bin/env node

var amqp = require( 'amqplib/callback_api' );

var results = amqp.connect( 'amqp://rabbitmq:rabbitmq@localhost', function( error, connection ){
	connection.createChannel( function( error, channel ){
		var QUEUE_NAME = 'stock.prices';
		channel.assertQueue( QUEUE_NAME, { durable : false, autoDelete : true } );

		console.log( `[*] Waiting for messages in ${QUEUE_NAME}. To exit press CTRL+C"` );

		channel.consume( 
			QUEUE_NAME, 
			function( message ){
				console.log( ` [x] Received ${ message.content.toString() }` );
			}, 
			{ noAck: false }
		);

	} );

} );