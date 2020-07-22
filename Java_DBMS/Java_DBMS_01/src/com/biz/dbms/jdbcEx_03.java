package com.biz.dbms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

import com.biz.dbms.config.DBConnection;
import com.biz.dbms.config.DBContract;
import com.biz.dbms.domain.OrderVO;

public class jdbcEx_03 {
	public static void main(String[] args) {
		Connection dbConn = DBConnection.getDBConnection();
		String insert_sql = DBContract.ORDER_INSERT;
		Scanner scan = new Scanner(System.in);
		
		OrderVO orderVO = new OrderVO();
		
		System.out.print("주문번호(6자리)>> ");
		String str_num = scan.nextLine();
		
		System.out.print("고객번호(5자리)>> ");
		String str_cnum = scan.nextLine();
		
		System.out.print("상품코드(5자리)>> ");
		String str_pcode = scan.nextLine();
		
		orderVO.setO_num(str_num);
		orderVO.setO_cnum(str_cnum);
		orderVO.setO_pcode(str_pcode);
		
		try {
			PreparedStatement pSt = dbConn.prepareStatement(insert_sql);
//			pSt.setNString(DBContract.ORDER.POS_O_NUM_STR, orderVO.getO_num());
//			pSt.setNString(DBContract.ORDER.POS_O_CNUM_STR, orderVO.getO_cnum());
//			pSt.setNString(DBContract.ORDER.POS_O_PCODE_STR, orderVO.getO_pcode());
//			pSt.setInt(DBContract.ORDER.POS_O_TOTAL_INT, 1000);
			
			pSt.setNString(1, orderVO.getO_num());
			pSt.setNString(2, orderVO.getO_cnum());
			pSt.setNString(3, orderVO.getO_pcode());
			pSt.setInt(4, 1000);
			
			int ret = pSt.executeUpdate();
			if(ret > 0) {
				System.out.println("데이터 추가 성공");
			}else {
				System.out.println("데이터 추가 실패");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
