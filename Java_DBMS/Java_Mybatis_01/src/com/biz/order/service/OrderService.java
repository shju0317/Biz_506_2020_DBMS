package com.biz.order.service;

import java.util.List;

import com.biz.order.model.OrderVO;

public interface OrderService {
	public List<OrderVO> selectAll();
	public OrderVO findBySeq(long seq);
	public int insert(OrderVO orderVO);
	public int update(OrderVO orderVO);
	public int delete(long seq);
}
