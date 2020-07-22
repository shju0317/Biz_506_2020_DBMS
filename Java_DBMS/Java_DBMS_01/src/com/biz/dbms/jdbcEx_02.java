package com.biz.dbms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.biz.dbms.config.DBConnection;
import com.biz.dbms.config.DBContract;
import com.biz.dbms.config.Lines;
import com.biz.dbms.domain.OrderVO;

public class jdbcEx_02 {
	public static void main(String[] args) {

		Connection dbConn = DBConnection.getDBConnection();
		String order_select = DBContract.ORDER_SELECT;
		List<OrderVO> orderList = new ArrayList<OrderVO>();
		// 인터페이스를 이용해서 객체 선언만
		PreparedStatement pSt = null;

		try {
			// dbConn 객체의 preparedStatement() method에게 SQL명령문 코드를 전달하면
			// PreparedStatement type의 객체를 생성하여 return
			pSt = dbConn.prepareStatement(order_select);
			ResultSet result = pSt.executeQuery();

			while (result.next()) {
				OrderVO orderVO = new OrderVO();

				String o_num = result.getNString(DBContract.ORDER.POS_O_NUM_STR);
				orderVO.setO_num(o_num);

				String o_date = result.getNString(DBContract.ORDER.POS_O_DATE_STR);
				orderVO.setO_date(o_date);

				String o_cnum = result.getNString(DBContract.ORDER.POS_O_CNUM_STR);
				orderVO.setO_cnum(o_cnum);

				String o_pcode = result.getNString(DBContract.ORDER.POS_O_PCODE_STR);
				orderVO.setO_pcode(o_pcode);

				String o_pname = result.getNString(DBContract.ORDER.POS_O_PNAME_STR);
				orderVO.setO_pname(o_pname);

				int o_qty = result.getInt(DBContract.ORDER.POS_O_QTY_INT);
				orderVO.setO_qty(o_qty);

				int o_price = result.getInt(DBContract.ORDER.POS_O_PRICE_INT);
				orderVO.setO_price(o_price);

				orderList.add(orderVO);
			}
			pSt.close();
			dbConn.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // try end

		System.out.println(Lines.dLine);
		System.out.println("주문내역서");
		System.out.println(Lines.sLine);
		System.out.println("주문번호\t주문일자\t고객\t상품\t수량\t합계");
		System.out.println(Lines.dLine);
		for (OrderVO vo : orderList) {
			System.out.print(vo.getO_num() + "\t\t");
			System.out.print(vo.getO_date() + "\t");
			System.out.print(vo.getO_cnum() + "\t");
			System.out.print(vo.getO_pcode() + "\t");
			System.out.print(vo.getO_qty() + "\t");
			System.out.print(vo.getO_price() + "\n");
		}
		System.out.println(Lines.dLine);
	}
}
