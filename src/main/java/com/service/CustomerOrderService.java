package com.service;

import com.model.CustomerOrder;

public interface CustomerOrderService {

	public void addCustomerOrder(CustomerOrder customerOrder);
	public double getCustomerOrderGrandTotal(Long cartId);
}
