<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>AboutUs</title>
<link rel="stylesheet"
	href="<c:url value="/resource/bootstrap/css/bootstrap.min.css"/>">
<script src="<c:url value="/resource/js/jquery.js"/>"></script>
<script src="<c:url value="/resource/bootstrap/js/bootstrap.min.js"/>"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resource/css/aboutus.css"/>">
<link rel="icon" type="image/x-icon"
	href="<c:url value="/resource/images/favicon1.png"/>" />
	<style>
	/* Đặt font chữ chung */
body, h1, h2, h3, h4, h5, p {
    font-family: 'Raleway', sans-serif;
    margin: 0;
    padding: 0;
    color: #2c3e50; /* Màu xanh đậm */
}

body {
    background-color: #f8f9fa; /* Màu nền sáng */
    line-height: 1.6; /* Tăng khoảng cách dòng để dễ đọc */
}

/* Container nền xanh dương nhạt */
.bg-1 {
    background-color: #3498db; /* Nền xanh dương */
    color: #fff; /* Chữ trắng */
    padding: 40px 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

/* Tiêu đề nổi bật */
.bg-1 h3, .bg-2 h3 {
    font-size: 2em;
    margin-bottom: 20px;
    text-transform: uppercase;
    font-weight: 600;
}

/* Hình ảnh tròn */
.img-circle {
    border: 5px solid #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

/* Container nội dung */
.bg-2 {
    background-color: #ffffff; /* Nền trắng */
    color: #2c3e50;
    padding: 40px 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin: 20px auto;
}

/* Đoạn văn bản */
#para {
    margin: 20px 0;
    font-size: 1.1em;
    text-align: justify;
    color: #34495e; /* Màu xám xanh */
}

/* Liên kết nút hoặc CTA (nếu cần thêm) */
a.btn {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 20px;
    background-color: #3498db;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

a.btn:hover {
    background-color: #2980b9;
}

/* Responsive cho màn hình nhỏ */
@media (max-width: 768px) {
    .bg-1, .bg-2 {
        padding: 20px 10px;
    }

    .img-circle {
        width: 280px;
        height: 280px;
    }

    h3 {
        font-size: 1.5em;
    }
}
	
	</style>
</head>

<body>

	<!-- importing navigation bar -->
	<%@ include file="navbar.jsp"%>

	<!-- Content -->
	<div class="row"
		style="margin-top: 4px; margin-right: 0px; margin-left: 0px; margin-bottom: 19px">
		<div class="col-sm-4" style="margin-top: 25px">
			<div class="container-fluid bg-1 text-center">
				<h3>Who Am I?</h3>
				<img src="<c:url value="/resource/images/aboutImage.png"/>"
					class="img-circle" alt="AboutUs" width="350" height="350">
				<h3>Aphrodite Shop</h3>
			</div>

		</div>

		<div class="container-fluid bg-2 text-center">
			
			<div id="para"  style="margin-top: 50px;">
				<p>Aphrodite Shop là dự án của nhóm sinh viên ngành Kỹ thuật
					Phần mềm (SE) thuộc trường Đại học Công Nghiệp Thành phố Hồ Chí
					Minh. Chúng tôi được truyền cảm hứng để mang đến một nền tảng mua
					sắm trực tuyến với trải nghiệm đơn giản và đáng tin cậy.</p>
			</div>
			<div id="para">
				<p>Với sứ mệnh kết nối người mua và người bán, Aphrodite hướng
					đến việc tạo ra một hệ sinh thái thương mại điện tử thông minh và
					bền vững. Chúng tôi tin rằng công nghệ không chỉ đơn thuần là công
					cụ mà còn là cầu nối giúp cuộc sống trở nên dễ dàng và hiệu quả
					hơn.</p>
			</div>
			<div id="para">
				<p>Giá trị cốt lõi của chúng tôi bao gồm sự sáng tạo, tính chính
					trực và sự chuyên nghiệp. Chúng tôi luôn đặt khách hàng lên hàng
					đầu và không ngừng học hỏi, cải thiện để mang đến trải nghiệm tốt
					nhất.</p>
			</div>
		</div>
	</div>

	<!-- 	importing footer  -->
	<%@ include file="footer.jsp"%>

</body>
</html>