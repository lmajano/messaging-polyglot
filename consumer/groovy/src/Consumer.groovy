import com.rabbitmq.client.*;

//@Grab(group='com.rabbitmq', module='amqp-client', version='3.3.1')

def factory = new ConnectionFactory()
factory.setUsername( "guest" )
factory.setPassword( "guest" )

def connection  = factory.newConnection()
def channel		= connection.createChannel()

def queueName = 'stock.prices'

channel.queueDeclare queueName, true, false, false, null

def consumer = new QueueingConsumer( channel )
channel.basicConsume queueName, consumer

while (true) {
    delivery = consumer.nextDelivery()
    println "Received message: ${new String(delivery.body)}"
    channel.basicAck delivery.envelope.deliveryTag, false
}

channel.close()
conn.close()