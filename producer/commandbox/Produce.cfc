component{

    function init(){
        // Load RabbbitMQ Libraries
        directoryList( getDirectoryFromPath( getCurrentTemplatePath() ) & "/lib", true, "array", "*.jar" )
            .each( function( item ){
                loadJar( item );
            } );

        // create connection factory
        factory = createObject( "java", "com.rabbitmq.client.ConnectionFactory" ).init();
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
            QUEUE_NAME, // Name
            javaCast( "boolean", false ), // durable queue, persist restarts
            javaCast( "boolean", false ), // Exclusive queue, restricted to this connection
            javaCast( "boolean", true ), // autodelete, server will delete if not in use
            javaCast( "null", "" ) // other construction arguments
        );
    }

    /**
     * Run the task
     *
     * @num How many messages to send
     */
    function run( num=100 ){
        // Produce messages
        var count = 0;
        while( count++ < arguments.num ){
            var price = priceGenerator.nextPrice();
            systemOutput( "==> (#count#) CommandBox Producing: #price#", true );
            
            // publish
            variables.channel.basicPublish( 
                "", // exchange => default is direct exchange
                QUEUE_NAME, // routing key
                javaCast( "null", "" ), // properties
                price.getBytes() // message body the price in bytes
            );

            // Take a nap
            sleep( 200 );
        }

        // Close up connections
        channel.close();
        connection.close();
    }

}