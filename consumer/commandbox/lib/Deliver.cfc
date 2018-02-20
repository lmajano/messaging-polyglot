/**
* A runnable task that implmements runnable via dynamic proxy
*/
component accessors="true"{

    property name="channel";

    /**
	 * Constructor
	 *
	 * @channel The RabbitMQ Channel
	 */
	function init( channel ){
		variables.id 				= left( createUUID(), 3 );
		variables.channel   		= arguments.channel;

		// application reference
		variables.app = application;
		return this;
    }
    
    /**
     * Callback interface to be notified when a message is delivered.
     */
    function handle( consumerTag, message ){
        SystemOutput( "Got #message.getBody()#", true );
    }

}