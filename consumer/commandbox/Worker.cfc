/**
 * Polling connection worker
 */
component{

    function init(){
        // Load RabbbitMQ Libraries
        directoryList( getCWD() & "/lib", true, "array", "*.jar" )
			.each(
				( item ) => loadJar( item )
			);

        // create connection factory
        var factory = createObject( "java", "com.rabbitmq.client.ConnectionFactory" ).init();
        factory.setUsername( "rabbitmq" );
        factory.setPassword( "rabbitmq" );

        // Create a shared connection for this application
        connection = factory.newConnection();
        // Create new channel for this interaction
        channel = connection.createChannel();
		// Queue name
        QUEUE_NAME = "stock.prices";
        // Crete Queue we are consuming from
        channel.queueDeclare(
            QUEUE_NAME, // Name
            false, // durable queue, persist restarts
            false, // Exclusive queue, restricted to this connection
            true, // autodelete, server will delete if not in use
            nullValue() // other construction arguments
        );
    }

    function run(){
        print.blueLine( " [*] Waiting for messages. To exit press CTRL+C" ).toConsole();
        try{
			while( true ){
				// Go fetch
				var response = channel.basicGet( QUEUE_NAME, false );

				if( !isNull( response ) ){
					print.boldGreenLine( "=> Got #response.getBody()#" ).toConsole();
				}

				// sleep a bit and wait some more
				sleep( 300 );
			}
		} finally {
			print.redline( "Closing connections down" ).toConsole();
			channel.close();
			connection.close();
		}
    }
}