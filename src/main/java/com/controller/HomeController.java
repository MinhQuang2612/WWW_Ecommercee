package com.controller;

import javax.validation.Valid;

import com.model.Product;
import com.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model.Queries;
import com.service.QueriesService;

import java.util.List;

@Controller
public class HomeController {

	@Autowired
	private ProductService productService;

	@RequestMapping({"/", "/index", "/index1" })
	public ModelAndView sayIndex() {
		List<Product> products = productService.getAllProducts(); return new
				ModelAndView("index1", "products", products);
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView searchProducts(@RequestParam(value = "searchTerm", required = false) String keyword) {
	    // Kiểm tra nếu searchTerm rỗng
	    if (keyword == null || keyword.trim().isEmpty()) {
	        // Nếu rỗng, trả về thông báo lỗi
	        ModelAndView mav = new ModelAndView("index1");
	        mav.addObject("errorMessage", "Vui lòng nhập từ khóa tìm kiếm.");
	        return mav;
	    }

	    // Xử lý tìm kiếm
	    List<Product> products = productService.searchProducts(keyword);

	    // Trả về trang index1 với kết quả tìm kiếm
	    ModelAndView mav = new ModelAndView("index1");
	    mav.addObject("products", products);
	    mav.addObject("searchKeyword", keyword);
	    return mav;
	}
	
	@RequestMapping(value = "/changePassword", method = RequestMethod.GET)
	public String changePassword() {
	    return "changePassword";
	}
	
	@RequestMapping("/hello")
	public ModelAndView sayHello() {
		return new ModelAndView("hello", "hello", "Hello Mr.Ismail");
	}

	@RequestMapping("/login")
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, Model model) {
		if (error != null)
			model.addAttribute("error", "Invalid username and Password");
		if (logout != null)
			model.addAttribute("logout", "You have logged out successfully");
		return "login";
	}

	@RequestMapping("/aboutus")
	public String sayAbout() {
		return "aboutUs";
	}

	@Autowired
	private QueriesService queryService;

	@RequestMapping(value = "/contactus")
	public ModelAndView getQuery() {
		Queries query = new Queries();
		return new ModelAndView("contactUs", "contact", query);
	}

	@RequestMapping(value = "/contactus", method = RequestMethod.POST)
	public String addQuery(@Valid @ModelAttribute(value = "contact") Queries query, Model model, BindingResult result) {

		if (result.hasErrors())
			return "contactUs";

		queryService.addQuery(query);
		model.addAttribute("querySuccess",
				"Thank you, Your Message stored in our Server we will contact through corresponding Mail");
		return "login";

	}
}
