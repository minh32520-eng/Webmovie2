<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entity.User"%>
<%
    List<User> users = (List<User>) request.getAttribute("users");
    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý người dùng</title>
<style>
body{font-family:Arial;background:#f1f5f9;margin:0}
.container{width:95%;margin:30px auto}
.topbar{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px}
.titlemain{font-size:26px;color:#1e3a8a;font-weight:bold}
.btn{padding:9px 16px;background:#1e3a8a;color:#fff;border:none;border-radius:8px;text-decoration:none;cursor:pointer}
.btn-secondary{background:#475569}
.btn-danger{background:#dc2626}
.btn-success{background:#15803d}
.tablemain{width:100%;border-collapse:collapse;background:#fff;box-shadow:0 4px 12px rgba(0,0,0,.08)}
.tablemain th{background:#1e3a8a;color:#fff;padding:12px}
.tablemain td{padding:10px;text-align:center;border-bottom:1px solid #e5e7eb}
.tablemain tr:nth-child(even){background:#f8fafc}
.badge{display:inline-block;padding:6px 10px;border-radius:999px;font-size:13px;font-weight:bold}
.active{background:#dcfce7;color:#166534}
.banned{background:#fee2e2;color:#991b1b}
.role-admin{background:#dbeafe;color:#1d4ed8}
.role-user{background:#ede9fe;color:#6d28d9}
.action-box{display:flex;gap:8px;justify-content:center}
</style>
</head>
<body>
<div class="container">
    <div class="topbar">
        <div class="titlemain">Quản lý người dùng</div>
        <div>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin">Dashboard</a>
        </div>
    </div>

    <table class="tablemain">
        <tr>
            <th>ID</th>
            <th>Tên đăng nhập</th>
            <th>Email</th>
            <th>Số điện thoại</th>
            <th>Vai trò</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
        <% if (users != null) for (User u : users) { %>
        <tr>
            <td><%= u.getUserId() %></td>
            <td><%= u.getUsername() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getPhone() != null ? u.getPhone() : "" %></td>
            <td>
                <span class="badge <%= "admin".equals(u.getRole()) ? "role-admin" : "role-user" %>">
                    <%= u.getRole() %>
                </span>
            </td>
            <td>
                <span class="badge <%= u.isActive() ? "active" : "banned" %>">
                    <%= u.isActive() ? "Đang hoạt động" : "Đã bị khóa" %>
                </span>
            </td>
            <td>
                <div class="action-box">
                    <% if (currentUser != null && currentUser.getUserId() == u.getUserId()) { %>
                        <span>Admin hiện tại</span>
                    <% } else if (u.isActive()) { %>
                        <a class="btn btn-danger" onclick="return confirm('Bạn muốn khóa tài khoản này?')" href="${pageContext.request.contextPath}/adminuser?action=ban&id=<%= u.getUserId() %>">Ban</a>
                    <% } else { %>
                        <a class="btn btn-success" onclick="return confirm('Bạn muốn mở khóa tài khoản này?')" href="${pageContext.request.contextPath}/adminuser?action=unban&id=<%= u.getUserId() %>">Unban</a>
                    <% } %>
                </div>
            </td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
