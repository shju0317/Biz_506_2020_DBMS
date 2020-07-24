package com.biz.order.config;

public class Lines {
	public static String dLine = "=";
	public static String sLine = "-";
	
	static {
		String line = String.format("%0100d",0);
		dLine = line.replace("0", "=");
		sLine = line.replace("0", "-");
	}
	
	public static String getDLine(int length) {
		return String.format("%0"+length+"d", 0).replace("0", "=");
	}
	
	public static String getSLine(int length) {
		return String.format("%0"+length+"d", 0).replace("0", "-");
	}
}
