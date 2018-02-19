/**
* A runnable task that implmements runnable via dynamic proxy
*/
component accessors="true"{

	property name="channel";
	property name="id";
	property name="priceGenerator";

	/**
	 * Constructor
	 *
	 * @channel The RabbitMQ Channel
	 */
	function init( channel ){
		variables.id 				= left( createUUID(), 3 );
		variables.channel   		= arguments.channel;
		variables.priceGenerator 	= new PriceGenerator();

		// application reference
		variables.app = application;
		return this;
	}

	/**
	 * Run it baby!
	 */
	function run(){

		// Run until you are stopped
		while( !variables.app.stopProducer ){
			var price = variables.priceGenerator.nextPrice();
			writeDump( var="Producing: #price#", output="console" );

			variables.channel.basicPublish( 
				"", // exchange => default is direct exchange
				"stock.prices", // routing key
				javaCast( "null", "" ), // properties
				price.getBytes() // message body the price in bytes
			);

			sleep( 500 );
		}

		writeDump( var="Stopping Producer : #variables.id#", output="console" );
	}

}