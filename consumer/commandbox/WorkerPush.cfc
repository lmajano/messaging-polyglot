/**
 * This task leverages the push API in RabbitMQ
 */
component{

	/**
	 * Constructor
	 */
    function init(){
        // Load RabbbitMQ Libraries
        directoryList( getDirectoryFromPath( getCurrentTemplatePath() ) & "/lib", true, "array", "*.jar" )
            .each( function( item ){
                loadJar( item );
            } );

        // create connection factory
        variables.factory = createObject( "java", "com.rabbitmq.client.ConnectionFactory" ).init();
        variables.factory.setUsername( "rabbitmq" );
        variables.factory.setPassword( "rabbitmq" );

        // Create a shared connection for this application
        variables.connection = factory.newConnection( "commandbox-task" );
        // Create new channel for this interaction
        variables.channel = connection.createChannel();
		// The Queue Name
		variables.queueName = "stock.prices";
        // Crete Queue we are consuming from
        variables.channel.queueDeclare(
            variables.queueName, // Name
            javaCast( "boolean", false ), // durable queue, persist restarts
            javaCast( "boolean", false ), // Exclusive queue, restricted to this connection
            javaCast( "boolean", true ), // autodelete, server will delete if not in use
            javaCast( "null", "" ) // other construction arguments
        );
    }

	/**
	 * Run the task
	 */
    function run(){
        print.greenBoldLine( " ==> Consumer started in the background." );

		// Prepare a push consumer
        var consumer = createDynamicProxy(
            new lib.Consumer( channel ),
            [ "com.rabbitmq.client.Consumer" ]
		);
		// Consume Stream API
		var consumerTag = variables.channel.basicConsume( variables.queueName, false, consumer );

		// Output
		print.blue( "RabbitMQ Consumer Tag Generated: ")
			.greenline( consumerTag );
	}

}