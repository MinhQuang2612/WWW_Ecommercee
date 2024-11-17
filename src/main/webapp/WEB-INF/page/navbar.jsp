<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet"
	href="<c:url value='/resource/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/resource/js/jquery.js'/>"></script>
<script src="<c:url value='/resource/bootstrap/js/bootstrap.min.js'/>"></script>
<style>
/* Tổng quan */
body {
	background-color: #2c1e4d;
	color: white;
}

.top-bar {
	background-color: #1a1a2e;
	padding: 10px 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo-container {
	display: flex;
	align-items: center;
}

.logo-container img {
	height: 50px;
	margin-right: 10px;
}

.logo-container a {
	color: #ffffff;
	text-decoration: none;
	font-size: 24px;
	font-weight: bold;
}

.search-container {
	display: flex;
	flex-grow: 1;
	justify-content: center;
	max-width: 600px;
}

.search-container input {
	width: calc(100% - 60px);
	padding: 10px;
	border: none;
	border-radius: 10px 0 0 10px;
	background-color: #fff;
	color: #000;
	outline: none;
	font-size: 14px;
	transition: all 0.3s ease;
}

.search-container input:focus {
	background-color: #f1f1f1;
	box-shadow: 0 0 5px #007bff;
}

.search-container button {
	padding: 10px 20px;
	border: none;
	background-color: #007bff;
	color: white;
	border-radius: 0 10px 10px 0;
	cursor: pointer;
	font-size: 16px;
	transition: all 0.3s ease;
}

.search-container button:hover {
	background-color: #0056b3;
}

.user-actions span {
	color: white;
	font-size: 18px;
	margin-right: 15px;
}

.user-actions a {
	color: white;
	text-decoration: none;
	margin-left: 15px;
	font-size: 16px;
}

.user-actions a span {
	margin-right: 5px;
}

.navbar {
	background-color: #1a1a2e;
	margin-bottom: 0;
}

.navbar .nav {
	padding-top: 20px;
}

.navbar .nav>li>a {
	color: white !important;
}

.navbar .nav>li>a:hover {
	background-color: #007bff !important;
}
</style>
</head>
<body>
	<!-- Thanh trên cùng -->
	<div class="top-bar">
		<div class="logo-container">
			<img src="<c:url value='/resource/images/logo.jpg'/>" alt="logo">
			<a href="<c:url value='/index1'/>">Aphrodite</a>
		</div>
		<div class="search-container">
			<form action="<c:url value='/search'/>" method="GET"
				style="display: flex; width: 100%;">
				<input type="text" placeholder="Search here..." name="searchTerm" value="${param.searchTerm}">
				<button type="submit">
					<span class="glyphicon glyphicon-search"></span>
				</button>
			</form>
		</div>

		<div class="user-actions">
			<c:if test="${!empty pageContext.request.userPrincipal.name}">
				<span>Welcome, <strong>${pageContext.request.userPrincipal.name}</strong></span>
				<a href="<c:url value='/cart/getCartById'/>"> <span
					class="glyphicon glyphicon-shopping-cart"></span> Cart
				</a>
				<a href="<c:url value='/logout'/>"> <span
					class="glyphicon glyphicon-log-out"></span> Logout
				</a>
			</c:if>
			<c:if test="${pageContext.request.userPrincipal.name == null}">
				<a href="<c:url value='/login'/>"> <span
					class="glyphicon glyphicon-shopping-cart"></span> My Cart
				</a>
				<a href="<c:url value='/customer/registration'/>"> <span
					class="glyphicon glyphicon-user"></span> SignUp
				</a>
				<a href="<c:url value='/login'/>"> <span
					class="glyphicon glyphicon-log-in"></span> Login
				</a>
			</c:if>
		</div>
	</div>

	<!-- Menu điều hướng -->
	<nav class="navbar navbar-inverse">
		<div class="container">
			<ul class="nav navbar-nav">
				<li><a href="<c:url value='/index1'/>">Home</a></li>
				<li><a href="<c:url value='/getAllProducts'/>">Product List</a></li>
				<li><a href="<c:url value='/aboutus'/>">About Us</a></li>
				<security:authorize access="hasRole('ROLE_USER')">
					<li><a href="<c:url value='/contactus'/>">Contact Us</a></li>
				</security:authorize>
				<security:authorize access="hasRole('ROLE_ADMIN')">
					<li><a href="<c:url value='/admin/product/addProduct'/>">Add
							Product</a></li>
					<li><a href="<c:url value='/admin/user/userList'/>">User
							List</a></li>
				</security:authorize>
			</ul>
		</div>
	</nav>

</body>
</html>
