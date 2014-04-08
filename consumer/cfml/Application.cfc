component{

	this.name 					 = "RabbitMQ Consumer";
	this.mappings[ "/rabbitmq" ] = getDirectoryFromPath( getCurrentTemplatePath() );
	this.javaSettings 			 = { loadPaths = [ "/rabbitmq/lib" ] };
	this.applicationTimeout		 = createTimeSpan( 0, 0, 5, 0 );

	function onApplicationStart(){

		// create connection factory
		application.factory = createObject( "java", "com.rabbitmq.client.ConnectionFactory" ).init();
		application.factory.setUsername( "guest" );
		application.factory.setPassword( "guest" );
		// Create a shared connection for this application
		application.connection = application.factory.newConnection();

		return true;
	}

	function onAplicationStop(){
		// close connection
		application.connection.close();
	}

	function onRequestStart( required targetPage ){

		if( structKeyExists( url, "reinit" ) ){ onApplicationStart(); }

		return true;
	}

}