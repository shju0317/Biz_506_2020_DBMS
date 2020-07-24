package com.biz.order.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import com.biz.order.config.Lines;
import com.biz.order.model.OrderVO;

public class OrderInput {

	Scanner scan;
	private OrderService oService;

	public OrderInput() {
		scan = new Scanner(System.in);
		oService = new OrderServiceImplV1();
	}

	public boolean orderInsert() {
		OrderVO orderVO = new OrderVO();
		
		// orderVO에는 새로 생성된 아무런 값도 없는 상태
		boolean ret = this.orderInput(orderVO);
		// orderVO에는 입력한 주문서 정보가 담긴 상태
		
		if (ret) {
			if (oService.insert(orderVO) > 0) {
				System.out.println("주문서를 등록(추가)하였습니다.");
			} else {
				System.out.println("주문서를 등록하지 못하였습니다.");
			}
		}
		return ret;
	}

	public boolean orderUpdate() {

		System.out.println("==============================");
		System.out.println("주문서 수정");
		System.out.println("==============================");
		System.out.println("주문서 수정 요령");
		System.out.println("Prompt에 나타난 값을 확인하고");
		System.out.println("새로 입력하면 값 수정");
		System.out.println("그냥 Enter를 누르면 통과");
		System.out.println("==============================");

		System.out.printf("수정할 SEQ[ %s ] (Enter: 변경안함, QUIT: 종료)>> ");
		String strSeq = scan.nextLine();

		if (strSeq.equals("QUIT")) {
			return false;
		}

		long longSeq = 0;
		try {
			longSeq = Long.valueOf(strSeq);
		} catch (NumberFormatException e) {
			System.out.println(">> SEQ는 숫자만 가능");
			return true;
		}

		OrderVO orderVO = oService.findBySeq(longSeq);

		if (orderVO == null) {
			System.out.println(">> SEQ에 해당하는 데이터가 없습니다");
			return true;
		}

		// orderVO에는 DB에서 가져온 1개의 주문서가 담겨있다.
		boolean ret = this.orderInput(orderVO);
		// orderVO에는 orderInput에서 변경한 주문서가 담겨있다.
		
		if(ret) {
			if(oService.update(orderVO) > 0) {
				System.out.println("주문서 수정 완료");
			}else {
				System.out.println("주문서 수정 실패");
			}
		}
		
		return ret;
	}

	public boolean orderInput(OrderVO orderVO) {

		// 만약 orderUpdate() method에서 orderInput()을 호출했으면
		// orderVO의 각 필드변수들은 값을 가지고 있을 것이고
		// orderInsert() method에서 호출했으면
		// orderVO의 각 필드변수값은 초기값 ""(String) 이거나 0(int, long)

		System.out.printf("주문번호(%s, QUIT:중단)>> ", orderVO.getO_num() == null ? "새로추가" : orderVO.getO_num());
		String strNum = scan.nextLine();

		if (strNum.equals("QUIT")) {
			return false;
		}
		/*
		 * 만약 insert 상태일경우 사용자가 주문번호를 입력하지 않으면 setO_num() method를 통과하고 아래쪽 isEmpty()의
		 * 유효성 검사에서 통과하지 못할 것이다.
		 * 
		 * update 상태일경우 입력받은 strNum는 isEmpty일 것이고 당연히 setO_num() method는 통과 해 버릴 것이다.
		 * 하지만 이미 DB에서 읽어온 값이 담겨 있으므로 아래쪽 orderVO.getO_num().isEmpty()는 그냥 통과 될것이다.
		 */

		if (!strNum.isEmpty()) {
			orderVO.setO_num(strNum);
		}

		if (orderVO.getO_num().isEmpty()) {
			System.out.println("주문번호는 반드시 입력해야 합니다.");
			return true;
		}

		while (true) {
			System.out.printf("고객번호(%s, QUIT:중단)>> ", orderVO.getO_cnum() == null ? "NEW" : orderVO.getO_cnum());
			String strCNum = scan.nextLine();

			if (strCNum.equals("QUIT")) {
				return false;
			}

			if (orderVO.getO_num().isEmpty()) {
				orderVO.setO_cnum(strCNum);

			}
			if (orderVO.getO_cnum().isEmpty()) {
				System.out.println("고객번호는 반드시 입력해야 합니다.");
				continue;
			}
			break;
		}

		while (true) {
			System.out.printf("상품코드(%s, QUIT:중단)>> ", orderVO.getO_pcode() == null ? "NEW" : orderVO.getO_pcode());
			String strPCode = scan.nextLine();

			if (strPCode.equals("QUIT")) {
				return false;
			}

			if (orderVO.getO_pcode().isEmpty()) {
				orderVO.setO_pcode(strPCode);
			}

			if (orderVO.getO_pcode().isEmpty()) {
				System.out.println("상품코드는 반드시 입력해야 합니다.");
				continue;
			}
			break;
		}

		while (true) {
			System.out.printf("상품가격(%d, QUIT:중단)>> ", orderVO.getO_price());
			String strPrice = scan.nextLine();

			if (strPrice.equals("QUIT")) {
				return false;
			}

			int intPrice = 0;
			try {
				intPrice = Integer.valueOf(strPrice);
			} catch (Exception e) {
				System.out.println("상품가격은 숫자로만 입력하세요");
			}

			if (intPrice > 0) {
				orderVO.setO_price(intPrice);
			}

			if (orderVO.getO_price() < 1) {
				System.out.println("상품가격은 0이하가 될 수 없습니다.");
				continue;
			}
			break;
		}

		while (true) {
			System.out.printf("주문수량(%d, QUIT:중단)>> ", orderVO.getO_qty());
			String strQty = scan.nextLine();

			if (strQty.equals("QUIT")) {
				return false;
			}

			int intQty = 0;
			try {
				intQty = Integer.valueOf(strQty);
			} catch (Exception e) {
				System.out.println("주문수량은 숫자로만 입력하세요");
			}
			if (intQty > 0) {
				orderVO.setO_qty(intQty);
			}
			if (orderVO.getO_qty() < 1) {
				System.out.println("주문수량은 0이상이어야 합니다.");
				continue;
			}
			break;
		}

//		int ret = 0;
//		String msg = "추가";
//		if (orderVO.getO_seq() > 0) {
//			ret = oService.update(orderVO);
//			msg = "수정";
//		} else {
//			ret = oService.insert(orderVO);
//		}
//
//		if (ret > 0) {
//			System.out.printf("주문서를 %s하였습니다.\n", msg);
//		} else {
//			System.out.printf("주문서를 %s하지 못했습니다.\n", msg);
//			System.out.println("다시 입력해주세요");
//		}

		return true;
	}

}
