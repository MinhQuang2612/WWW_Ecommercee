<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Change Password</title>
    <link rel="stylesheet" href="<c:url value='/resource/bootstrap/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resource/js/jquery.js'/>"></script>
    <script src="<c:url value='/resource/bootstrap/js/bootstrap.min.js'/>"></script>

    <style>
        body {
            background-color: #2c1e4d;
            color: white;
            font-family: Arial, sans-serif;
        }

        .change-password-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #1a1a2e;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6);
        }

        .change-password-title {
            color: #f8f9fa;
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
        }

        .form-control {
            background-color: rgba(255, 255, 255, 0.85);
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            height: auto;
        }

        .form-control:focus {
            box-shadow: 0 0 5px #007bff;
            background-color: white;
        }

        .btn-change-password {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .btn-change-password:hover {
            background-color: #0056b3;
        }

        .alert-success {
            background-color: #28a745;
            color: white;
        }

        .alert-danger {
            background-color: #dc3545;
            color: white;
        }

        .password-requirements {
            color: #adb5bd;
            font-size: 12px;
            margin-top: 5px;
        }

        .change-password-container label {
            color: #FFF;
        }
    </style>
</head>
<body>
    <div class="change-password-container">
        <h2 class="change-password-title">Change Password</h2>
        
        <!-- Show success message if any -->
        <c:if test="${not empty successMsg}">
            <div class="alert alert-success">${successMsg}</div>
        </c:if>
        
        <!-- Show error message if any -->
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger">${errorMsg}</div>
        </c:if>

        <form action="<c:url value='/changePassword'/>" method="post">
            <div class="form-group">
                <label for="currentPassword">Current Password</label>
                <input type="password" class="form-control" id="currentPassword" 
                       name="currentPassword" required>
            </div>

            <div class="form-group">
                <label for="newPassword">New Password</label>
                <input type="password" class="form-control" id="newPassword" 
                       name="newPassword" required>
                <div class="password-requirements">
                    Password must be at least 8 characters long and contain letters and numbers
                </div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm New Password</label>
                <input type="password" class="form-control" id="confirmPassword" 
                       name="confirmPassword" required>
            </div>

            <button type="submit" class="btn btn-change-password">Change Password</button>
        </form>
    </div>

    <script>
    $(document).ready(function() {
        // Validate password match
        $('#confirmPassword').on('keyup', function() {
            var newPassword = $('#newPassword').val();
            var confirmPassword = $(this).val();
            
            if (newPassword != confirmPassword) {
                $(this).css('border-color', '#dc3545');
            } else {
                $(this).css('border-color', '#28a745');
            }
        });
    });
    </script>
</body>
</html>
