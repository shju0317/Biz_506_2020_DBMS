package com.biz.order.controller;

import com.biz.order.model.OrderVO;

/*
 * [ Call-by-value & Call-by-reference ]
 *  : java와 c의 가장 큰 차이
 * 
 * java는 둘 중 무엇? 애매..둘 다 사용
 * 그렇기 때문에 method에서 return해주는 것이 가장 좋은 사용법(결합도 good)!
 */

public class ParamEx_01 {
	public static void main(String[] args) {
		ParamTest pTest = new ParamTest();
		
		/* 
		 * primitive형 변수는 다른 method에 매개변수로 전달했을 때
		 * 전달받은 method에서 값을 변경해도 매개변수로 보낸 곳에서
		 * 우너래 있던 값은 절대 변함이 없다.
		 * 
		 * Class형 변수는 다른 method에 매개변수로 전달했을 때
		 * 전달받은 method에서 객체의 일부요소(필드변수)를 변경하면
		 * 보낸 곳의 원본 데이터가 변한다.
		 * 
		 * 배열을 다른 method에 매개변수로 전달했을 때
		 * 전달받은 method에서 배열의 일부 요소 값을 변경하면
		 * 보낸 곳의 원본 배열도 데이터가 변한다.
		 */
		
		// [1]
		int intNum1 = 3;
		int intNum2 = 4;
		
		// 값을 매개변수로 전달
		System.out.printf("intNum1: %d, intNum2: %d\n", intNum1, intNum2);
		pTest.add(intNum1, intNum2);
		System.out.printf("intNum1: %d, intNum2: %d\n", intNum1, intNum2);
		
		
		// [2]
		OrderVO orderVO = new OrderVO();
		
		// 주소를 매개변수로 전달
		System.out.println(orderVO.getO_pcode());
		pTest.add(orderVO);
		System.out.println(orderVO.getO_pcode());
		
		
		// [3]
		int[] intA = new int[3];
		
		// 주소를 매개변수로 전달
		System.out.println(intA[0]);
		pTest.add(intA);
		System.out.println(intA[0]);
		
		System.out.println("===============================================");
		/*
		 * 객체나 배열을 매개변수로 전달했을 때
		 * 전달받은 method에서 새로(New) 객체나 배열을 생성하게 되면
		 * 원본 객체나 배열과는 전혀 다른 대상이 된다.
		 * 따라서 아무리 전달 받은 method에서 값을 변경해도
		 * 원본은 값을 알 수 없다.
		 */
		
		
		// [4]
		System.out.println(orderVO.getO_pcode());
		pTest.non(orderVO);
		System.out.println(orderVO.getO_pcode());
		
		// [5]
		System.out.println(intA[0]);
		pTest.add(intA);
		System.out.println(intA[0]);
		
		System.out.println("===============================================");
		/*
		 * wrapper(String, Integer, Long, Float, Boolean, Character)들은
		 * primitive변수와 성질이 닮았다.
		 */
		
		// [6]
		String str = "lol";
		System.out.println(str);
		pTest.add(str);
		System.out.println(str);
		
		// [7]
		Integer i = 999;
		System.out.println(i);
		pTest.add(i);
		System.out.println(i);
	}
}
