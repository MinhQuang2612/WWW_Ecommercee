<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" href="<c:url value="/resource/bootstrap/css/bootstrap.min.css"/>">
    <script src="<c:url value="/resource/js/jquery.js"/>"></script>
    <script src="<c:url value="/resource/bootstrap/js/bootstrap.min.js"/>"></script>
    <link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
    <style>
        body, h1, h2, h3, h4, h5 {
            font-family: "Raleway", sans-serif
        }

        .w3-sidenav a, .w3-sidenav h4 {
            font-weight: bold
        }
    </style>
</head>
<body>
    <hr>
    <div class="w3-row-padding" style="padding:0px 30px; margin-bottom: 20px">
        <c:forEach var="product" items="${products}">
            <div class="w3-third w3-container w3-margin-bottom">
                <img src="<c:url value='/resource/images/products/${product.productId}.jpg'/>" alt="${product.productName}" style="width: 100%" class="w3-hover-opacity">
                <div class="w3-container w3-white">
                    <p><b>${product.productName}</b></p>
                    <p>
                        <ul>
                            <li>Category - ${product.productCategory}</li>
                            <li>Description - ${product.productDescription}</li>
                            <li>Manufacturer - ${product.productManufacturer}</li>
                            <li>Price - ${product.productPrice}</li>
                        </ul>
                    </p>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>
