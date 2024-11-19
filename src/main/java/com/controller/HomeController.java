package com.controller;

import javax.validation.Valid;

import com.dao.UserDao;
import com.dao.UserDaoImpl;
import com.model.Customer;
import com.model.Product;
import com.service.ProductService;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
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
import java.util.regex.*;

@Controller
public class HomeController {

	@Autowired
	private ProductService productService;

	@Autowired
	private UserDao userDao;

	@Autowired
	private SessionFactory sessionFactory;

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
	public String getChangePassword() {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return "changePassword";
	}

	// to insert the data
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public String changePassword(Model model, @RequestParam("currentPassword") String currentPassword,
								 @RequestParam("newPassword") String newPassword,
								 @RequestParam("confirmPassword") String confirmPassword) {
		User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		com.model.User u = userDao.getUserByEmail(user.getUsername());
//		u.setPassword(newPassword);

		if(!u.getPassword().equals(currentPassword)) {
			model.addAttribute("errorMsg", "Mật khẩu hiện tại không chính xác");
			return "changePassword";
		}

		if(!newPassword.equals(confirmPassword)) {
			model.addAttribute("errorMsg", "Mật khẩu xác nhận không chính xác");
			return "changePassword";
		}

		if(newPassword == currentPassword) {
			model.addAttribute("errorMsg", "Mật khẩu mới giống mật khẩu hiện tại");
			return "changePassword";
		}

		if(newPassword.length() < 8 || ! validatePassword(newPassword) ){
			model.addAttribute("errorMsg", "Mật khẩu quá yếu");
			return "changePassword";
		}

		u.setPassword(newPassword);
		Session session = sessionFactory.openSession();
		session.update(u);
		session.flush();
		session.close();

		model.addAttribute("successMsg", "Đổi mật khẩu thành công");
		return "changePassword";
	}

	public static boolean validatePassword(String password) {
		String regex = "^(?=.*[A-Za-z])(?=.*\\d).+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(password);
		return matcher.matches();
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
