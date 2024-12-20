package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.CustomerOrderDao;
import com.model.Cart;
import com.model.CartItem;
import com.model.CustomerOrder;
import com.model.OrderItem;

@Service
public class CustomerOrderServiceImpl implements CustomerOrderService {

	@Autowired
	private CustomerOrderDao customerOrderDao;
	
	@Autowired
	private CartService cartService;
	
	public void addCustomerOrder(CustomerOrder customerOrder) {
		customerOrderDao.addCustomerOrder(customerOrder);
	}

	public double getCustomerOrderGrandTotal(Long cartId) {
		double grandTotal=0;
		Cart cart = cartService.getCartByCartId(cartId);
		List<CartItem> cartItems = cart.getCartItem();
		
		for(CartItem item: cartItems){
			grandTotal += item.getPrice();
		}
		return grandTotal;
	}
	
	@Transactional
	public List<CustomerOrder> getOrderHistoryByCustomerId(Long customerId) {
        return customerOrderDao.getOrderHistoryByCustomerId(customerId);
    }
	
	@Transactional
    public List<OrderItem> getOrderItemsByOrderId(Long orderId) {
        return customerOrderDao.getOrderItemsByOrderId(orderId);
    }
}
