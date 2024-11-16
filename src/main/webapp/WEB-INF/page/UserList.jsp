<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>User Management</title>
<link rel="stylesheet" href="<c:url value="/resource/bootstrap/css/bootstrap.min.css"/>">
<script src="<c:url value="/resource/js/jquery.js"/>"></script>
<script src="<c:url value="/resource/bootstrap/js/bootstrap.min.js"/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resource/css/productList.css"/>">
</head>
<body>
	<div class="container" id="productTable" style="width:1145px;margin-bottom: 180px;">
		<h2>User Management</h2>
		<p>The List of Users in our Database</p>
		<table class="table table-hover" id="productList">
			<thead>
				<tr>
					<th>User Id</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Address</th>
					
					<th>State</th>
					<th>City</th>
					<th>Phone Number</th>
					<th>Email</th>

					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${customers}" var="customer">
					<tr>
						<td>${customer.users.userId}</td>
						<td>${customer.firstName}</td>
						<td>${customer.lastName}</td>
						<td>${customer.billingAddress.address}</td>
						
						<td>${customer.billingAddress.state}</td>
						<td>${customer.billingAddress.city}</td>
						<td>${customer.customerPhone}</td>
						<td>${customer.users.emailId}</td>

						
						<td>
						    <a href="user/delete/${customer.users.userId}"> <span class="glyphicon glyphicon-trash"></span></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>
