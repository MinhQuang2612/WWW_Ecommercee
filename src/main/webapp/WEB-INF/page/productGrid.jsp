<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Product Grid</title>
    <link rel="stylesheet" href="<c:url value='/resource/bootstrap/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resource/js/jquery.js'/>"></script>
    <script src="<c:url value='/resource/bootstrap/js/bootstrap.min.js'/>"></script>
    <script
            src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
    <script src="<c:url value="/resource/js/productController.js"/>"></script>
   <style>
    /* Tông màu chủ đạo là xanh dương tối */
    body, h1, h2, h3, h4, h5 {
        font-family: "Raleway", sans-serif;
        background-color: #1e2a47; /* Màu nền xanh dương tối */
        color: #f8f9fa; /* Chữ sáng màu trắng */
    }

    /* Container chứa các sản phẩm */
    .product-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: space-between;
        padding: 0 30px;
    }

    /* Card cho mỗi sản phẩm */
    .product-card {
        background-color: #2c3e50; /* Màu nền xanh dương tối cho card */
        border: 1px solid #34495e; /* Đường viền màu xám */
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
        width: calc(33% - 20px); /* Mỗi sản phẩm chiếm 1/3 chiều rộng của container */
        transition: transform 0.3s ease-in-out;
        margin-bottom: 20px;
        overflow: hidden;
    }

    .product-card:hover {
        transform: scale(1.05); /* Hiệu ứng phóng to khi hover */
    }

    .product-card img {
        width: 100%;
        height: 200px; /* Đảm bảo hình ảnh không bị méo */
        object-fit: cover; /* Cắt bớt hình ảnh nếu cần */
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
    }

    .product-details {
        padding: 15px;
    }

    .product-details b {
        color: #f39c12; /* Màu vàng cho tên sản phẩm */
        font-size: 1.2em;
    }

    .product-details p {
        margin: 10px 0;
        color: #ecf0f1; /* Màu chữ sáng cho mô tả */
    }

    .product-details ul {
        list-style: none;
        padding: 0;
        color: #bdc3c7; /* Màu chữ nhạt */
    }

    .product-details li {
        margin-bottom: 5px;
    }

    /* Nút Thêm vào giỏ hàng nhỏ và ở góc */
    .add-to-cart-btn {
        background-color: #3498db; /* Màu xanh dương sáng */
        color: white;
        padding: 5px 10px;
        border: none;
        border-radius: 5px;
        font-size: 0.9em;
        position: absolute;
        bottom: 15px;
        right: 15px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .add-to-cart-btn:hover {
        background-color: #2980b9; /* Màu xanh dương đậm khi hover */
    }

    /* Đảm bảo các sản phẩm không bị tràn ra ngoài */
    .product-grid .product-card {
        box-sizing: border-box;
        position: relative;
    }
</style>

</head>
<body>
    <div class="product-grid" ng-app="myapp" ng-controller="myController">
        <c:forEach var="product" items="${products}">
            <div class="product-card">
                <img src="<c:url value='/resource/images/products/${product.productId}.png'/>" alt="${product.productName}">
                <div class="product-details">
                    <p><b>${product.productName}</b></p>
                    <ul>
                        <li>Unit stock - ${product.unitStock}</li>
                        <li>Description - ${product.productDescription}</li>
                        <li>Manufacturer - ${product.productManufacturer}</li>
                        <li>Price - ${product.productPrice}</li>
                    </ul>
                    <!-- Nút Thêm vào giỏ hàng ở góc -->
                    <security:authorize
                            access="hasAnyRole('ROLE_USER')">
                    <button type="button" ng-click="addToCart(${product.productId}, this)" class="add-to-cart-btn" ng-disabled="processingButtons[${product.productId}]">
                        {{ processingButtons[${product.productId}] ? 'Đang xử lý...' : 'Thêm vào giỏ hàng' }}
                    </button>
                    </security:authorize>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>
