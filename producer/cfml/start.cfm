<cfscript>
	application.stopProducer = false;
	
	// Create new channel for this interaction
	application.channel = application.connection.createChannel();
	// create task
	producerTask = createDynamicProxy( new ProducerTask( application.channel ), [ "java.lang.Runnable" ] );
	
	// Create a new start for consuming
    thread = createObject( "java", "java.lang.Thread" )
    	.init( producerTask )
    	.start();

</cfscript>
<h1>Publisher started!</h1>
<a href="stop.cfm">Stop Publisher</a>