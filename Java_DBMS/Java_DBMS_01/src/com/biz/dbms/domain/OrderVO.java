package com.biz.dbms.domain;

public class OrderVO {
	
	/*
	 * DB와 연동하는 프로젝트에서는
	 * VO클래스의 필드변수들을 table의 칼럼이름과 동일하게 작성하고
	 * 일반적으로 snake case로 작성한다.
	 */
	private long o_seq;		//	number
	private String o_num;		//	char(6 byte)
	private String o_date;		//	char(10 byte)
	private String o_cnum;		//	char(5 byte)
	private String o_pcode;	//	char(6 byte)
	private String o_pname;	//	nvarchar2(125 char)
	private int o_price;	//	number
	private int o_qty;		//	number
	private int o_total;	//	number
	
	@Override
	public String toString() {
		return "OrderVO [o_seq=" + o_seq + ", o_num=" + o_num + ", o_date=" + o_date + ", o_cnum=" + o_cnum
				+ ", o_pcode=" + o_pcode + ", o_pname=" + o_pname + ", o_price=" + o_price + ", o_qty=" + o_qty
				+ ", o_total=" + o_total + "]";
	}
	
	public long getO_seq() {
		return o_seq;
	}
	public void setO_seq(long o_seq) {
		this.o_seq = o_seq;
	}
	public String getO_num() {
		return o_num;
	}
	public void setO_num(String o_num) {
		this.o_num = o_num;
	}
	public String getO_date() {
		return o_date;
	}
	public void setO_date(String o_date) {
		this.o_date = o_date;
	}
	public String getO_cnum() {
		return o_cnum;
	}
	public void setO_cnum(String o_cnum) {
		this.o_cnum = o_cnum;
	}
	public String getO_pcode() {
		return o_pcode;
	}
	public void setO_pcode(String o_pcode) {
		this.o_pcode = o_pcode;
	}
	public String getO_pname() {
		return o_pname;
	}
	public void setO_pname(String o_pname) {
		this.o_pname = o_pname;
	}
	public int getO_price() {
		return o_price;
	}
	public void setO_price(int o_price) {
		this.o_price = o_price;
	}
	public int getO_qty() {
		return o_qty;
	}
	public void setO_qty(int o_qty) {
		this.o_qty = o_qty;
	}
	public int getO_total() {
		return o_total;
	}
	public void setO_total(int o_total) {
		this.o_total = o_total;
	}
	
}
