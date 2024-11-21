<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit User</title>
    <link rel="stylesheet" href="<c:url value="/resource/bootstrap/css/bootstrap.min.css"/>">
    <script src="<c:url value="/resource/js/jquery.js"/>"></script>
    <script src="<c:url value="/resource/bootstrap/js/bootstrap.min.js"/>"></script>
</head>
<body>
    <div class="container" style="width: 800px; margin-top: 30px; margin-bottom:20px;">
        <div class="panel panel-primary">
            <!-- Thông báo -->
            <c:if test="${not empty errorMessage}">
                <p style="color: red; padding: 5px;">${errorMessage}</p>
            </c:if>
            <c:if test="${not empty infoMessage}">
                <p style="color: green; padding: 5px;">${infoMessage}</p>
            </c:if>
            <div class="panel-heading">
                <h3 class="panel-title">Edit User Information</h3>
            </div>
            <div class="panel-body">
                <form action="${pageContext.request.contextPath}/admin/user/update" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="userId" value="${customer.users.userId}">
                    
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" 
                                   value="${customer.firstName}" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" 
                                   value="${customer.lastName}" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email" 
                               value="${customer.users.emailId}" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" class="form-control" id="phone" name="phone" 
                               value="${customer.customerPhone}" required>
                    </div>

                    <div class="row">
                        <div class="col-md-12 form-group">
                            <label for="address">Address</label>
                            <input type="text" class="form-control" id="address" name="address" 
                                   value="${customer.billingAddress.address}" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="city">City</label>
                            <input type="text" class="form-control" id="city" name="city" 
                                   value="${customer.billingAddress.city}" required>
                        </div>
                        <div class="col-md-6 form-group">
                            <label for="state">State</label>
                            <input type="text" class="form-control" id="state" name="state" 
                                   value="${customer.billingAddress.state}" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">Update User</button>
                        <a href="${pageContext.request.contextPath}/admin/user/userList" class="btn btn-default">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="footer.jsp"%>

    <script>
    function validateForm() {
        var firstName = document.getElementById('firstName').value.trim();
        var lastName = document.getElementById('lastName').value.trim();
        var email = document.getElementById('email').value.trim();
        var phone = document.getElementById('phone').value.trim();
        var address = document.getElementById('address').value.trim();
        var city = document.getElementById('city').value.trim();
        var state = document.getElementById('state').value.trim();

        // Validate first name and last name (only letters)
        var nameRegex = /^[A-Za-z\s]+$/;
        if (!nameRegex.test(firstName) || !nameRegex.test(lastName)) {
            alert('First Name and Last Name must contain only letters');
            return false;
        }

        // Validate email
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert('Please enter a valid email address');
            return false;
        }

        // Validate phone number (assumes 10-digit phone number)
        var phoneRegex = /^\d{10}$/;
        if (!phoneRegex.test(phone)) {
            alert('Phone number must be 10 digits');
            return false;
        }

        // Check if any field is empty
        if (firstName === '' || lastName === '' || email === '' || 
            phone === '' || address === '' || city === '' || state === '') {
            alert('All fields are required');
            return false;
        }

        return true;
    }
    </script>
</body>
</html>