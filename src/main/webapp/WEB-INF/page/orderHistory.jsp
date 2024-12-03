<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Order History</title>
<link rel="stylesheet"
	href="<c:url value='/resource/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/resource/js/jquery.js'/>"></script>
<script src="<c:url value='/resource/bootstrap/js/bootstrap.min.js'/>"></script>

<style>
	/* Đặt nền của body */
body {
    background-color: #2c1e4d;
    color: white;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    line-height: 1.6;
}

/* Container của lịch sử đơn hàng */
.order-history-container {
    max-width: 1200px;
    margin: 50px auto;
    padding: 40px;
    background-color: #1a1a2e;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.7);
    flex: 1;
}

/* Tiêu đề của trang */
.order-history-title {
    color: #f8f9fa;
    text-align: center;
    margin-bottom: 40px;
    font-size: 36px;
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: 2px;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

/* Bảng đơn hàng */
table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    overflow: hidden;
    
}

/* Định dạng cho các tiêu đề cột */
th {
    background-color: #007bff;
    color: white;
    padding: 15px 20px;
    text-align: center;
    font-size: 16px;
    text-transform: uppercase;
    letter-spacing: 1px;
    border-top: 1px solid #0056b3;
    border-bottom: 1px solid #0056b3;
    border-right: 1px solid #0056b3; /* Thêm đường viền phải */
   
}

/* Xóa đường viền phải cho thẻ th cuối cùng */
th:last-child {
    border-right: none;
    
}

/* Định dạng cho các ô dữ liệu */
tr {
    background-color: #3a3a5a;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s ease;
}

tr:hover {
    transform: scale(1.02);
    z-index: 1;
}

td {
    background-color: transparent;
    color: #f8f9fa;
    padding: 15px;
    text-align: center;
    font-size: 14px;
    border-right: 1px solid #555; /* Đảm bảo các ô cũng có đường viền */
}

/* Xóa đường viền phải cho ô td cuối cùng */
td:last-child {
    border-right: none;
}

/* Đổi màu nền cho các dòng */
tr:nth-child(even) {
    background-color: #2a2a4a;
}

tr:nth-child(odd) {
    background-color: #3a3a5a;
}

/* Định dạng cho thông báo không có đơn hàng */
td[colspan="6"] {
    text-align: center;
    font-size: 18px;
    color: #adb5bd;
    padding: 30px;
    background-color: #1a1a2e !important;
}

/* Định dạng cho nút "Xem chi tiết" */
.view-details-btn {
    background-color: #28a745;
    color: white;
    padding: 8px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    text-decoration: none;
    transition: background-color 0.3s ease, transform 0.2s ease;
    font-size: 13px;
    display: inline-block;
}

.view-details-btn:hover {
    background-color: #218838;
    transform: scale(1.05);
}

/* Responsive design improvements */
@media screen and (max-width: 768px) {
    .order-history-container {
        margin: 20px 10px;
        padding: 20px;
    }

    table, thead, tbody, th, td, tr {
        display: block;
    }

    thead tr {
        position: absolute;
        top: -9999px;
        left: -9999px;
    }

    tr {
        margin-bottom: 15px;
        border: 1px solid #555;
    }

    td {
        border: none;
        position: relative;
        padding-left: 50%;
        text-align: right;
    }

    td:before {
        content: attr(data-label);
        position: absolute;
        left: 6px;
        width: 45%;
        padding-right: 10px;
        white-space: nowrap;
        text-align: left;
        font-weight: bold;
    }
}

/* Định dạng footer */
footer {
    background-color: #333;
    color: white;
    text-align: center;
    padding: 15px 0;
    position: relative;
    bottom: 0;
    width: 100%;
}
	

</style>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="order-history-container">
		<h1 class="order-history-title">Order History</h1>

		<!-- Hiển thị bảng ngay cả khi không có dữ liệu -->
		<table>
			<thead>
				<tr>
					<th style="padding: 5px;">Order ID</th>
					<th style="padding: 5px;">Customer</th>
					<th style="padding: 5px;">Shipping Address</th>
					<th style="padding: 5px;">Billing Address</th>
					<th style="padding: 5px;">Cart Total</th>
					<th style="padding-left: 15px;">Action</th>
					<!-- Cột mới cho nút "Xem chi tiết" -->
				</tr>
			</thead>
			<tbody>
				<!-- Kiểm tra nếu có đơn hàng -->
				<c:if test="${not empty orderHistory}">
					<!-- Duyệt qua tất cả các đơn hàng -->
					<c:forEach var="order" items="${orderHistory}">
						<tr>
							<td>${order.customerOrderId}</td>
							<td style="padding: 5px;">${order.customer.firstName} ${order.customer.lastName}</td>
							<td>${order.shippingAddress.address}</td>
							<td>${order.billingAddress.address}</td>
							<td>${order.cart.totalPrice}</td>
							<td>
								<!-- Nút Xem chi tiết --> <a
								href="<c:url value='/orderDetail/${order.customerOrderId}'/>"
								class="view-details-btn">View Details</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>

				<!-- Nếu không có đơn hàng, hiển thị thông báo -->
				<c:if test="${empty orderHistory}">
					<tr>
						<td colspan="6" class="no-order-msg">You have no order
							history.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
