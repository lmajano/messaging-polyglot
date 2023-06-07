/**
 * Generate Prices
 */
component{

	static.TICKER_SYMBOLS = [ "ORTUS", "VMW", "AAPL" ];
	static.RANDOM = createObject( "java", "java.util.Random" );

	/**
	 * Get a price
	 */
	function nextPrice(){
		var ticker 	= static.TICKER_SYMBOLS[ randRange( 1, arrayLen( static.TICKER_SYMBOLS ) ) ];
        var price 	= static.RANDOM.nextFloat() * 7;
        return "#ticker#,#numberFormat( price, '99.99' )#";
	}

}
