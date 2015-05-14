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
// Get a price generator
priceGenerator = new lib.PriceGenerator();
// Produce Price Quotes
while( true ){
	price = priceGenerator.nextPrice();
	systemOutput( "Producing: #price#" & chr(10) );
	// publish
	variables.channel.basicPublish( 
		"", 
		"stock.prices", 
		javaCast( "null", ""),
		price.getBytes() 
	);
	//sleep( 500 );
}
</cfscript>
