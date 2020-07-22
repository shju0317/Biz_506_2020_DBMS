package com.biz.dbms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

import com.biz.dbms.config.DBConnection;
import com.biz.dbms.config.DBContract;

public class jdbcEx_04 {
	public static void main(String[] args) {
		Connection dbConn = DBConnection.getDBConnection();
		String delete_sql = DBContract.ORDER_DELETE;
		Scanner scan = new Scanner(System.in);
		
		System.out.print("삭제할 SEQ ??>>");
		String str_seq = scan.nextLine();
		
		long long_seq = Long.valueOf(str_seq);
		
		try {
			PreparedStatement pSt = dbConn.prepareStatement(delete_sql);
			pSt.setLong(1, long_seq);
			
			int ret = pSt.executeUpdate();
			if(ret > 0) {
				System.out.println("삭제 완료");
			}else {
				System.out.println("삭제 실패");
			}
			
			pSt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
