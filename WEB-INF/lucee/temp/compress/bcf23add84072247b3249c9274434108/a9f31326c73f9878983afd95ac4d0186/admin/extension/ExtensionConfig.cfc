<!--- 
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
 ---><cfcomponent>

	<cfset this.steps=array()>
	
	<cffunction name="createStep" output="no"
    	hint="create a new step cfc">
    	<cfargument name="label" type="string" default="">
    	<cfargument name="description" type="string" default="">
        
        <cfset var step=createObject('component','ExtensionStep').init(label,description)>
        <cfset ArrayAppend(this.steps,step)>
    	<cfreturn step>
    </cffunction>
    
	<cffunction name="getSteps" output="no" returntype="array"
    	hint="return all created steps">
    	<cfreturn this.steps>
    </cffunction>
    
    
</cfcomponent>