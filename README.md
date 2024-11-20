Các chức năng:
1. Đăng ký người dùng:

- Hỗ trợ người dùng đăng ký tài khoản.
2. Các thao tác CRUD:

- Người dùng có thể thêm sản phẩm vào giỏ hàng và xem tóm tắt mua sắm.
- Quản trị viên có thể thêm sản phẩm vào danh sách sản phẩm.
- Quản trị viên có thể chỉnh sửa thông tin chi tiết của sản phẩm.
- Quản trị viên có thể xóa sản phẩm khỏi danh sách.
3. Bảo mật Spring (Spring Security):

- Người dùng có thể đăng nhập vào trang web.
- Toàn bộ trang web sẽ thay đổi tùy theo vai trò của người dùng (User hoặc Admin).
- Người dùng có thể đăng xuất sau khi hoàn tất.
4. Luồng Web Spring (Spring WebFlow):

- Sau khi thêm sản phẩm vào giỏ hàng, người dùng có thể thanh toán thông qua Spring WebFlow.
- Xác nhận thông tin người dùng.
- Xác nhận địa chỉ giao hàng và thanh toán.
- Hiển thị hóa đơn.
- Nếu người dùng hủy luồng thanh toán, sẽ chuyển hướng tới trang hủy.
- Nếu người dùng hoàn tất thanh toán, sẽ chuyển đến trang cảm ơn kèm báo cáo thời gian giao hàng.
5. Công cụ và công nghệ:
- Công nghệ: Bootstrap, Java, Spring MVC, Hibernate, JSP, Maven.
- Máy chủ ứng dụng: Apache Tomcat Server.
- Cơ sở dữ liệu: Cơ sở dữ liệu MSSQL.
