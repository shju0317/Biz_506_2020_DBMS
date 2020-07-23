package com.biz.dbms.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class OrderVO {
	
	/*
	 * DB와 연동하는 프로젝트에서는
	 * VO클래스의 필드변수들을 table의 칼럼이름과 동일하게 작성하고
	 * 일반적으로 snake case로 작성한다.
	 */
	private long o_seq;			//	number
	private String o_num;		//	char(6 byte)
	private String o_date;		//	char(10 byte)
	private String o_cnum;		//	char(5 byte)
	private String o_pcode;		//	char(6 byte)
	private String o_pname;		//	nvarchar2(125 char)
	private int o_price;		//	number
	private int o_qty;			//	number
	private int o_total;		//	number
	
}
