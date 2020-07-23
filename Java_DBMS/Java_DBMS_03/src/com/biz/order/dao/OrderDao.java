package com.biz.order.dao;

import java.util.List;

import com.biz.order.model.OrderVO;

public interface OrderDao {
	public List<OrderVO> selectAll();
}
