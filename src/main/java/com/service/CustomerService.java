package com.service;

import java.util.List;

import com.model.Customer;

public interface CustomerService {

	public void addCustomer(Customer customer);

	public List<Customer> getAllCustomers();

	public Customer getCustomerByemailId(String emailId);

	public List<Customer> searchCustomers(String searchTerm);
	
	public Customer getCustomerByUserId(Long userId);

}
