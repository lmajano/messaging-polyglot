<cfscript>
	application.stoptasks = false;
	
	// Create new channel for this interaction
	application.channel = application.connection.createChannel();

	// Crete Queue
	application.channel.queueDeclare( "stock.prices", 
						  javaCast( "boolean", false ), 
						  javaCast( "boolean", false ), 
						  javaCast( "boolean", true ), 
						  javaCast( "null", "" ) );

	// Create a new queue consumer
    consumer = createObject( "java", "com.rabbitmq.client.QueueingConsumer" ).init( application.channel );
    // Tell the channel to start consuming
	application.channel.basicConsume( "stock.prices", consumer );
	
	// create task
	consumerTask = createDynamicProxy( new ConsumerTask( consumer ), [ "java.lang.Runnable" ] );
	
	// Create a new start for consuming
    thread = createObject( "java", "java.lang.Thread" )
    	.init( consumerTask )
    	.start();

</cfscript>
<h1>Task started!</h1>
<a href="stop.cfm">Stop Task</a>