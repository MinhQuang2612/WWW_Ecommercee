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
	    ModelAndView mav = new ModelAndView("index1");

	    // Kiểm tra nếu searchTerm rỗng
	    if (keyword == null || keyword.trim().isEmpty()) {
	        // Trả về danh sách đầy đủ sản phẩm
	        List<Product> allProducts = productService.getAllProducts();
	        mav.addObject("products", allProducts);
	        mav.addObject("errorMessage", "Vui lòng nhập từ khóa tìm kiếm."); // Thêm thông báo lỗi
	    } else {
	        // Xử lý tìm kiếm với từ khóa
	        List<Product> products = productService.searchProducts(keyword);
	        mav.addObject("products", products);
	        mav.addObject("searchKeyword", keyword);
	    }

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

        // Nếu form có lỗi xác thực, trả lại trang liên hệ và giữ nguyên dữ liệu đã nhập
        if (result.hasErrors()) {
            return "contactUs";
        }

        // Lưu thông tin liên hệ vào cơ sở dữ liệu hoặc xử lý khác
        queryService.addQuery(query);

        // Thêm thông báo thành công
        model.addAttribute("querySuccess", "Thank you! Your message has been received. We will contact you soon.");

        // Clear form bằng cách tạo đối tượng mới
        model.addAttribute("contact", new Queries());

        // Trả về lại trang liên hệ
        return "contactUs";
    }
}
