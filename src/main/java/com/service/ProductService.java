package com.service;

import java.util.List;

import com.model.Product;

public interface ProductService {

	public List<Product> getAllProducts();

	public Product getProductById(Long productId);

	public void deleteProduct(Long productId);
	
	public void addProduct(Product product);
	
	public void editProduct(Product product);

	//public List<Product> getFeaturedProducts(int limit);

	public List<Product> searchProducts(String keyword);
}
