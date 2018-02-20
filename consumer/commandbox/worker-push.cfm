<cfscript>
// create connection factory
factory = createObject( "java", "com.rabbitmq.client.ConnectionFactory" ).init();
factory.setUsername( "rabbitmq" );
factory.setPassword( "rabbitmq" );

// Create a shared connection for this application
connection = factory.newConnection();
// Create new channel for this interaction
channel = connection.createChannel();

// Crete Queue we are consuming from
QUEUE_NAME = "stock.prices";
channel.queueDeclare( 
    QUEUE_NAME, // Name
    javaCast( "boolean", false ), // durable queue, persist restarts
    javaCast( "boolean", false ), // Exclusive queue, restricted to this connection
    javaCast( "boolean", true ), // autodelete, server will delete if not in use
    javaCast( "null", "" ) // other construction arguments
);

SystemOutput( " [*] Waiting for messages. To exit press CTRL+C", true );

// create push callbacks
deliver = createDynamicProxy( 
    new lib.Deliver( channel ), 
    [ "com.rabbitmq.client.DeliverCallback" ] 
);
cancel = createDynamicProxy( 
    new lib.Cancel( channel ), 
    [ "com.rabbitmq.client.CancelCallback" ] 
);

channel.basicConsume( QUEUE_NAME, false, deliver, cancel );
</cfscript>