/**
 * This is a RabbitMQ Producer Task you can execute it like so:
 * {code}
 * // Send default of 100 messages
 * task run Produce
 * // Send 10 messages
 * task run Produce 10
 * {code}
 */
component{

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
        connection = factory.newConnection();
        // Create new channel for this interaction
        channel = connection.createChannel();
        // Get a price generator
        priceGenerator = new lib.PriceGenerator();
        // Queue name
        QUEUE_NAME = "stock.prices";
        // Crete Queue To publish to
        channel.queueDeclare(
            QUEUE_NAME, // Queue Name for bindings
            false, // durable queue, persist restarts
            false, // Exclusive queue, restricted to this connection
            true, // autodelete, server will delete if not in use
            nullValue() // other construction arguments
        );
    }

    /**
     * Send messages to RabbitMQ
     * @num How many messages to send
     */
    function run( num=100 ){
		try{
			// Produce messages
			var count = 0;
			while( count++ < arguments.num ){
				var price = priceGenerator.nextPrice();
				print.greenLine( "==> (#count#) CommandBox Producing: #price#" ).toConsole();

				// Rabbit MQ Publish
				channel.basicPublish(
					"", // exchange => default is direct exchange
					QUEUE_NAME, // routing key
					nullValue(), // properties
					price.getBytes() // message body the price in bytes
				);

				// Take a nap before producing another price
				sleep( 200 );
			}
		} finally{
			print.redLine( "Closing down channel + connection" ).toConsole();
			// Close up connections
			channel.close();
			connection.close();
		}

    }

}
