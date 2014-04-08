package com.rabbitmq.examples.stock.consumer;

import com.rabbitmq.client.*;

public class Consumer {

    public static void main(String[] args) throws Exception {
		// Create a new factory with Credentials
        ConnectionFactory factory = new ConnectionFactory();
        factory.setUsername( "guest" );
        factory.setPassword( "guest" );
		
		// create new connection + channel
        Connection connection	= factory.newConnection();
        Channel channel			= connection.createChannel();
		
		// Declare a new queue
		// Args: queueName, durable, exclusive, autoDelete, arguments
        channel.queueDeclare( "stock.prices", false, false, true, null );
		
		// Create a new queue consumer
        QueueingConsumer consumer = new QueueingConsumer( channel );
        // Tell the channel to start consuming
		channel.basicConsume( "stock.prices", consumer );
		
		// Create a new start for consuming
        Thread thread = new Thread( new ConsumerTask( consumer ) );
        thread.start();

        System.in.read();

        thread.interrupt();
        thread.join();

        channel.close();
        connection.close();
    }

}
