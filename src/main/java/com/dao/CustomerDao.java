package com.dao;

import java.util.List;

import com.model.Customer;

public interface CustomerDao {

	public void addCustomer(Customer customer);

	public List<Customer> getAllCustomers();

	public Customer getCustomerByemailId(String emailId);

}
