<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Edit Product</title>
<link rel="icon" type="image/x-icon"
	href="<c:url value="/resource/images/favicon1.png"/>" />
<link rel="stylesheet"
	href="<c:url value="/resource/bootstrap/css/bootstrap.min.css"/>">
<script src="<c:url value="/resource/js/jquery.js"/>"></script>
<script src="<c:url value="/resource/bootstrap/js/bootstrap.min.js"/>"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resource/css/register.css"/>">

</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container" style="margin-bottom: 19px">
		<h1 class="well">Update Product !</h1>
		<div class="col-lg-12 well">
			<div class="row">

				<!--  RegisterServlet  form -->
				<c:url value="/admin/product/editProduct" var="url"></c:url>
				<form:form method="post" action="${url}"
					commandName="editProductObj">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-6 form-group">
								<form:label path="productId">Product Id</form:label>
								<form:input type="text" placeholder="Enter ProductId.."
									class="form-control" path="productId" readonly="true"></form:input>
							</div>
							<div class="col-sm-6 form-group">
								<form:label path="productName">Product Name</form:label>
								<form:input type="text" placeholder="Enter Product Name.."
									class="form-control" path="productName"></form:input>
									<form:errors path="productName" style="color: red; font-size: 12px;"></form:errors>
									
							</div>
						</div>
						<div class="form-group">
						    <form:label path="productDescription">Product Description</form:label>
						    <form:textarea type="text" placeholder="Enter Product Description.."
						                   class="form-control" path="productDescription"></form:textarea>
						    <form:errors path="productDescription" style="color: red; font-size: 12px;"></form:errors>
						</div>
						<div class="row">
						    <div class="col-sm-4 form-group">
						        <form:label path="productManufacturer">Product Manufacturer</form:label>
						        <form:input type="text"
						                    placeholder="Enter Product Manufacturer.." class="form-control"
						                    path="productManufacturer"></form:input>
						        <form:errors path="productManufacturer" style="color: red; font-size: 12px;"></form:errors>
						    </div>
						    <div class="col-sm-4 form-group">
						        <form:label path="productPrice">Product Price</form:label>
						        <form:input type="text" placeholder="Enter Product Price.."
						                    class="form-control" path="productPrice"></form:input>
						        <form:errors path="productPrice" style="color: red; font-size: 12px;"></form:errors>
						    </div>
						    <div class="col-sm-4 form-group">
						        <form:label path="unitStock">Number of Products</form:label>
						        <form:input type="text" placeholder="Number of Products.."
						                    class="form-control" path="unitStock"></form:input>
						        <form:errors path="unitStock" style="color: red; font-size: 12px;"></form:errors>
						    </div>
						</div>
						<div class="form-actions">
							<button type="submit" class="btn btn-lg btn-info">Update</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>