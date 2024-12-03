package com.dao;

import java.util.List;

import com.model.CustomerOrder;
import com.model.OrderItem;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.model.Cart;
import com.model.CartItem;

@Repository
@Transactional
public class CartItemDaoImpl implements CartItemDao {

	@Autowired
	private SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public void addCartItem(CartItem cartItem) {
		Session session = sessionFactory.openSession();
		session.saveOrUpdate(cartItem);
		session.flush();
		session.close();
	}

	public void removeCartItem(Long CartItemId) {
		Session session = sessionFactory.openSession();
		CartItem cartItem = (CartItem) session.get(CartItem.class, CartItemId);
		session.delete(cartItem);
		Cart cart = cartItem.getCart();
		List<CartItem> cartItems = cart.getCartItem();
		cartItems.remove(cartItem);
		session.flush();
		session.close();
	}

	public void removeAllCartItems(Cart cart) {
		List<CartItem> cartItems = cart.getCartItem();
		for (CartItem cartItem : cartItems) {
			removeCartItem(cartItem.getCartItemId());
		}
	}

	public void removeAllCartItemsOrder(CustomerOrder order) {
		Cart cart = order.getCart();
		List<CartItem> cartItems = cart.getCartItem();
		OrderItem orderItem = new OrderItem();
		for (CartItem cartItem : cartItems) {
			removeCartItem(cartItem.getCartItemId());
			orderItem.setCustomerOrderId(order.getCustomerOrderId());
			orderItem.setPrice(cartItem.getPrice());
			orderItem.setQuality(cartItem.getQuality());
			orderItem.setProduct(cartItem.getProduct());
			addOrderItem(orderItem);
		}

		order.setStatus(1);
		saveOrder(order);
	}

	public void addOrderItem(OrderItem orderItem) {
		Session session = sessionFactory.openSession();
		session.save(orderItem);
		session.flush();
		session.close();
	}

	public void saveOrder(CustomerOrder order) {
		Session session = sessionFactory.openSession();
		session.update(order);
		session.flush();
		session.close();
	}
}
