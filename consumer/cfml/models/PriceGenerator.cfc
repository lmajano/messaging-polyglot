/**
 * Generate Prices
 */
component{

	variables.TICKER_SYMBOLS = [ "ORTUS", "VMW", "AAPL" ];

	/**
	 * Constructor
	 */
	function init(){
		variables.random = createObject( "java", "java.util.Random" ).init();
		return this;
	}

	/**
	 * Get a price
	 */
	function nextPrice(){
		var ticker 	= variables.TICKER_SYMBOLS[ randRange( 1, arrayLen( variables.TICKER_SYMBOLS ) ) ];
        var price 	= random.nextFloat() * 7;
        return "#ticker#,#numberFormat( price, '99.99' )#";
	}

}