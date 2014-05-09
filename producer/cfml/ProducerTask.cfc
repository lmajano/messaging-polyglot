/**
* A runnable task that implmements runnable via dynamic proxy
*/
component accessors="true"{

	property name="channel";
	property name="id";
	property name="priceGenerator";

	function init( channel ){
		variables.id 				= left( createUUID(), 3 );
		variables.channel   		= arguments.channel;
		variables.priceGenerator 	= new PriceGenerator();

		// application reference
		variables.app 		= application;
		return this;
	}

	function run(){

		while( !variables.app.stopProducer ){
			var price = variables.priceGenerator.nextPrice();
			writeDump( var="Producing: #price#", output="console" );

			variables.channel.basicPublish( "amq.direct", 
											"stock.prices", 
											javaCast( "null", ""),
											price.getBytes() );

			sleep( 500 );
		}

		writeDump( var="Stopping Producer : #variables.id#", output="console" );
	}

}