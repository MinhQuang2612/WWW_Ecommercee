package com.service;

import java.util.List;

import com.model.CustomerOrder;
import com.model.OrderItem;

public interface CustomerOrderService {

	public void addCustomerOrder(CustomerOrder customerOrder);
	public double getCustomerOrderGrandTotal(Long cartId);
	public List<CustomerOrder> getOrderHistoryByCustomerId(Long customerId);
	public List<OrderItem> getOrderItemsByOrderId(Long orderId);
}
