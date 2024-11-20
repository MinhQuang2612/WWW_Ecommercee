<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Product Grid</title>
<link rel="stylesheet"
	href="<c:url value='/resource/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/resource/js/jquery.js'/>"></script>
<script src="<c:url value='/resource/bootstrap/js/bootstrap.min.js'/>"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script src="<c:url value="/resource/js/productController.js"/>"></script>
<style>
/* Tông màu chủ đạo: xanh lam kết hợp trắng */
body, h1, h2, h3, h4, h5 {
    font-family: "Raleway", sans-serif;
    background-color: #e3f2fd; /* Nền xanh nhạt */
    color: #1e3d59; /* Màu chữ xanh đậm */
    margin: 0;
    padding: 0;
}

/* Container chứa các sản phẩm */
.product-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: space-evenly;
    padding: 20px 40px;
    background-color: #ffffff; /* Nền trắng cho vùng hiển thị sản phẩm */
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng nhẹ */
}

/* Card cho mỗi sản phẩm */
.product-card {
    background-color: #ffffff; /* Nền trắng cho từng card */
    border: 1px solid #e0e0e0; /* Đường viền xám nhạt */
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng nhẹ */
    width: calc(30% - 20px); /* Mỗi sản phẩm chiếm 1/3 chiều rộng */
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
    overflow: hidden;
    position: relative;
}

.product-card:hover {
    transform: translateY(-5px); /* Nổi lên khi hover */
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
}

/* Hình ảnh sản phẩm */
.product-card img {
    width: 100%;
    height: 220px; /* Đảm bảo kích thước nhất quán */
    object-fit: cover; /* Cắt hình ảnh gọn gàng */
    border-bottom: 1px solid #e0e0e0; /* Tách hình ảnh và nội dung bằng viền */
}

/* Phần chi tiết sản phẩm */
.product-details {
    padding: 15px 20px;
    background-color: #f8f9fa; /* Nền xám nhạt */
    border-top: 1px solid #e0e0e0;
    border-bottom-left-radius: 12px;
    border-bottom-right-radius: 12px;
}

.product-details b {
    color: #007bff; /* Màu xanh lam cho tên sản phẩm */
    font-size: 1.5em;
    font-weight: 600;
    margin-bottom: 10px;
    display: block;
}

.product-details ul {
    list-style: none;
    padding: 0;
    margin: 10px 0;
    color: #6c757d; /* Màu xám hiện đại */
    font-size: 0.95em;
    line-height: 1.6;
}

.product-details li {
    margin-bottom: 5px;
}

/* Làm nổi bật giá sản phẩm */
.product-details li:nth-child(4) {
    font-size: 1.2em;
    font-weight: bold;
    color: #e74c3c; /* Màu đỏ nổi bật */
}

/* Làm nổi bật nhà sản xuất */
.product-details li:nth-child(3) {
    font-weight: bold;
    color: #28a745; /* Màu xanh lá tươi */
}

/* Nút Thêm vào giỏ hàng */
.add-to-cart-btn {
    background-color: #007bff; /* Màu xanh lam sáng */
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 6px;
    font-size: 1em;
    position: absolute;
    bottom: 15px;
    right: 15px;
    cursor: pointer;
    transition: background-color 0.3s ease, box-shadow 0.3s ease;
}

.add-to-cart-btn:hover {
    background-color: #0056b3; /* Màu xanh lam đậm khi hover */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

/* Hiển thị sản phẩm rõ ràng hơn trên màn hình nhỏ */
@media (max-width: 768px) {
    .product-card {
        width: calc(50% - 20px); /* Mỗi sản phẩm chiếm 50% màn hình */
    }
}

@media (max-width: 576px) {
    .product-card {
        width: 100%; /* Mỗi sản phẩm chiếm 100% màn hình */
    }
}

</style>
</head>
<body>
	<div class="product-grid" ng-app="myapp" ng-controller="myController">
		<c:forEach var="product" items="${products}">
			<div class="product-card">
				<img
					src="<c:url value='/resource/images/products/${product.productId}.png'/>"
					alt="${product.productName}">
				<div class="product-details">
					<p>
						<b>${product.productName}</b>
					</p>
					<ul>
						<li>Unit stock - ${product.unitStock}</li>
						<%-- <li>Description - ${product.productDescription}</li> --%>
						<li>Manufacturer - ${product.productManufacturer}</li>
						<li>Price - ${product.productPrice}</li>
					</ul>
					<!-- Nút Thêm vào giỏ hàng ở góc -->
					<security:authorize access="hasAnyRole('ROLE_USER')">
						<button type="button"
							ng-click="addToCart(${product.productId}, this)"
							class="add-to-cart-btn"
							ng-disabled="processingButtons[${product.productId}]">
							{{ processingButtons[${product.productId}] ? 'Đang xử lý...' :
							'Thêm vào giỏ hàng' }}</button>
					</security:authorize>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>
