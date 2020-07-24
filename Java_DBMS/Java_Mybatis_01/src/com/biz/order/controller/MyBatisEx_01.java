package com.biz.order.controller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.biz.order.config.DBConnection;
import com.biz.order.mapper.OrderDao;
import com.biz.order.model.OrderVO;

public class MyBatisEx_01 {
	public static void main(String[] args) {
		
		// session = 통로, 배관
		SqlSession sqlSession = DBConnection.getSqlSessionFactory().openSession(true);
		
		// OrderDao interface와 mapper.xml 파일을 참조하여 생성한
		// OrderDaoImpl(가칭) 클래스를 만들고
		// 그 클래스로 객체를 생성하여 나에게 달라(getMapper)
		// 그리고 그 객체를 orderDao에 담아서 쓸 수 있게 해달라.
		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);
		
		List<OrderVO> orderList = orderDao.selectAll();
		
		for(OrderVO vo : orderList) {
			System.out.println(vo);
		}
	}
}
