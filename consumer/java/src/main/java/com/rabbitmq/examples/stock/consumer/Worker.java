package com.rabbitmq.examples.stock.consumer;

import com.rabbitmq.client.*;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

public class Worker {

	public static void main(String[] args) throws Exception {
		// Create a new factory with Credentials
		ConnectionFactory factory = new ConnectionFactory();
		factory.setUsername("rabbitmq");
		factory.setPassword("rabbitmq");

		// create new connection + channel
		Connection connection = factory.newConnection();
		Channel channel = connection.createChannel();

		// Declare a new queue, just in case producer has not
		// Args: queueName, durable, exclusive, autoDelete, arguments
		String queueName = channel
				.queueDeclare("stock.prices", false, false, true, null)
				.getQueue();

		System.out.println(" [*] Waiting for messages. To exit press CTRL+C");

		// Create a new consumer for the messages
		final Consumer consumer = new DefaultConsumer(channel) {

			@Override
			public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties,
					byte[] body)
					throws IOException {

				String message = new String(body, StandardCharsets.UTF_8);
				System.out.println(" [x] Received '" + message + "'");

				// Do work on it
				doWork(message);

				// Basic Ack
				System.out.println(" [x] Done");
				channel.basicAck(envelope.getDeliveryTag(), false);
			}
		};

		// Tell the channel to start consuming with no Auto Ack
		channel.basicConsume(queueName, false, consumer);

	}

	/**
	 * Basically just sleep for 1 second if a . is declared in the incoming message
	 *
	 * @param message The incoming message to work on
	 */
	private static void doWork(String message) {
		for (char ch : message.toCharArray()) {
			if (ch == '.') {
				try {
					Thread.sleep(1000);
				} catch (InterruptedException _ignored) {
					Thread.currentThread().interrupt();
				}
			}
		}
	}

}
