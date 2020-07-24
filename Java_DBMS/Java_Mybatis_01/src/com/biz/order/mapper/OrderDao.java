package com.biz.order.mapper;

import java.util.List;

import com.biz.order.model.OrderVO;

public interface OrderDao {
	public List<OrderVO> selectAll();
	public OrderVO findBySeq(long seq);
	public List<OrderVO> findByPCode(String pcode);
	public List<OrderVO> findByPName(String pname);
	public List<OrderVO> findByDateDistance(String start_date, String end_date);
	
	public int insert(OrderVO orderVO);
	public int update(OrderVO orderVO);
	public int delete(long seq);
}
