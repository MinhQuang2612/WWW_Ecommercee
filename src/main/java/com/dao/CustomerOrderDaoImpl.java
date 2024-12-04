package com.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.model.CustomerOrder;
import com.model.OrderItem;

@Repository
@Transactional
public class CustomerOrderDaoImpl implements CustomerOrderDao {

	@Autowired
	private SessionFactory sessionFactory;

	public void addCustomerOrder(CustomerOrder customerOrder) {
		Session session = sessionFactory.openSession();
		session.saveOrUpdate(customerOrder);
		session.flush();
		session.close();
	}
	
	@Override
    public List<CustomerOrder> getOrderHistoryByCustomerId(Long customerId) {
        Session session = sessionFactory.openSession();
        
        Query query = session.createQuery("FROM CustomerOrder co WHERE co.customer.customerId = :customerId ORDER BY co.customerOrderId DESC");
        query.setParameter("customerId", customerId);
        
        // Return the list of customer orders
        return query.list();
    }
	
	@Override
	public List<OrderItem> getOrderItemsByOrderId(Long orderId) {
	    Session session = sessionFactory.openSession();
	    Query query = session.createQuery("FROM OrderItem oi WHERE oi.customerOrder.customerOrderId = :orderId");
	    query.setParameter("orderId", orderId);

	    List<OrderItem> orderItems = query.list();
	    session.close();
	    return orderItems;
	}

}
