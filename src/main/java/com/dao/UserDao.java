package com.dao;

import java.util.List;

import com.model.User;

public interface UserDao {

	public List<User> getAllUsers();

	public void deleteUser(String userId);
	
	public void addUser(User user);
	
	public User getUserById(String userId);

	public User getUserByEmail(String email);
}
