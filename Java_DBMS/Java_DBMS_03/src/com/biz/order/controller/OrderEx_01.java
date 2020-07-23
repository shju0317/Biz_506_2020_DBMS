package com.biz.order.controller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.biz.order.config.DBConnect;
import com.biz.order.dao.OrderDao;
import com.biz.order.model.OrderVO;

public class OrderEx_01 {
	public static void main(String[] args) {
		SqlSession sqlSession = DBConnect.getSqlSessionFactory().openSession(true);

		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);

		List<OrderVO> orderList = orderDao.selectAll();

		System.out.println("====================================================");
		System.out.println("주문리스트");
		System.out.println("====================================================");

		for (OrderVO vo : orderList) {
			System.out.print(vo.getO_num() + "\t");
			System.out.print(vo.getO_cnum() + "\t");
			System.out.print(vo.getO_pcode() + "\t");
			System.out.print(vo.getO_price() + "\t");
			System.out.print(vo.getO_qty() + "\t");
			System.out.print(vo.getO_price() * vo.getO_qty() + "\n");
		}
		System.out.println("====================================================");
	}
}
