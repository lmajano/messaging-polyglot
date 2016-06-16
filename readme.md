# RabbitMQ Messaging Polyglot by Luis Majano <lmajano@ortussolutions.com>

> This project was originally forked from Rob Harrop
https://github.com/robharrop/presentations

# Rabbit MQ
In order to execute the examples you will need to have RabbitMQ Server
installed: http://www.rabbitmq.com/

For the STOMP example you will need to install the web-stomp plugin for
RabbitMQ: http://www.rabbitmq.com/web-stomp.html

# Start the Server
Invoke the `sbin/rabbitmq-server` shell script. 

You can also start the server in **detached** mode with `rabbitmq-server -detached`, in which case the server process runs in the background.

## Configure the Server
You can customise the RabbitMQ environment by setting environment variables in `$RABBITMQ_HOME/etc/rabbitmq/rabbitmq-env.conf`. Server components may be configured, too, in the RabbitMQ configuration file located at `$RABBITMQ_HOME/etc/rabbitmq/rabbitmq.config`. Neither of these files exist after installation.

## Default user access
The broker creates a user `guest` with password `guest`. Unconfigured clients will in general use these credentials. By default, these credentials can only be used when connecting to the broker as `localhost` so you will need to take action before connecting fromn any other machine.

## RabbitMQ Management Plugin
Install the managment plugin first
`rabbitmq-plugins enable rabbitmq_management`

More information at: https://www.rabbitmq.com/management.html

### RabbitMQ Admin URL
http://localhost:15672/
`guest:guest`

## RabbitMQ STOMP Plugin
Install the plugin:
`rabbitmq-plugins enable rabbitmq_web_stomp`

More information at: http://www.rabbitmq.com/web-stomp.html

----

# Source Code
The source code is divided into consumers and producers.

## Producers:
* Java
* ColdFusion

## Consumers:
* ColdFusion : Running a consumer via CFML asynchronously
* Groovy : Running via Groovy
* Java : Running via two Java consumers
* Node : Running using SockJS and node
* Stomp JS : Running via only SockJS and communicating to RabbitMQ via STOMP


Default Exchange is the `''` empty exchange, which is a direct exchange or 
you can use the amq.direct exchange as well.

The routing key used is `stock.prices` and since it is a direct exchange
the queue name is also `stock.prices`

## Stomp Plugin For RabbitMQ URL
http://127.0.0.1:15674/stomp
Valid destination types are: `/temp-queue, /exchange, /topic, /queue, /amq/queue, /reply-queue/`.

Use `/queue` for durable queues
Use `/amq/queque` for default exchange and non-durable queues

## AMQP Node Library Used
https://github.com/postwait/node-amqp