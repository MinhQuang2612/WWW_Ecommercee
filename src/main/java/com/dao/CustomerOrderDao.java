package com.dao;

import java.util.List;

import com.model.CustomerOrder;
import com.model.OrderItem;

public interface CustomerOrderDao {

	public void addCustomerOrder(CustomerOrder customerOrder);

	

	public List<CustomerOrder> getOrderHistoryByCustomerId(Long customerId);



	public List<OrderItem> getOrderItemsByOrderId(Long orderId);
}
