# RabbitMQ :rabbit: Messaging Polyglot

>by Luis Majano <lmajano@ortussolutions.com>

** This project was originally forked from Rob Harrop
https://github.com/robharrop/presentations

## Rabbit MQ Setup

In order to execute the examples you will need to have RabbitMQ Server
installed: https://www.rabbitmq.com/ and for the STOMP example you will need to install the web-stomp plugin for
RabbitMQ: https://www.rabbitmq.com/web-stomp.html

> The Web STOMP plugin makes it possible to use STOMP over a WebSocket connection.

### Docker Setup

However, we have also provide a `docker-compose.yml` file for doing all this for you :rocket:.  You run `docker-compose up` in the root of this project and it will run a RabbitMQ server for you with all the necessary plugins installed.

The default credentials are `rabbitmq` for both username and password.  You can change them in the docker compose file.

### Traditional Setup

Invoke the `sbin/rabbitmq-server` shell script.

You can also start the server in **detached** mode with `rabbitmq-server -detached`, in which case the server process runs in the background.

You can customise the RabbitMQ environment by setting environment variables in `$RABBITMQ_HOME/etc/rabbitmq/rabbitmq-env.conf`. Server components may be configured, too, in the RabbitMQ configuration file located at `$RABBITMQ_HOME/etc/rabbitmq/rabbitmq.config`. Neither of these files exist after installation.

The broker creates a user `rabbitmq` with password `rabbitmq`. Unconfigured clients will in general use these credentials. By default, these credentials can only be used when connecting to the broker as `localhost` so you will need to take action before connecting from any other machine.

### RabbitMQ Management Plugin

Install the managment plugin first
`rabbitmq-plugins enable rabbitmq_management`

More information at: https://www.rabbitmq.com/management.html

### RabbitMQ Admin URL

http://localhost:15672/

Credentials: `guest:guest`

### RabbitMQ STOMP Plugin

Install the plugin:

```bash
rabbitmq-plugins enable rabbitmq_web_stomp
```

More information at: http://www.rabbitmq.com/web-stomp.html

----

## Source Code

The source code is divided into **consumers** and **producers**.  You can see many examples here for RabbitMQ implementations: https://www.rabbitmq.com/getstarted.html

## Producers

* Java - Native Java
* CFML - ColdFusion (A web app)
* CommandBox - CFML CLI based worker

## Consumers

* ColdFusion : Running a consumer via CFML asynchronously
* CommandBox : CFML CLI based workers
* Groovy : Running via Groovy
* Java : Running via native Java consumers
* Node : Running using `amqplib` and node
* Stomp : Running via `stompjs`, websockets and RabbbitMQ

We will be using the **Default Exchange** which is the `''` empty exchange, which is a [direct](https://www.rabbitmq.com/tutorials/tutorial-two-python.html) exchange or you can use the `amq.direct` exchange as well.

The routing key used is `stock.prices` and since it is a direct exchange
the queue name is also `stock.prices`

## Stomp Plugin For RabbitMQ URL

http://127.0.0.1:15674/stomp

Valid destination types are: `/temp-queue, /exchange, /topic, /queue, /amq/queue, /reply-queue/`.

Use `/queue` for durable queues
Use `/amq/queque` for default exchange and non-durable queues
