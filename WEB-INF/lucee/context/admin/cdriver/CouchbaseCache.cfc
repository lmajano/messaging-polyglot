<cfcomponent extends="Cache">

    <cfscript>
		try{
			// only validate if not in trial, this is replaced by build process
			if( false ){
				admin
					action="storageGet"
					type="#request.adminType#"
					password='#session[ "password" & request.adminType ]#'
					key="ortus-couchbase-extension-#request.adminType#"
					returnVariable="licData";
			}
		} catch( Any e ){
			throw( type="InvalidLicenseActivation", message="Your Ortus Couchbase Extension has not been activated, please reinstall it." );
		}
    </cfscript>

    <cfset fields=array(
			field(	displayName="Couchbase Server Hosts",
					name="hosts",
					defaultValue="localhost:8091",
					required=true,
					description="Couchbase server host and port. Ex: localhost:8091<br>
						Put each server and port on a new line.",
					type="textarea"
				),

			field(	displayName="Couchbase vBucket Name",
					name="bucketName",
					defaultValue="default",
					required=true,
					description="Couchbase vBucket to connect to.",
					type="text"
				),

			field(	displayName="Bucket password",
					name="password",
					defaultValue="",
					required=false,
					description="Password for this bucket.  Probalby blank if using ""default"" bucket.",
					type="password"
				),

			field(	displayName="Operation Queue Max Block Time",
					name="opQueueMaxBlockTime",
					defaultValue="10000",
					required=false,
					description="The maximum time to block waiting for op queue operations to complete, in milliseconds. <br>The default has been set with the expectation that most requests are interactive and waiting for more than a few seconds is thus more undesirable than failing the request. However, this value could be lowered for operations not to block for this time.",
					type="text"
				),

			field(	displayName="Operation Timeout",
					name="opTimeout",
					defaultValue="2500",
					required=false,
					description="Time in millisecs for an operation to Timeout.  <br>You can set this value higher when there is heavy network traffic and timeouts happen frequently.",
					type="text"
				),

			field(	displayName="Timeout Exception Threshold",
					name="timeoutExceptionThreshold",
					defaultValue="998",
					required=false,
					description="Number of operations to timeout before the node is deemed down. <br>You can set this value lower to deem a node is down earlier.",
					type="text"
				)
	)>

	<cffunction name="getClass" returntype="string">
    	<cfreturn "ortus.extension.cache.couchbase.CouchbaseCache">
    </cffunction>

	<cffunction name="getLabel" returntype="string" output="no">
    	<cfreturn "Couchbase Server">
    </cffunction>

	<cffunction name="getDescription" returntype="string" output="no">
    	<cfset var c="">
    	<cfsavecontent variable="c">
		This is the Couchbase Cache implementation for Lucee.
        </cfsavecontent>
    	<cfreturn trim(c)>
    </cffunction>

</cfcomponent>