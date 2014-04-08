package com.rabbitmq.examples.stock.publisher;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

public class Publisher {

    public static void main(String[] args) throws Exception {
		// Create a new ConnectionFactory
        ConnectionFactory factory = new ConnectionFactory();
		// Setup the host's credentials, we use the default ones
        factory.setUsername( "guest" );
        factory.setPassword( "guest" );
		
		// Create a new connection and channel
        Connection connection	= factory.newConnection();
        Channel channel			= connection.createChannel();

		// Spin up a new thread and start it with our producing task
        Thread thread = new Thread( new PublishTask( channel ) );
        thread.start();
        
		System.in.read();
        thread.interrupt();
		
		// close channel and connection
        channel.close();
        connection.close();
    }

}
