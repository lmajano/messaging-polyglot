component{

	this.name 					 = "RabbitMQ Producer";
	this.mappings[ "/rabbitmq" ] = getDirectoryFromPath( getCurrentTemplatePath() );
	this.javaSettings 			 = { loadPaths = [ "/lib/amqp-client-5.1.2" ] };

	function onApplicationStart(){

		// create connection factory
		application.factory = createObject( "java", "com.rabbitmq.client.ConnectionFactory" ).init();
		application.factory.setUsername( "rabbitmq" );
		application.factory.setPassword( "rabbitmq" );
		// Create a shared connection for this application
		application.connection = application.factory.newConnection();

		return true;
	}

	function onAplicationStop(){
		// close connection
		application.connection.close();
	}

	function onRequestStart( required targetPage ){

		if( structKeyExists( url, "reinit" ) ){
			applicationstop();
		}

		return true;
	}

}