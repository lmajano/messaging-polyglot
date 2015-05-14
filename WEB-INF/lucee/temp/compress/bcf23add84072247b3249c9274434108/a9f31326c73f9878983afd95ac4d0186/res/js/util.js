/*! LUCEE.util version 1.0 */

var __LUCEE = __LUCEE || {};


__LUCEE.util = 	{

	getCookie: 			function( name, def ) {

		var cookies = document.cookie.split( '; ' );
		var len = cookies.length;
		var parts;

		for ( var i=0; i<len; i++ ) {

			parts = cookies[ i ].split( '=' );

			if ( parts[ 0 ] == name )
				return unescape( parts[ 1 ] );
		}

		return def;
	}

	, getCookieNames:	function() {

		var result = [];
		var cookies = document.cookie.split( '; ' );
		var len = cookies.length;
		var parts;

		for ( var i=0; i<len; i++ ) {

			parts = cookies[ i ].split( '=' );
			result.push( parts[ 0 ] );
		}

		return result;
	}

	, setCookie: 		function( name, value, expires ) {

		document.cookie = name + "=" + escape( value ) + ( (expires) ? "; expires=" + expires.toGMTString() : "" ) + "; path=/";
	}

	, removeCookie: 	function( name ) {

		__LUCEE.util.setCookie( name, "", new Date( 0 ) );
	}

	, getDomObject: 	function( obj ) {			// returns the element if it is an object, or finds the object by id */

		if ( typeof obj == 'string' || obj instanceof String )
			return document.getElementById( obj );

		return obj;
	}

	, hasClass: 		function( obj, cls ) {

		obj = __LUCEE.util.getDomObject( obj );
		return ( obj.className.indexOf( cls ) > -1 );
	}

	, addClass: 		function( obj, cls ) {

		if ( __LUCEE.util.hasClass( obj, cls ) )
			return;

		obj = __LUCEE.util.getDomObject( obj );
		obj.className += " " + cls;
	}

	, removeClass: 		function( obj, cls ) {

		obj = __LUCEE.util.getDomObject( obj );
		obj.className = obj.className.replace( cls, "" );
	}

	, toggleClass: 		function( obj, cls ) {

		obj = __LUCEE.util.getDomObject( obj );

		if ( __LUCEE.util.hasClass( obj, cls ) )
			__LUCEE.util.removeClass( obj, cls );
		else
			__LUCEE.util.addClass( obj, cls );

		return ( __LUCEE.util.hasClass( obj, cls ) );
	}

	, selectText: 	function( id ) {

        if ( document.selection ) {

            var range = document.body.createTextRange();
            range.moveToElementText( getDomObject( obj ) );
            range.select();
        } else if ( window.getSelection ) {

            var range = document.createRange();
            range.selectNodeContents( getDomObject( obj ) );
            window.getSelection().removeAllRanges();
            window.getSelection().addRange( range );
        }
    }
};
