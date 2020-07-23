package com.biz.dbms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

import com.biz.dbms.config.DBConnection;
import com.biz.dbms.config.DBContract;
import com.biz.dbms.domain.OrderVO;
import com.biz.dbms.service.OrderInput;
import com.biz.dbms.service.OrderService;
import com.biz.dbms.service.OrderServiceImplV1;
import com.biz.dbms.service.OrderView;

public class jdbcEx_04 {
	public static void main(String[] args) {

		OrderService oService = new OrderServiceImplV1();
		OrderInput oInput = new OrderInput();

		while (true) {
			// 수정사항 입력받고, 데이터 Update
			if (!oInput.orderUpdate()) {
				break;
			}
		}
		System.out.println("업무종료!");
	}
}
