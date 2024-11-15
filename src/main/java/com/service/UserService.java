package com.service;

import java.util.List;

import com.model.User;

public interface UserService {

	public List<User> getAllUsers();
	
	public void deleteUser(String userId);
	
	public void addUser(User user);
	
	public User getUserById(String userId);
}
