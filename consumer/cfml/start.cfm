<cfscript>
	application.stopConsumer = false;

	// Create new channel for this interaction
	application.channel = application.connection.createChannel();

	// Crete Queue just in case
	application.channel.queueDeclare(
		"stock.prices",
		javaCast( "boolean", false ),
		javaCast( "boolean", false ),
		javaCast( "boolean", true ),
		javaCast( "null", "" )
	);

	// Prepare a push consumer
	consumerTask = createDynamicProxy(
		new lib.Consumer( channel ),
		[ "com.rabbitmq.client.Consumer" ]
	);
	// Consume Stream API
	consumerTag = variables.channel.basicConsume( "stock.prices", false, consumerTask );
</cfscript>
<cfoutput>
<h1>Consumer started with consumer tag: #consumerTag#!</h1>
<a href="stop.cfm">Stop Consumer</a>
</cfoutput>