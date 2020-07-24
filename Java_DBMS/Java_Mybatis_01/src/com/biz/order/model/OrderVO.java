package com.biz.order.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 * [ VO(DTO)클래스의 선언 ]
 * DBMS와 연동하는 프로젝트에서 VO클래스의 필드변수는
 * 연동하는 table의 칼럼이름과 같게 한다.
 * 변수패턴은 snake-case 
 */

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class OrderVO {
	private long o_seq; // oSea => QSEQ => Q_SEQ
	private String o_date;
	private String o_num;
	private String o_cnum;
	private String o_pcode;
	private String o_pname;
	
	private int o_price;
	private int o_qty;
	private int o_total;
}
