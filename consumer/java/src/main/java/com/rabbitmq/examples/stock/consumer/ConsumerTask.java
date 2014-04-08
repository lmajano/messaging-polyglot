package com.rabbitmq.examples.stock.consumer;

import com.rabbitmq.client.QueueingConsumer;

final class ConsumerTask implements Runnable {
    private final QueueingConsumer consumer;

	/**
	 * Constructor
	 * @param consumer 
	 */
    public ConsumerTask( QueueingConsumer consumer ){
		// store the incoming channel consumer
        this.consumer = consumer;
    }

	/**
	 * Run the thread
	 */
    public void run() {
        while( !Thread.interrupted() ){
            try {
				System.out.println( "Waiting for messages..." );
				// Get the next incoming delivery message
                QueueingConsumer.Delivery delivery = this.consumer.nextDelivery();
				// get message out
                String message = new String( delivery.getBody() );
				// print it out
                System.out.println( "Consumer Got: " + message );
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
}
