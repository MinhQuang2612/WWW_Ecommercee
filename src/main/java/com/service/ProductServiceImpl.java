package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.ProductDao;
import com.model.Product;

@Service(value="productService")
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao productDao;

	public ProductDao getProductDao() {
		return productDao;
	}

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	@Transactional
	public List<Product> getAllProducts() {
		return productDao.getAllProducts();
	}
	
//	 @Override
//	 @Transactional
//	 public List<Product> getFeaturedProducts(int limit) {
//		 return productDao.getFeaturedProducts(limit);
//	 }
	 
	 @Transactional
	 public List<Product> searchProducts(String keyword) {
	     if (keyword == null || keyword.trim().isEmpty()) {
	         throw new IllegalArgumentException("Vui lòng nhập từ khóa tìm kiếm.");
	     }
	     return productDao.searchProducts(keyword);
	 }
	
	public Product getProductById(Long productId) {
		return productDao.getProductById(productId);
	}

	
	public void deleteProduct(Long productId) {
		productDao.deleteProduct(productId);
	}
	
	public void addProduct(Product product){
		productDao.addProduct(product);
	}
	
	public void editProduct(Product product){
		productDao.editProduct(product);
	}

}
