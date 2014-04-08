<cfscript>
	application.stoptasks = true;
	try{
		application.channel.close();
	}
	catch( any e ){
		writeDump( var="Channel already closed", output="console" );
	}
</cfscript>
<h1>Tasks stopped, channel stopped!</h1>