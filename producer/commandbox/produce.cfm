<cfscript>
setting requesttimeout="999999";
libs = directoryList( getDirectoryFromPath( getCurrentTemplatePath() ) & "/lib", true, "array", "*.jar" );

// create connection factory
factory = createObject( "java", "com.rabbitmq.client.ConnectionFactory", libs ).init();
factory.setUsername( "rabbitmq" );
factory.setPassword( "rabbitmq" );

// Create a shared connection for this application
connection = factory.newConnection();
// Create new channel for this interaction
channel = connection.createChannel();

// Crete Queue To publish to
channel.queueDeclare( 
	"stock.prices", // Name
	javaCast( "boolean", false ), // durable queue, persist restarts
	javaCast( "boolean", false ), // Exclusive queue, restricted to this connection
	javaCast( "boolean", true ), // autodelete, server will delete if not in use
	javaCast( "null", "" ) // other construction arguments
);

// Get a price generator
priceGenerator = new lib.PriceGenerator();

// Produce 1000 messages
count = 0;
TOTAL_MESSAGES = 100;
while( count++ < TOTAL_MESSAGES ){
	price = priceGenerator.nextPrice();
	systemOutput( "==> (#count#) CommandBox Producing: #price#", true );
	
	// publish
	variables.channel.basicPublish( 
		"", // exchange => default is direct exchange
		"stock.prices", // routing key
		javaCast( "null", "" ), // properties
		price.getBytes() // message body the price in bytes
	);

	// Take a nap
	sleep( 200 );
}

// Close up connections
channel.close();
connection.close();
</cfscript>
