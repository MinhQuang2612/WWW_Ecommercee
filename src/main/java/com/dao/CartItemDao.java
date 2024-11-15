package com.dao;

import com.model.Cart;
import com.model.CartItem;

public interface CartItemDao {

	public void addCartItem(CartItem cartItem);
	public void removeCartItem(Long CartItemId);
	public void removeAllCartItems(Cart cart);

}
