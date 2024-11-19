package com.dao;

import java.util.List;

import com.model.Customer;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.model.User;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private SessionFactory sessionFactory;

	
	public List<User> getAllUsers() {
		Session session = sessionFactory.openSession();
		//List<Product> products = session.createQuery("from Product").list();
	 List<User> users=	 session.createCriteria(User.class).list();
	 System.out.println(users);
		session.close();
		return users;
	}

	public void deleteUser(String userId) {
		Session session = sessionFactory.openSession();
		User user = (User) session.get(User.class, userId);
		session.saveOrUpdate(user);
		session.flush();
		session.close();// close the session
	}

	public void addUser(User user) {
		Session session = sessionFactory.openSession();
		session.save(user);
		session.close();
	}

	public User getUserById(String userId) {
		// Reading the records from the table
		Session session = sessionFactory.openSession();
		// select * from Product where isbn=i
		// if we call get method,Record doesnot exist it will return null
		// if we call load, if the record doesnt exist it will throw exception
		User user = (User) session.get(User.class, userId);
		session.close();
		return user;
	}

	public User getUserByEmail(String email) {
		Session session = sessionFactory.openSession();
		List<User> userList = session.createQuery("from User where emailId = :emailId")
				.setParameter("emailId", email).setFirstResult(0)
				.setMaxResults(1).list();
		session.close();

		// Kiểm tra nếu danh sách không trống và trả về user đầu tiên
		if (!userList.isEmpty()) {
			return userList.get(0);
		} else {
			return null; // Trả về null nếu không tìm thấy user
		}
	}
}
