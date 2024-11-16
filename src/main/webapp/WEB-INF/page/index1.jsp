<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>ShopIeasy</title>
    <link rel="icon" type="image/x-icon" href="<c:url value='/resource/images/favicon1.png'/>" />
</head>
<body>
    <%@ include file="navbar.jsp"%>
    <!-- Hiển thị thông báo tìm kiếm -->
    <c:if test="${!empty searchKeyword}">
        <div class="alert alert-info" style="margin: 20px;">
            <p>Kết quả tìm kiếm cho từ khóa: <strong>${searchKeyword}</strong></p>
        </div>
    </c:if>
    <%@ include file="slider.jsp"%> 
    <%@ include file="productGrid.jsp"%> 
    <%@ include file="footer.jsp"%> 
</body>
</html>
