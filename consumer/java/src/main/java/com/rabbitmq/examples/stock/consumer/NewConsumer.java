package com.rabbitmq.examples.stock.consumer;

import com.rabbitmq.client.*;

public class NewConsumer {

    public static void main(String[] args) throws Exception {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setUsername("guest");
        factory.setPassword("guest");

        Connection connection = factory.newConnection();
        Channel channel = connection.createChannel();

        Method queueDeclare = new AMQP.Queue.Declare.Builder()
                .queue("stock.prices")
                .autoDelete(true)
                .build();

        channel.rpc(queueDeclare);

        QueueingConsumer consumer = new QueueingConsumer(channel);
        channel.basicConsume("stock.prices", consumer);

        Thread thread = new Thread(new ConsumerTask(consumer));
        thread.start();

        System.in.read();

        thread.interrupt();
        thread.join();

        channel.close();
        connection.close();
    }
}
