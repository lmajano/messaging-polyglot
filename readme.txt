========================================================================
RabbitMQ Messaging Polyglot by Luis Majano <lmajano@ortussolutions.com>
========================================================================

This project was originally forked from Rob Harrop
https://github.com/robharrop/presentations

In order to execute the examples you will need to have RabbitMQ Server
installed: http://www.rabbitmq.com/

For the STOMP example you will need to install the web-stomp plugin for
RabbitMQ: http://www.rabbitmq.com/web-stomp.html

The source code is divided into consumers and producers.

Producers:
* Java
* ColdFusion

Consumers:
* ColdFusion : Running a consumer via CFML asynchronously
* Groovy : Running via Groovy
* Java : Running via two Java consumers
* Node : Running using SockJS and node
* Stomp JS : Running via only SockJS and communicating to RabbitMQ via STOMP

RabbitMQ Admin URL
http://localhost:15672/
guest:guest

Default Exchange is the '' empty exchange, which is a direct exchange or 
you can use the amq.direct exchange as well.

The routing key used is "stock.prices" and since it is a direct exchange
the queue name is also "stock.prices"

Stomp Plugin For RabbitMQ URL
http://127.0.0.1:15674/stomp
Valid destination types are: /temp-queue, /exchange, /topic, /queue, /amq/queue, /reply-queue/.

Use /queue for durable queues
Use /amq/queque for default exchange and non-durable queues

AMQP Node Library Used
https://github.com/postwait/node-amqp