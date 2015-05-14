<!--- 
 *
 * Copyright (c) 2014, the Railo Company Ltd. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either 
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public 
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 * 
 ---><cfcomponent output="no">
	<cfset this.data=struct()>
	<cffunction name="init"
		hint="init method of the component">
		<cfargument name="displayName" required="true" type="string">
		<cfargument name="name" required="true" type="string">
		<cfargument name="defaultValue" required="false" type="string" default="">
		<cfargument name="required" required="false" type="boolean" default="no">
		<cfargument name="description" required="false" type="string" default="">
		<cfargument name="type" required="false" type="string" default="text">
		<cfargument name="defaultValueIndex" required="false" type="number" default="1">
		
		<cfset this.data.displayName=arguments.displayName>
		<cfset this.data.name=trim(arguments.name)>
		<cfset this.data.required=arguments.required>
		<cfset this.data.defaultValue=arguments.defaultValue>
		<cfset this.data.description=arguments.description>
		<cfset this.data.type=arguments.type>
		<cfset this.data.defaultValueIndex=arguments.defaultValueIndex>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getDisplayName" returntype="string" output="no"
		hint="returns the Display Name">
		<cfreturn this.data.displayName>
	</cffunction>
	
	<cffunction name="getName" returntype="string" output="no"
		hint="returns the Name">
        <cfreturn this.data.name>
	</cffunction>
	
	<cffunction name="getDefaultValue" returntype="string" output="no"
		hint="returns the Display Name">
		<cfreturn this.data.defaultValue>
	</cffunction>
	
	<cffunction name="getRequired" returntype="boolean" output="no"
		hint="returns the required value">
		<cfreturn this.data.required>
	</cffunction>
    
	<cffunction name="getData" returntype="struct" output="no"
		hint="returns all data as struct">
		<cfreturn this.data>
	</cffunction>
	
	<cffunction name="getDescription" returntype="string" output="no"
		hint="returns the description value">
		<cfreturn this.data.description>
	</cffunction>
	
	<cffunction name="getType" returntype="string" output="no"
		hint="returns the type of the field, types are [text,password,radio,chckbox,select]">
		<cfreturn this.data.type>
	</cffunction>
	
	<cffunction name="getDefaultValueIndex" returntype="numeric" output="no"
		hint="returns the the index of the default value, when we have a list">
		<cfreturn this.data.defaultValueIndex>
	</cffunction>
</cfcomponent>