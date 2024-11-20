<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

<!-- 	navigation Bar -->
<%@ include file="navbar.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Product Management</title>
<link rel="icon" type="image/x-icon"
	href="<c:url value="/resource/images/favicon1.png"/>" />
<link rel="stylesheet"
	href="<c:url value="../resource/bootstrap/css/bootstrap.min.css"/>">
<script src="<c:url value="../resource/js/jquery.js"/>"></script>
<script src="<c:url value="../resource/bootstrap/js/bootstrap.min.js"/>"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="../resource/css/ProductList.css"/>">
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script src="<c:url value="../resource/js/productController.js"/>"></script>
<style>
#searchForm button {
	background-color: #007bff; /* Màu nền nút */
	color: white; /* Màu chữ */
	border: none; /* Không có đường viền */
	padding: 8px 12px; /* Padding cho nút */
	font-size: 14px; /* Cỡ chữ */
	cursor: pointer; /* Hiển thị con trỏ khi hover */
	border-radius: 4px; /* Bo góc */
	margin-left: 5px;
}

/* Thêm hiệu ứng hover cho nút */
#searchForm button:hover {
	background-color: #0056b3; /* Màu nền khi hover */
}
</style>
</head>
<body ng-app="myapp">
	<div class="container" id="productTable"
		style="width: 1145px; margin-bottom: 180px; margin-top: 15px;">
		<h2>Product Management</h2>
		<p>The List of Products in our Database</p>

		<form method="get" action="searchProducts" class="form-inline"
			id="searchForm" style="margin-bottom: 20px;">
			<input type="text" name="searchKeyword" class="form-control"
				placeholder="Search by Name or Manufacturer" style="width: 300px;">
			<button type="submit">Search</button>
		</form>

		<!-- Thêm thông báo lỗi/thành công -->
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger">${errorMessage}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="alert alert-info">${msg}</div>
		</c:if>


		<table class="table table-hover" id="productList">
			<thead>
				<tr>
					<th>Screen-Shot</th>
					<th>Product Id</th>
					<!-- <th>Category</th> -->
					<th>Product Name</th>
					<th>Products Price</th>
					<th>Stock Unit</th>
					<th>Description</th>
					<th>Manufacturer</th>
					<th>View <security:authorize access="hasAnyRole('ROLE_USER')">
					/ Add to Cart
					</security:authorize> <!-- 					views only to the admin --> <security:authorize
							access="hasAnyRole('ROLE_ADMIN')">
					/Edit/Delete
					</security:authorize>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${products}" var="prod">
					<tr>
						<td style="width: 171px"><img
							src="<c:url value="/resource/images/products/${prod.productId}.png"/>"
							style="width: 100px; height: 90px;" ${prod.productName}"  /></td>
						<td>${prod.productId}</td>
						<%-- <td>${prod.productCategory}</td> --%>
						<td>${prod.productName}</td>
						<td>${prod.productPrice}</td>
						<td>${prod.unitStock}</td>
						<td style="width: 180px">${prod.productDescription}</td>
						<td>${prod.productManufacturer}</td>
						<td ng-controller="myController"><a
							href="getProductById/${prod.productId}" class="btn btn-info"
							role="button"> <span class="glyphicon glyphicon-info-sign"></span></a>

							<!-- 						view only for user --> <security:authorize
								access="hasAnyRole('ROLE_USER')">
								<a href="#" ng-click="addToCart(${prod.productId})"
									class="btn btn-primary" style="margin-left: 5px"> <span
									class="glyphicon glyphicon-shopping-cart"></span> {{
									processingButtons[${prod.productId}] ? 'Đang xử lý...' : '' }}
								</a>
							</security:authorize> <!-- 						view only to the admin --> <security:authorize
								access="hasAnyRole('ROLE_ADMIN')">
								<a href="admin/product/editProduct/${prod.productId}"
									class="btn btn-success" style="margin-left: 5px"> <span
									class="glyphicon glyphicon-edit"></span></a>
								<a href="admin/delete/${prod.productId}" class="btn btn-danger"
									style="margin-left: 5px"> <span
									class="glyphicon glyphicon-trash"></span></a>
							</security:authorize></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>
<%@ include file="footer.jsp"%>