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

        // Crete Queue we are consuming from
        channel.queueDeclare( 
            "stock.prices", // Name
            javaCast( "boolean", false ), // durable queue, persist restarts
            javaCast( "boolean", false ), // Exclusive queue, restricted to this connection
            javaCast( "boolean", true ), // autodelete, server will delete if not in use
            javaCast( "null", "" ) // other construction arguments
        );
    }

    function run(){
        SystemOutput( " [*] Waiting for messages. To exit press CTRL+C", true );

        var consumer = createDynamicProxy( 
            new lib.Consumer( channel ), 
            [ "com.rabbitmq.client.Consumer" ] 
        );
        channel.basicConsume( "stock.prices", false, consumer );

        while( true ){
            sleep( 200 );
        }
    }
}