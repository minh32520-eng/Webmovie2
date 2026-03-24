<%@ page contentType="text/html; charset=UTF-8" %>
<style>
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 5%;
    background: #fff;
    border-bottom: 2px solid #0d6efd;
    font-family: 'Segoe UI', sans-serif;
}
.logo img {
    height: 45px;
}
.menu {
    display: flex;
    list-style: none;
    gap: 25px;
}
.menu a {
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    color: #333;
    transition: 0.3s;
}
.menu a:hover {
    color: #0d6efd;
}

/* LOGIN BUTTON */
.login-btn {
    padding: 6px 18px;
    background: linear-gradient(45deg,#0d6efd,#00c6ff);
    color: #fff;
    border-radius: 20px;
    font-size: 13px;
    cursor: pointer;
    border: none;
}

/* USER BOX */
.user-box {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 13px;
    font-weight: 600;
}

/* ROLE BADGE */
.role-badge {
    background: #0d6efd;
    color: #fff;
    padding: 2px 8px;
    border-radius: 10px;
    font-size: 11px;
}

/* ADMIN LINK */
.admin-link {
    color: #198754;
    font-weight: bold;
    text-decoration: none;
}

/* LOGOUT */
.logout-btn {
    padding: 5px 12px;
    border: none;
    background: #dc3545;
    color: #fff;
    border-radius: 10px;
    cursor: pointer;
}
</style>

<%
    entity.User u = (entity.User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
%>

<header class="header">

    <!-- LOGO -->
    <div class="logo">
        <a href="${pageContext.request.contextPath}/home">
            <img src="https://www.betacinemas.vn/Assets/Common/logo/logo.png">
        </a>
    </div>

    <!-- MENU -->
    <ul class="menu">
        <li><a href="${pageContext.request.contextPath}/showtime">Lịch chiếu</a></li>
        <li><a href="${pageContext.request.contextPath}/home">Phim</a></li>
        <li><a href="${pageContext.request.contextPath}/cinema">Rạp</a></li>
        <li><a href="${pageContext.request.contextPath}/price">Giá vé</a></li>
        <li><a href="${pageContext.request.contextPath}/news">Tin tức</a></li>
    </ul>

    <!-- LOGIN / USER -->
    <div>

        <% if (u == null) { %>

            <a href="${pageContext.request.contextPath}/pages/login.jsp">
                <button class="login-btn">Đăng nhập</button>
            </a>

        <% } else { %>

            <div class="user-box">

                <!-- username -->
                👤 <%= u.getUsername() %>

                <!-- role -->
                <span class="role-badge">
                    <%= role %>
                </span>

                <!-- admin -->
                <% if ("admin".equals(role)) { %>
                    <a class="admin-link"
                       href="${pageContext.request.contextPath}/pages/admin/dashboard.jsp">
                        Admin
                    </a>
                <% } %>

                <!-- logout -->
                <form action="${pageContext.request.contextPath}/auth" method="post">
                    <input type="hidden" name="action" value="logout"/>
                    <button class="logout-btn">Logout</button>
                </form>

            </div>

        <% } %>

    </div>

</header>