package com.biz.order.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

import com.biz.order.config.Lines;
import com.biz.order.service.OrderInput;

public class OrderInputEx_01 {
	public static void main(String[] args) {
		OrderInput oInput = new OrderInput();
		Scanner scan = new Scanner(System.in);

		while (true) {
			System.out.println(Lines.getDLine(50));
			System.out.println("\t아마전 쇼핑몰 주문서 관리 시스템 V1");
			System.out.println(Lines.getSLine(50));
			System.out.println("1. 주문서 리스트 보기");
			System.out.println("2. 주문서 자세히 보기");
			System.out.println("3. 주문서 입력");
			System.out.println("4. 주문서 수정");
			System.out.println("5. 주문서 삭제");
			System.out.println("Q. 업무종료");
			System.out.println(Lines.getDLine(50));
			System.out.print("업무선택>> ");
			String strMenu = scan.nextLine();

			if (strMenu.equals("Q")) {
				break;
			}

			int intMenu = 0;
			try {
				intMenu = Integer.valueOf(strMenu);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("업무선택은 숫자 1~5까지 중에 선택하세요");
				continue;
			}

//			List<OrderVO> orderList;
			if (intMenu == 1) { // 주문서 리스트 보기
//					orderList = oService.selectAll();
//					oView.orderList(orderList);
			} else if (intMenu == 2) { // 주문서 자세히 보기
				// 전체리스트를 보여주고
//					orderList = oService.selectAll();
//					oView.orderList(orderList);
//					
//					OrderVO orderVO = oInput.detailView();
//					oView.orderDetailView(orderVO);
//					
				// SEQ 입력받고
				// detailView
			} else if (intMenu == 3) { // 주문서 입력
				if (!oInput.orderInsert()) {
					break;
				}

				// 입력이 완료된 후 잘 입력되었는지 리스트로 확인시켜주기
//					orderList = oService.selectAll();
//					oView.orderList(orderList);
//					
			} else if (intMenu == 4) { // 주문서 수정
//					orderList = oService.selectAll();
//					oView.orderList(orderList);
//					
				if (!oInput.orderUpdate()) {
					break;
				}
			} else if (intMenu == 5) { // 주문서 삭제
				// 삭제를 위한 리스트 보여주기
				// 삭제가 완료된 후 잘 삭제되었는지 리스트로 확인시켜주기
//					orderList = oService.selectAll();
//					oView.orderList(orderList);
//					
//					if(!oInput.orderDelete()) {
//						break;
//					}
//					
				// 삭제 후 리스트 보여주기
//					orderList = oService.selectAll();
//					oView.orderList(orderList);
//					
			} else {
				System.out.println("1~5 중에서 선택하세요");
			}

		}
		System.out.println("\n업무종료 6v6");
	}

}
