package com.rabbitmq.examples.stock.publisher;

import com.rabbitmq.client.Channel;
import java.io.IOException;

final class PublishTask implements Runnable {
	// The rabbitmq channel to connect to
    private final Channel channel;

	/**
	 * Constructor
	 * @param channel 
	 */
	public PublishTask( Channel channel ){
        this.channel = channel;
    }

	/**
	 * Execute task
	 */
    public void run() {
		// create new instance of a price generator
        PriceGenerator generator = new PriceGenerator();
		// run until interrupted
        while( !Thread.interrupted() ){

            try{
                // get a new price and output it
				String price = generator.nextPrice();
                System.out.println( price );
                
				// Publish this on the 'stock.prices' queue
				// Args: exchange, routingKey, props, body
				channel.basicPublish( "", "stock.prices", null, price.getBytes() );
				
				// sleep for a bit
               // Thread.sleep(500);
				
            } catch( IOException e ){
                e.printStackTrace();
			}
			
        }
    }
}
