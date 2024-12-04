<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Detail</title>
    <link rel="stylesheet" href="<c:url value='/resource/bootstrap/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resource/js/jquery.js'/>"></script>
    <script src="<c:url value='/resource/bootstrap/js/bootstrap.min.js'/>"></script>

    <style>
        :root {
            --primary-bg: #0f172a;
            --secondary-bg: #1e293b;
            --accent-color: #4a90e2;
            --text-color: #f8fafc;
            --hover-color: #2563eb;
        }

        body {
            background-color: var(--primary-bg);
            color: var(--text-color);
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .order-detail-container {
            max-width: 1200px;
            width: 95%;
            margin: 50px auto;
            padding: 40px;
            flex: 1;
            background-color: var(--secondary-bg);
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .order-detail-title {
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
            font-weight: 600;
        }

        .order-table tbody tr {
            background-color: var(--secondary-bg);
            transition: all 0.3s ease;
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
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .order-table .no-order-items {
            text-align: center;
            font-size: 1.8rem; /* Tăng kích thước chữ khi không có mục nào */
            color: #94a3b8;
            padding: 30px;
            background-color: var(--primary-bg);
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
    <%@ include file="navbar.jsp" %>
    
    <div class="order-detail-container">
        <h1 class="order-detail-title">Order Detail</h1>

        <table class="order-table">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty orderItems}">
                    <c:forEach var="item" items="${orderItems}">
                        <tr>
                            <td>${item.product.productName}</td>
                            <td>${item.quality}</td>
                            <td>${item.price}</td>
                            <td>${item.quality * item.price}</td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty orderItems}">
                    <tr>
                        <td colspan="4" class="no-order-items">No items in this order.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>