package com.rabbitmq.examples.stock.publisher;

import java.util.Random;

public final class PriceGenerator {
    
	private static final String[] TICKER_SYMBOLS = { "GOOG", "VMW", "AAPL" };
    private final Random random = new Random(System.currentTimeMillis());

    public String nextPrice() {
        String ticker = TICKER_SYMBOLS[ random.nextInt( TICKER_SYMBOLS.length ) ];
        float price = random.nextFloat() * 7;
        return String.format( "%s,%2.2f", ticker, price );
    }
	
	public static void main(String[] args) throws Exception {
		String price = new PriceGenerator().nextPrice();
		System.out.println( price );
	}
	
}
