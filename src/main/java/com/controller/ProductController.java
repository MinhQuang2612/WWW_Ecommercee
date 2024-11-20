
package com.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.model.Product;
import com.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	private ProductService productService;

	@Autowired
	private ServletContext context;

	// Getters and Setters

	public ProductService getProductService() {
		return productService;
	}

	public void setProductService(ProductService productService) {
		this.productService = productService;
	}
	
	@RequestMapping(value = "/searchProducts", method = RequestMethod.GET)
	public String searchProducts(@RequestParam(value = "searchKeyword", required = false) String keyword, Model model) {
	    List<Product> products;

	    try {
	        if (keyword == null || keyword.trim().isEmpty()) {
	            // Thêm thông báo yêu cầu nhập thông tin tìm kiếm
	            model.addAttribute("msg", "Vui lòng nhập thông tin tìm kiếm.");

	            // Nếu không có từ khóa, trả về toàn bộ sản phẩm
	            products = productService.getAllProducts();
	        } else {
	            // Tìm kiếm sản phẩm với từ khóa
	            products = productService.searchProducts(keyword);
	            if (products.isEmpty()) {
	                model.addAttribute("msg", "No products found for: " + keyword);
	            }
	        }
	        // Thêm danh sách sản phẩm vào model
	        model.addAttribute("products", products);
	        // Thêm từ khóa vào model để hiển thị lại trong ô tìm kiếm
	        model.addAttribute("searchKeyword", keyword);
	    } catch (Exception e) {
	        // Xử lý lỗi
	        model.addAttribute("errorMessage", "An error occurred while searching: " + e.getMessage());
	        // Hiển thị tất cả sản phẩm nếu có lỗi
	        products = productService.getAllProducts();
	        model.addAttribute("products", products);
	    }

	    return "productList";
	}


	@Bean
	public MultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setMaxUploadSize(10240000);
		return multipartResolver;
	}

	// Request Mapping

	// which displays the list of products to the productList page

	/* Product List using Angular
	* @RequestMapping("/getAllProducts")
	* public ModelAndView getAllProducts() {
	*	List<Product> products = productService.getAllProducts();
	*	return new ModelAndView("productListAngular", "products", products);
	*}
	*/
	//		Normal ProductList view 
	  @RequestMapping("/getAllProducts") 
	  public ModelAndView getAllProducts() {
		  List<Product> products = productService.getAllProducts(); return new
	  ModelAndView("productList", "products", products); }
	 
	
	// this is used for getting the product by productId

	@RequestMapping("getProductById/{productId}")
	public ModelAndView getProductById(@PathVariable(value = "productId") Long productId) {
		Product product = productService.getProductById(productId);
		return new ModelAndView("productPage", "productObj", product);
	}

	@RequestMapping("/admin/delete/{productId}")
	public String deleteProduct(@PathVariable(value = "productId") Long productId) {

		// Here the Path class is used to refer the path of the file

		String uploadDir = context.getRealPath("/WEB-INF/resource/images/products/");
		Path path = Paths.get(uploadDir + File.separator + productId + ".jpg");

		if (Files.exists(path)) {
			try {
				Files.delete(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		productService.deleteProduct(productId);
		// http://localhost:8080/shoppingCart/getAllProducts
		return "redirect:/getAllProducts";
	}

	@RequestMapping(value = "/admin/product/addProduct", method = RequestMethod.GET)
	public String getProductForm(Model model) {
		Product product = new Product();
		// New Arrivals
		// set the category as 1 for the Book book
		product.setProductCategory("Android");
		model.addAttribute("productFormObj", product);
		return "addProduct";

	}

	@RequestMapping(value = "/admin/product/addProduct", method = RequestMethod.POST)
	public String addProduct(@Valid @ModelAttribute(value = "productFormObj") Product product, BindingResult result) {
		// Binding Result is used if the form that has any error then it will
		// redirect to the same page without performing any functions
		if (result.hasErrors())
			return "addProduct";
		productService.addProduct(product);
		MultipartFile image = product.getProductImage();
		if (image != null && !image.isEmpty()) {
			String uploadDir = context.getRealPath("/WEB-INF/resource/images/products/");
			Path path = Paths.get(uploadDir + File.separator + product.getProductId() + ".png");

			try {
				image.transferTo(new File(path.toString()));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return "redirect:/getAllProducts";
	}

	@RequestMapping(value = "/admin/product/editProduct/{productId}")
	public ModelAndView getEditForm(@PathVariable(value = "productId") Long productId) {
		Product product = productService.getProductById(productId);
		return new ModelAndView("editProduct", "editProductObj", product);
	}

	@RequestMapping(value = "/admin/product/editProduct", method = RequestMethod.POST)
	public String editProduct(@ModelAttribute(value = "editProductObj") Product product) {
		productService.editProduct(product);
		return "redirect:/getAllProducts";
	}

	@RequestMapping("/getProductsList")
	public @ResponseBody List<Product> getProductsListInJson() {
		return productService.getAllProducts();
	}

	@RequestMapping("/productsListAngular")
	public String getProducts() {
		return "productListAngular";
	}

}
