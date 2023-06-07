@Grab( group='com.rabbitmq', module='amqp-client', version='5.17.0' )
import com.rabbitmq.client.*;

// Define Factory
def factory = new ConnectionFactory()
factory.setUsername( "rabbitmq" )
factory.setPassword( "rabbitmq" )

// Open connection + Channel
def connection  = factory.newConnection()
def channel		= connection.createChannel()
def QUEUE_NAME   = 'stock.prices'

// Declare queue
channel.queueDeclare QUEUE_NAME, false, false, true, null

println( " [*] Waiting for messages. To exit press CTRL+C" )

def consumer = new DefaultConsumer( channel ){
    void handleDelivery( String consumerTag, Envelope envelope, AMQP.BasicProperties properties, byte[] body ){

        def message = new String( body, "UTF-8" )
        println "Received message: ${message}"

        // Basic Ack
        println " [x] Done" ;
        channel.basicAck( envelope.getDeliveryTag(), false );
    }
}

// Start consuming messages
channel.basicConsume QUEUE_NAME, false, consumer
