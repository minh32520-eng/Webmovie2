<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entity.Booking"%>
<%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý vé</title>
<style>
body{font-family:Arial;background:#f1f5f9;margin:0}.container{width:95%;margin:30px auto}.btn{padding:8px 14px;background:#1e3a8a;color:#fff;border:none;border-radius:8px;text-decoration:none;cursor:pointer}.btn-danger{background:#dc2626}.btn-secondary{background:#475569}.table{width:100%;border-collapse:collapse;background:#fff;box-shadow:0 4px 12px rgba(0,0,0,.08)}.table th{background:#1e3a8a;color:#fff;padding:12px}.table td{padding:10px;text-align:center;border-bottom:1px solid #e5e7eb}select{padding:8px;border-radius:8px}
</style>
</head>
<body>
<div class="container">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px">
        <h2 style="color:#1e3a8a">Quản lý vé</h2>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin">Dashboard</a>
    </div>
    <table class="table">
        <tr><th>ID</th><th>Mã vé</th><th>Khách hàng</th><th>Phim</th><th>Suất chiếu</th><th>Tổng tiền</th><th>Thanh toán</th><th>Trạng thái</th><th>Hành động</th></tr>
        <% if (bookings != null) for (Booking b : bookings) { %>
        <tr>
            <td><%= b.getBookingId() %></td>
            <td><%= b.getBookingCode() %></td>
            <td><%= b.getUsername() %></td>
            <td><%= b.getMovieTitle() %></td>
            <td><%= b.getShowtimeStart() %></td>
            <td><%= (long)b.getTotalAmount() %></td>
            <td><%= b.getPaymentMethod() %></td>
            <td>
                <form action="${pageContext.request.contextPath}/adminbooking" method="post" style="display:flex;gap:8px;justify-content:center;align-items:center">
                    <input type="hidden" name="booking_id" value="<%= b.getBookingId() %>">
                    <select name="payment_status">
                        <option value="PENDING" <%= "PENDING".equals(b.getPaymentStatus()) ? "selected" : "" %>>PENDING</option>
                        <option value="PAID" <%= "PAID".equals(b.getPaymentStatus()) ? "selected" : "" %>>PAID</option>
                        <option value="CANCELLED" <%= "CANCELLED".equals(b.getPaymentStatus()) ? "selected" : "" %>>CANCELLED</option>
                        <option value="REFUNDED" <%= "REFUNDED".equals(b.getPaymentStatus()) ? "selected" : "" %>>REFUNDED</option>
                    </select>
                    <button class="btn">Lưu</button>
                </form>
            </td>
            <td><%= b.getPaymentStatus() %></td>
            <td><a class="btn btn-danger" onclick="return confirm('Xóa booking này?')" href="${pageContext.request.contextPath}/adminbooking?action=delete&id=<%= b.getBookingId() %>">Xóa</a></td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
