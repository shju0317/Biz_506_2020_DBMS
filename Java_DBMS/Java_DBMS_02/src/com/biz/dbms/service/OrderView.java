package com.biz.dbms.service;

import java.util.List;

import com.biz.dbms.config.Lines;
import com.biz.dbms.domain.OrderVO;

public class OrderView {
	public void orderList(List<OrderVO> orderList) { // 결합도 낮춰줌.
		System.out.println(Lines.dLine);
		System.out.println("주문내역서");
		System.out.println(Lines.sLine);
		System.out.println("SEQ\t주문번호\t주문일자\t고객\t상품\t수량\t합계");
		System.out.println(Lines.dLine);

		for (OrderVO vo : orderList) {
			System.out.printf("%5d\t", vo.getO_seq());
			System.out.print(vo.getO_num() + "\t\t");
			System.out.print(vo.getO_date() + "\t");
			System.out.print(vo.getO_cnum() + "\t");
			System.out.print(vo.getO_pcode() + "\t");
			System.out.print(vo.getO_qty() + "\t");
			System.out.print(vo.getO_price() + "\n");
		}

		System.out.println(Lines.dLine);
	} // end orderList
	
	public void orderDetailView(OrderVO orderVO) {
		System.out.println("==============================");
		System.out.printf("주문번호: %s\n", orderVO.getO_num());
		System.out.printf("고객번호: %s\n", orderVO.getO_cnum());
		System.out.printf("상품코드: %s\n", orderVO.getO_pcode());
		System.out.printf("가격: %d\n", orderVO.getO_price());
		System.out.printf("수량: %d\n", orderVO.getO_qty());
		System.out.println("==============================");
	}
}
