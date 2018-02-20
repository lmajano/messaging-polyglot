component accessors="true"{

    /**
     * Constructor
     */
    function init( required channel, consumerTag = "" ){
        variables.channel       = arguments.channel;
        variables.consumerTag   = arguments.consumerTag;

        return this;
    }

    /**
     * No-op implementation of {@link Consumer#handleCancel}.
     * @param consumerTag the defined consumer tag (client- or server-generated)
     */
    public void function handleCancel( String consumerTag ){
        // no work to do
    }

    /**
     * No-op implementation of {@link Consumer#handleCancelOk}.
     * @param consumerTag the defined consumer tag (client- or server-generated)
     */
    public void function handleCancelOk( String consumerTag ){
        // no work to do
    }

     /**
     * Stores the most recently passed-in consumerTag - semantically, there should be only one.
     * @see Consumer#handleConsumeOk
     */
    public void function handleConsumeOk( String consumerTag ){
        variables.consumerTag = arguments.consumerTag;
    }

     /**
     * No-op implementation of {@link Consumer#handleDelivery}.
     */
    public void function handleDelivery( 
        consumerTag,
        envelope,
        properties,
        body
    ){
        systemOutput( " [x] Received #body# ", true );
        
        // Basic Ack
        channel.basicAck( envelope.getDeliveryTag(), false );
        systemOutput( " [x] Done", true );
    }

    /**
     * No-op implementation of {@link Consumer#handleRecoverOk}.
     */
    public void function handleRecoverOk(){
        // no work to do
    }

    /**
     * No-op implementation of {@link Consumer#handleShutdownSignal}.
     */
    public void function handleShutdownSignal( String consumerTag, sig ){
        // no work to do
    }

}