package com.dao;

import java.io.IOException;

import com.model.Cart;

public interface CartDao {

	public Cart getCartByCartId(Long CartId);
	
	public Cart validate(Long cartId) throws IOException;
	
	public void update(Cart cart);
}
