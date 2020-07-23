package com.biz.dbms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.biz.dbms.config.DBConnection;
import com.biz.dbms.config.DBContract;
import com.biz.dbms.config.Lines;
import com.biz.dbms.domain.OrderVO;
import com.biz.dbms.service.OrderService;
import com.biz.dbms.service.OrderServiceImplV1;
import com.biz.dbms.service.OrderView;

public class jdbcEx_02 {
	public static void main(String[] args) {

		OrderService oService = new OrderServiceImplV1();
		OrderView oView = new OrderView();
		
		List<OrderVO> orderList = null;
		
		try {
			orderList = oService.selectAll();
			
			if(orderList == null || orderList.size() < 1) {
				System.out.println("데이터가 없습니다");
			}else {
				oView.orderList(orderList);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
