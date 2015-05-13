<cfscript>
libs = directoryList( getDirectoryFromPath( getCurrentTemplatePath() ) & "/lib", false, "array", "*.jar" );
// create connection factory
factory = createObject( "java", "com.rabbitmq.client.ConnectionFactory", libs ).init();
factory.setUsername( "guest" );
factory.setPassword( "guest" );
// Create a shared connection for this application
connection = factory.newConnection();
// Create new channel for this interaction
channel = connection.createChannel();
// Crete Queue just in case
channel.queueDeclare( 
	"stock.prices", 
	javaCast( "boolean", false ), 
	javaCast( "boolean", false ), 
	javaCast( "boolean", true ), 
	javaCast( "null", "" ) 
);
// Create a new queue consumer
consumer = createObject( "java", "com.rabbitmq.client.QueueingConsumer", libs )
	.init( channel );
// Tell the channel to start consuming
channel.basicConsume( "stock.prices", consumer );
SystemOutput( "Consumer started, press CTRL[c] to quit..." & chr( 10 ) );
// Hang around until we quit commandbox
while( true ){
	try{
		delivery = consumer.nextDelivery();
		message  = toString( delivery.getBody() );

		// Manual Ack, meaning the consumer has worked on it and bytes have made it here.
		//consumer.getChannel().basicAck( delivery.getEnvelope().getDeliveryTag(), javaCast( "Boolean", false ) );
	}
	catch(Any e){
		SystemOutput( "Error retrieving message: #e.detail# #e.message#" );
		abort;
	}

	SystemOutput( "Got #message#" & chr( 10 ) );
}
</cfscript>