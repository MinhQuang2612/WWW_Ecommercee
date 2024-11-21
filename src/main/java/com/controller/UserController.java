package com.controller;

import java.util.List;

import javax.validation.Valid;

import com.model.*;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.service.CustomerService;
import com.service.UserService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class UserController {

	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private UserService userService;

	@Autowired
	private SessionFactory sessionFactory;

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public CustomerService getCustomerService() {
		return customerService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	
	@RequestMapping(value = "/admin/user/userList", method = RequestMethod.GET)
	public ModelAndView getAllUsers() {
	    List<Customer> customers = customerService.getAllCustomers(); 
	    return new ModelAndView("UserList", "customers", customers); 
	}
	
	 @RequestMapping(value = "/admin/user/searchUsers", method = RequestMethod.GET)
	    public ModelAndView searchUsers(@RequestParam("searchKeyword") String searchKeyword) {
	        ModelAndView modelAndView = new ModelAndView("UserList");
	        
	        if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
	            modelAndView.addObject("searchError", "Please enter a search keyword");
	            // Vẫn hiển thị tất cả customers khi không có từ khóa
	            modelAndView.addObject("customers", customerService.getAllCustomers());
	            return modelAndView;
	        }

	        List<Customer> customers = customerService.searchCustomers(searchKeyword);
	        
	        if (customers.isEmpty()) {
	            modelAndView.addObject("searchMessage", "No results found for: " + searchKeyword);
	        } else {
	            modelAndView.addObject("searchMessage", "Found " + customers.size() + " results for: " + searchKeyword);
	        }
	        
	        modelAndView.addObject("customers", customers);
	        return modelAndView;
	    }
	 
	 

	@RequestMapping(value = "/customer/registration")
	public ModelAndView getRegistrationForm() {
		Customer customer = new Customer();
		User user = new User();
		BillingAddress ba = new BillingAddress();
		ShippingAddress sa = new ShippingAddress();
		customer.setShippingAddress(sa);
		customer.setBillingAddress(ba);
		customer.setUsers(user);

		return new ModelAndView("register", "customer", customer);
	}

	// to insert the data
	@RequestMapping(value = "/customer/registration", method = RequestMethod.POST)
	public String registerCustomer(@Valid @ModelAttribute(value = "customer") Customer customer, Model model,
			BindingResult result) {
		if (result.hasErrors())
			return "register";
		customerService.addCustomer(customer);
		model.addAttribute("registrationSuccess", "Registered Successfully. Login using username and password");
		return "login";
	}
	
	@RequestMapping(value = "/admin/user/edit", method = RequestMethod.GET)
	public ModelAndView editUser(@RequestParam("userId") Long userId, Model model) {
	    // Lấy thông tin customer theo userId
	    Customer customer = customerService.getCustomerByUserId(userId);

		String infoMessage = (String) model.asMap().get("infoMessage");
		String errorMessage = (String) model.asMap().get("errorMessage");
	    
	    ModelAndView modelAndView = new ModelAndView("userEdit");
	    modelAndView.addObject("customer", customer);
		modelAndView.addObject("infoMessage", infoMessage);
		modelAndView.addObject("errorMessage", errorMessage);
	    return modelAndView;
	}

	@RequestMapping(value = "/admin/user/update", method = RequestMethod.POST)
	public String updateUser(
			@RequestParam(value = "userId") Long userId,
			@RequestParam(value = "firstName") String firstName,
			@RequestParam(value = "lastName") String lastName,
			@RequestParam(value = "email") String email,
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "address") String address,
			@RequestParam(value = "city") String city,
			@RequestParam(value = "state") String state,
			RedirectAttributes redirectAttributes
	) {

		Customer customerMail = customerService.getCustomerByemailId(email);
		if( customerMail != null && customerMail.getUsers().getUserId() != userId ) {
			redirectAttributes.addFlashAttribute("errorMessage", "Email already in use");
			return "redirect:/admin/user/edit?userId=" + userId;
		}
		Session session = sessionFactory.openSession();

		// Lấy thông tin customer theo userId
		Customer customer = customerService.getCustomerByUserId(userId);
		String oldEmail = customer.getUsers().getEmailId();
		customer.getUsers().setEmailId(email);
		customer.setFirstName(firstName);
		customer.setLastName(lastName);
		customer.setCustomerPhone(phone);
		customer.getBillingAddress().setAddress(address);
		customer.getBillingAddress().setCity(city);
		customer.getBillingAddress().setState(state);

		Query query = session.createQuery("from Authorities where emailId=?");
		query.setString(0, oldEmail);
		Authorities authorities = (Authorities)query.uniqueResult();
		authorities.setEmailId(email);

		session.save(authorities);
		session.saveOrUpdate(customer);
		session.flush();
		session.close();

		redirectAttributes.addFlashAttribute("infoMessage", "Update info successful");

		return "redirect:/admin/user/edit?userId=" + userId;
	}
}
