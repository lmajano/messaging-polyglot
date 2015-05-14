/**
* A runnable task that implmements runnable via dynamic proxy
*/
component accessors="true"{

	property name="consumer";
	property name="id";

	function init( consumer ){
		variables.id 		= left( createUUID(), 3 );
		variables.consumer  = arguments.consumer;
		// application reference
		variables.app 		= application;
		return this;
	}

	function run(){

		while( !variables.app.stopTasks ){
			writeDump( var="Consumer (#variables.id#) waiting for messages...", output="console" );

			try{
				var delivery = variables.consumer.nextDelivery();
				var message  = toString( delivery.getBody() );

				// Manual Ack, meaning the consumer has worked on it and bytes have made it here.
				variables.consumer.getChannel().basicAck( delivery.getEnvelope().getDeliveryTag(), javaCast( "Boolean", false ) );

				writeDump( var="Consumer (#variables.id#) got #message#", output="console" );
			}
			catch(Any e){
				writeDump( var="Error retrieving message: #e.detail# #e.message#", output="console" );
				variables.app.stopTasks = true;
			}
		}

		writeDump( var="Stopping Task : #variables.id#", output="console" );
	}

}