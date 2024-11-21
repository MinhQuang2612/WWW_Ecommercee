<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>User Management</title>
<link rel="stylesheet"
	href="<c:url value="/resource/bootstrap/css/bootstrap.min.css"/>">
<script src="<c:url value="/resource/js/jquery.js"/>"></script>
<script src="<c:url value="/resource/bootstrap/js/bootstrap.min.js"/>"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resource/css/productList.css"/>">
</head>
<body>
	<div class="container" id="productTable"
		style="width: 1145px; margin-bottom: 180px;">
		<h2>User Management</h2>
		<p>The List of Users in our Database</p>

		<div style="margin-top: 10px;">
			<c:if test="${not empty searchError}">
				<div class="alert alert-warning" role="alert">${searchError}</div>
			</c:if>

			<c:if test="${not empty searchMessage}">
				<div class="alert alert-info" role="alert">${searchMessage}</div>
			</c:if>
		</div>

		<!-- Form search hiện tại của bạn -->
		<form method="get"
			action="${pageContext.request.contextPath}/admin/user/searchUsers"
			class="form-inline" style="margin-bottom: 20px;"
			onsubmit="return validateSearch();">
			<input type="text" name="searchKeyword" id="searchKeyword"
				class="form-control" placeholder="Search by Name or Email"
				style="width: 300px;">
			<button type="submit" class="btn btn-primary"
				style="margin-left: 10px;">Search</button>
		</form>

		<!-- Thêm JavaScript validation -->
		<script>
		function validateSearch() {
	    var searchKeyword = document.getElementById('searchKeyword').value.trim();
	    if (searchKeyword === '') {
	        alert('Please enter a search keyword');
	        return false;
	    }
	    	return true;
		}
		</script>

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
							<a href="${pageContext.request.contextPath}/admin/user/edit?userId=${customer.users.userId}">
									<span class="glyphicon glyphicon-edit"></span>
							</a> 
							<a href="user/delete/${customer.users.userId}"> <span
									class="glyphicon glyphicon-trash"></span>
							</a>
						</td>


					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>
