package com.dao;

import java.util.List;

import com.model.CustomerOrder;

public interface CustomerOrderDao {

	public void addCustomerOrder(CustomerOrder customerOrder);

	

	public List<CustomerOrder> getOrderHistoryByCustomerId(Long customerId);
}
