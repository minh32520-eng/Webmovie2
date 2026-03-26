<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<style>
body { margin: 0; font-family: Arial; background: #f4f6f9; }
.header { background: #1e3a8a; color: #fff; padding: 15px 30px; font-size: 20px; font-weight: bold; }
.container { padding: 30px; }
.cards { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
.card { background: #fff; padding: 20px; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
.card h2 { margin: 0; font-size: 22px; color: #333; }
.card p { margin-top: 10px; font-size: 18px; color: #0d6efd; }
.menu { margin-top: 30px; display:flex; gap:15px; flex-wrap:wrap; }
.menu a { display: inline-block; padding: 10px 20px; background: #1e3a8a; color: #fff; border-radius: 10px; text-decoration: none; }
.menu a:hover { opacity: 0.9; }
</style>
</head>
<body>
<div class="header" style="display: flex; justify-content: space-between; align-items: center;">
    <span>Admin Dashboard</span>
    <a href="${pageContext.request.contextPath}/auth?action=logout" style="color: #fff; text-decoration: none; font-size: 16px; background: #dc3545; padding: 5px 15px; border-radius: 5px;">Đăng xuất</a>
</div>
<div class="container">
    <div class="cards">
        <div class="card"><h2>Tổng phim</h2><p>${totalMovies}</p></div>
        <div class="card"><h2>Tổng suất chiếu</h2><p>${totalShowtimes}</p></div>
        <div class="card"><h2>Tổng vé bán</h2><p>${totalBookings}</p></div>
        <div class="card"><h2>Doanh thu</h2><p>${totalRevenue} VNĐ</p></div>
    </div>
    <div class="menu">
        <a href="${pageContext.request.contextPath}/adminmovie?action=add">Thêm phim</a>
        <a href="${pageContext.request.contextPath}/adminmovie">Quản lý phim</a>
        <a href="${pageContext.request.contextPath}/adminshowtime">Quản lý suất chiếu</a>
        <a href="${pageContext.request.contextPath}/adminbooking">Quản lý vé</a>
        <a href="${pageContext.request.contextPath}/adminuser">Quản lý người dùng</a>
    </div>
</div>
</body>
</html>
