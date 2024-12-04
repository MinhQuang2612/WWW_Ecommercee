<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <link rel="stylesheet" href="<c:url value='/resource/bootstrap/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resource/js/jquery.js'/>"></script>
    <script src="<c:url value='/resource/bootstrap/js/bootstrap.min.js'/>"></script>

    <style>
        :root {
            --primary-bg: #0f172a;
            --secondary-bg: #1e293b;
            --accent-color: #4a90e2;
            --text-color: #f8fafc;
            --border-color: rgba(255,255,255,0.1);
        }

        body {
            background-color: var(--primary-bg);
            color: var(--text-color);
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            line-height: 1.6;
        }

        .order-history-container {
            max-width: 1200px;
            width: 95%;
            margin: 50px auto;
            padding: 40px;
            background-color: var(--secondary-bg);
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            flex: 1;
        }

        .order-history-title {
            color: var(--accent-color);
            text-align: center;
            margin-bottom: 40px;
            font-size: 2.5rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .order-table {
            width: 100%;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .order-table thead {
            background-color: var(--accent-color);
        }

        .order-table th {
            padding: 15px 20px;
            text-align: center;
            font-size: 1.3rem; /* Tăng kích thước chữ tiêu đề */
            text-transform: uppercase;
            letter-spacing: 1px;
            color: white;
            border-bottom: 2px solid rgba(255,255,255,0.2);
            border-right: 1px solid rgba(255,255,255,0.1);
            font-weight: 600;
        }

        .order-table th:last-child {
            border-right: none;
        }

        .order-table tbody tr {
            background-color: var(--secondary-bg);
            transition: background-color 0.2s ease;
        }

        .order-table tbody tr:nth-child(even) {
            background-color: rgba(30, 41, 59, 0.8);
        }

        .order-table tbody tr:hover {
            background-color: rgba(45, 55, 72, 0.6);
        }

        .order-table td {
            padding: 15px 20px;
            text-align: center;
            font-size: 1.3rem; /* Tăng kích thước chữ dòng dữ liệu */
            color: var(--text-color);
            border-bottom: 1px solid var(--border-color);
            border-right: 1px solid var(--border-color);
        }

        .order-table td:last-child {
            border-right: none;
        }

        .view-details-btn {
            background-color: #28a745;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
            font-size: 1.3rem; /* Tăng kích thước chữ nút */
            display: inline-block;
        }

        .view-details-btn:hover {
            background-color: #218838;
        }

        .no-order-msg {
            text-align: center;
            font-size: 1.3rem; /* Tăng kích thước chữ thông báo */
            color: #94a3b8;
            padding: 30px;
            background-color: var(--primary-bg) !important;
        }

        /* Responsive Design */
        @media screen and (max-width: 768px) {
            .order-history-container {
                margin: 20px 10px;
                padding: 20px;
            }

            .order-table, 
            .order-table thead, 
            .order-table tbody, 
            .order-table th, 
            .order-table td, 
            .order-table tr {
                display: block;
            }

            .order-table thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }

            .order-table tr {
                margin-bottom: 15px;
                border: 1px solid #555;
            }

            .order-table td {
                border: none;
                position: relative;
                padding-left: 50%;
                text-align: right;
            }

            .order-table td:before {
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

        footer {
            background-color: #1e293b;
            color: #94a3b8;
            text-align: center;
            padding: 15px 0;
            width: 100%;
            margin-top: auto;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp"%>
    <div class="order-history-container">
        <h1 class="order-history-title">Order History</h1>

        <table class="order-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Shipping Address</th>
                    <th>Billing Address</th>
                    <th>Cart Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty orderHistory}">
                    <c:forEach var="order" items="${orderHistory}">
                        <tr>
                            <td>${order.customerOrderId}</td>
                            <td>${order.customer.firstName} ${order.customer.lastName}</td>
                            <td>${order.shippingAddress.address}</td>
                            <td>${order.billingAddress.address}</td>
                            <td>${order.cart.totalPrice}</td>
                            <td>
                                <a href="<c:url value='/orderDetail/${order.customerOrderId}'/>" class="view-details-btn">View Details</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>

                <c:if test="${empty orderHistory}">
                    <tr>
                        <td colspan="6" class="no-order-msg">You have no order history.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <%@ include file="footer.jsp"%>
</body>
</html>