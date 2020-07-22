package com.biz.dbms.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static Connection dbConn = null;
	
	static {
		try {
			Class.forName(DBContract.DB_DRIVER);
			dbConn = DriverManager.getConnection(
							DBContract.DB_URL, 
							DBContract.DB_USER, 
							DBContract.DB_PASSWORD);
			
			System.out.println("DB Connection OK :)");
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} // end static
	
	public static Connection getDBConnection() {
		return dbConn;
	}
}
