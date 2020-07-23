package com.biz.dbms.service;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

import com.biz.dbms.domain.OrderVO;

public class OrderInput {
	protected Scanner scan;
	protected OrderService oService;
	protected OrderView oView;

	public OrderInput() {
		this.scan = new Scanner(System.in);
		oService = new OrderServiceImplV1();
		oView = new OrderView();
	}

	public boolean orderInsert() {
		OrderVO orderVO = new OrderVO();

		System.out.printf("주문번호(QUIT: 종료)>> ");
		String str_num = scan.nextLine();

		if (str_num.equals("QUIT")) {
			return false;
		}

		orderVO.setO_num(str_num);

		System.out.printf("고객번호(QUIT: 종료)>> ");
		String str_cnum = scan.nextLine();

		if (str_cnum.equals("QUIT")) {
			return false;
		}

		orderVO.setO_cnum(str_cnum);

		System.out.printf("상품코드(QUIT: 종료)>> ");
		String str_pcode = scan.nextLine();

		if (str_pcode.equals("QUIT")) {
			return false;
		}

		orderVO.setO_pcode(str_pcode);

		while (true) {
			System.out.printf("가격(QUIT: 종료)>> ");
			String str_price = scan.nextLine();

			if (str_price.equals("QUIT")) {
				return false;
			}

			int int_price = 0;
			try {
				int_price = Integer.valueOf(str_price);

			} catch (Exception e) {
				System.out.println(">> 가격은 숫자로만 입력하세요");
				continue;
			}
			orderVO.setO_price(int_price);

			break;
		}

		while (true) {
			System.out.printf("수량(QUIT: 종료)>> ");
			String str_qty = scan.nextLine();

			if (str_qty.equals("QUIT")) {
				return false;
			}

			int int_qty = 0;
			try {
				int_qty = Integer.valueOf(str_qty);

			} catch (Exception e) {
				System.out.println(">> 수량은 숫자로만 입력하세요");
				continue;
			}
			orderVO.setO_qty(int_qty);

			break;
		}

		// [ 컴퓨터의 현재 날짜와 시각을 문자열로 가져오기 ]
		// JDK 1.7 이하에서는 Date() 매개변수가 필요없다.
		// JDK 1.8 최신 버전에서는 Date(System.current...())
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat curDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat curTime = new SimpleDateFormat("HH:mm:SS");
		orderVO.setO_date(curDate.format(date));

		try {
			int ret = oService.insert(orderVO);

			if (ret > 0) {
				System.out.println(">> 데이터 추가 완료");
			} else {
				System.out.println(">> 데이터 추가 실패");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(">> SQL 문제 발생");
			e.printStackTrace();
		}

		return true;
	}

	public boolean orderUpdate() {
		try {
			oView.orderList(oService.selectAll());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.print("수정할 SEQ(QUIT:종료)>> ");
		String strSeq = scan.nextLine();

		if (strSeq.equals("QUIT")) {
			System.out.println("★ 종료 ★");
			return false;
		}

		long longSeq = 0;
		try {
			longSeq = Long.valueOf(strSeq);
		} catch (NumberFormatException e) {
			System.out.println(">> SEQ는 숫자만 가능");
			return true;
		}

		OrderVO orderVO = null;
		try {
			orderVO = oService.findBySeq(longSeq);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (orderVO == null) {
			System.out.println(">> SEQ에 해당하는 데이터가 없습니다");
			return true;
		}

		// 여기까지 정상 진행이 되면
		// 입력한 SEQ에 해당하는 데이터가 orderVO에 담겨있을 것

		System.out.printf("변경할 주문번호[ %s ] (Enter: 변경안함, QUIT: 종료)>> ", orderVO.getO_num());
		String str_num = scan.nextLine();

		if (str_num.equals("QUIT")) {
			return false;
		}

		// 변경할 주문번호를 입력했을 때는
		// 입력한 주문번호를 orderVO의 o_num에 세팅한다.
		// 그냥 Enter만 입력하면 통과되므로 원래 o_num에 있던 값은 유지된다.
		if (!str_num.isEmpty()) {
			orderVO.setO_num(str_num);
		}

		System.out.printf("변경할 고객번호[ %s ] (Enter: 변경안함, QUIT: 종료)>> ", orderVO.getO_cnum());
		String str_cnum = scan.nextLine();

		if (str_cnum.equals("QUIT")) {
			return false;
		}

		if (!str_cnum.isEmpty()) {
			orderVO.setO_cnum(str_cnum);
		}

		System.out.printf("변경할 상품코드[ %s ] (Enter: 변경안함, QUIT: 종료)>> ", orderVO.getO_pcode());
		String str_pcode = scan.nextLine();

		if (str_pcode.equals("QUIT")) {
			return false;
		}

		if (!str_pcode.isEmpty()) {
			orderVO.setO_pcode(str_pcode);
		}

		while (true) {
			System.out.printf("변경할 가격[ %s ] (Enter: 변경안함, QUIT: 종료)>> ", orderVO.getO_price());
			String str_price = scan.nextLine();

			if (str_price.equals("QUIT")) {
				return false;
			}

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
			System.out.printf("변경할 수량[ %d ] (Enter: 변경안함, QUIT: 종료)>> ", orderVO.getO_qty());
			String str_qty = scan.nextLine();

			if (str_qty.equals("QUIT")) {
				return false;
			}

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

			if (ret > 0) {
				System.out.println(">> 데이터 변경 완료");
				orderVO = oService.findBySeq(orderVO.getO_seq());
				System.out.println("==============================");
				System.out.printf("주문번호: %s", orderVO.getO_num());
				System.out.printf("고객번호: %s", orderVO.getO_cnum());
				System.out.printf("상품코드: %s", orderVO.getO_pcode());
				System.out.printf("가격: %s", orderVO.getO_price());
				System.out.printf("수량: %s\n", orderVO.getO_qty());
				System.out.println("==============================");
			} else {
				System.out.println(">> 데이터 변경 실패");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(">> SQL 문제 발생");
			e.printStackTrace();
		}

		return true;
	}

	public OrderVO detailView() {
		System.out.print("자세히 확인할 SEQ 입력>> ");
		String strSeq = scan.nextLine();

		long longSeq = 0;
		try {
			longSeq = Integer.valueOf(strSeq);
		} catch (Exception e) {
			System.out.println("SEQ는 숫자만 가능");
		}

		try {
			OrderVO orderVO = oService.findBySeq(longSeq);
			return orderVO;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public boolean orderDelete() {
		System.out.print("삭제할 SEQ(QUIT:종료)>> ");
		String strSeq = scan.nextLine();

		if (strSeq.equals("QUIT")) {
			return false;
		}

		long longSeq = 0;
		try {
			longSeq = Long.valueOf(strSeq);
		} catch (Exception e) {
			System.out.println("SEQ는 숫자만 가능");
			return true;
		}
		try {
			OrderVO orderVO = oService.findBySeq(longSeq);
			if (orderVO == null) {
				System.out.println("삭제할 데이터가 없습니다");
				return true;
			} else {
				System.out.printf("주문번호:%s\n 고객번호:%s\n 상품코드:%s\n 의 주문을 삭제할까요?", 
						orderVO.getO_num(), orderVO.getO_cnum(), orderVO.getO_pcode());

				String yesNo = scan.nextLine();
				if (yesNo.equals("YES")) {
					int ret = oService.delete(longSeq);
					if (ret > 0) {
						System.out.println("삭제완료");
					} else {
						System.out.println("삭제실패");
					}
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}
}
