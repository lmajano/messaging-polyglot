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

			var delivery = variables.consumer.nextDelivery();
			var message  = toString( delivery.getBody() );

			writeDump( var="Consumer (#variables.id#) got #message#", output="console" );
		}

		writeDump( var="Stopping Task : #variables.id#", output="console" );
	}

}