package com.biz.dbms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

import com.biz.dbms.config.DBConnection;
import com.biz.dbms.config.DBContract;
import com.biz.dbms.domain.OrderVO;
import com.biz.dbms.service.OrderService;
import com.biz.dbms.service.OrderServiceImplV1;
import com.biz.dbms.service.OrderView;

public class jdbcEx_03 {
	public static void main(String[] args) {

		/*
		 * [ UPDATE 구현 ]
		 * 1. 전체(검색조건에 맞는) 데이터 리스트를 보여주고
		 * 2. 내용을 변경할 데이터의 seq값을 키보드에서 입력받고
		 * 3. 데이터를 1개 SELECT하고
		 * 4. 각 칼럼 데이터를 보여주고
		 * 5. 변경할 내용을 입력받는다
		 * 6. 완료가 되면 UPDATE method를 호출하여 변경을 실시
		 */
		Scanner scan = new Scanner(System.in);	
		
		OrderService oService = new OrderServiceImplV1();
		OrderView oView = new OrderView();
		
		try {
			oView.orderList(oService.selectAll());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.print("수정할 SEQ(QUIT:종료)>> ");
		String strSeq = scan.nextLine();
		
		if(strSeq.equals("QUIT")) {
			System.out.println("★ 종료 ★");
			return;
		}
		
		long longSeq = 0;
		try {
			longSeq = Long.valueOf(strSeq);
		} catch (NumberFormatException e) {
			System.out.println(">> SEQ는 숫자만 가능");
			return;
		}
		
		OrderVO orderVO = null;
		try {
			orderVO = oService.findBySeq(longSeq);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(orderVO == null) {
			System.out.println(">> SEQ에 해당하는 데이터가 없습니다");
			return;
		}
		
		// 여기까지 정상 진행이 되면
		// 입력한 SEQ에 해당하는 데이터가 orderVO에 담겨있을 것
		
		System.out.printf("변경할 주문번호[ %s ] (Enter: 변경안함)>> ", orderVO.getO_num());
		String str_num = scan.nextLine();
		
		// 변경할 주문번호를 입력했을 때는
		// 입력한 주문번호를 orderVO의 o_num에 세팅한다.
		// 그냥 Enter만 입력하면 통과되므로 원래 o_num에 있던 값은 유지된다.
		if(!str_num.isEmpty()) {
			orderVO.setO_num(str_num);	
		}
		
		System.out.printf("변경할 고객번호[ %s ] (Enter: 변경안함)>> ", orderVO.getO_cnum());
		String str_cnum = scan.nextLine();
		
		// 변경할 주문번호를 입력했을 때는
		// 입력한 주문번호를 orderVO의 o_num에 세팅한다.
		// 그냥 Enter만 입력하면 통과되므로 원래 o_num에 있던 값은 유지된다.
		if(!str_cnum.isEmpty()) {
			orderVO.setO_cnum(str_cnum);
		}
		
		System.out.printf("변경할 상품코드[ %s ] (Enter: 변경안함)>> ", orderVO.getO_pcode());
		String str_pcode = scan.nextLine();
		
		// 변경할 주문번호를 입력했을 때는
		// 입력한 주문번호를 orderVO의 o_num에 세팅한다.
		// 그냥 Enter만 입력하면 통과되므로 원래 o_num에 있던 값은 유지된다.
		if(!str_pcode.isEmpty()) {
			orderVO.setO_pcode(str_pcode);
		}
		
		while (true) {
			System.out.printf("변경할 가격[ %s ] (Enter: 변경안함)>> ", orderVO.getO_price());
			String str_price = scan.nextLine();

			// 변경할 주문번호를 입력했을 때는
			// 입력한 주문번호를 orderVO의 o_num에 세팅한다.
			// 그냥 Enter만 입력하면 통과되므로 원래 o_num에 있던 값은 유지된다.
			if (!str_price.isEmpty()) {
				int int_price = 0;
				try {
					int_price = Integer.valueOf(str_price);

				} catch (Exception e) {
					System.out.println(">> 가격은 숫자로만 입력하세요");
					continue;
				}
				orderVO.setO_price(int_price);
			}
			break;
		}
		
	
		while (true) {
			System.out.printf("변경할 수량[ %d ] (Enter: 변경안함)>> ", orderVO.getO_qty());
			String str_qty = scan.nextLine();

			// 변경할 주문번호를 입력했을 때는
			// 입력한 주문번호를 orderVO의 o_num에 세팅한다.
			// 그냥 Enter만 입력하면 통과되므로 원래 o_num에 있던 값은 유지된다.
			if (!str_qty.isEmpty()) {
				int int_qty = 0;
				try {
					int_qty = Integer.valueOf(str_qty);

				} catch (Exception e) {
					System.out.println(">> 수량은 숫자로만 입력하세요");
					continue;
				}
				orderVO.setO_qty(int_qty);
			}
			break;
		}
		
		try {
			int ret = oService.update(orderVO);
			
			if(ret > 0) {
				System.out.println(">> 데이터 변경 완료");
				orderVO = oService.findBySeq(orderVO.getO_seq());
				System.out.println("==============================");
				System.out.printf("주문번호: %s\n", orderVO.getO_num());
				System.out.printf("고객번호: %s\n", orderVO.getO_cnum());
				System.out.printf("상품코드: %s\n", orderVO.getO_pcode());
				System.out.printf("가격: %d\n", orderVO.getO_price());
				System.out.printf("수량: %d\n", orderVO.getO_qty());
				System.out.println("==============================");
			}else {
				System.out.println(">> 데이터 변경 실패");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(">> SQL 문제 발생");
			e.printStackTrace();
		}
	}
}