/**
 * This task leverages the push API in RabbitMQ
 */
component{

	/**
	 * Constructor
	 */
    function init(){
        // Load RabbbitMQ Libraries
        directoryList( getCWD() & "/lib", true, "array", "*.jar" )
			.each(
				( item ) => classLoad( item )
			);

        // create connection factory
        var factory = createObject( "java", "com.rabbitmq.client.ConnectionFactory" ).init();
        factory.setUsername( "rabbitmq" );
        factory.setPassword( "rabbitmq" );

        // Create a shared connection for this application
        connection = factory.newConnection( "commandbox-task" );
        // Create new channel for this interaction
        channel = connection.createChannel();
		// The Queue Name
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

	/**
	 * Run the task
	 */
    function run(){
        print.greenBoldLine( " ==> Consumer started in the background." ).toConsole();

		try{
			// Prepare a push consumer
			var consumer = createDynamicProxy(
				new lib.Consumer( channel ),
				[ "com.rabbitmq.client.Consumer" ]
			);
			// Consume with the Stream API
			var consumerTag = channel.basicConsume( QUEUE_NAME, false, consumer );

			// Output
			print.blue( "RabbitMQ Consumer Tag Generated: ")
				.greenline( consumerTag )
				.toConsole();

			while( true ){
				// Monitor the consumer until I finish my task
				sleep( 300 );
			}
		} finally{
			print.redline( "Closing connections down" ).toConsole();
			channel.basicCancel( consumerTag );
			channel.close();
			connection.close();
		}
	}

}
