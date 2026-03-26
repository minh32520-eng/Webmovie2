<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, entity.Cinema" %>
<%
    entity.User u = (entity.User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    List<Cinema> cinemas = (List<Cinema>) request.getAttribute("cinemas");
%>
<style>
    .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 5%;
        background: #fff;
        border-bottom: 2px solid #0d6efd;
        font-family: 'Segoe UI', sans-serif;
    }

    /* LEFT */
    .left {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    /* LOGO */
    .logo img {
        height: 80px;
    }

    /* CINEMA SELECT */
    .cinema-select {
        position: relative;
    }

    .cinema-btn {
        padding: 6px 14px;
        border: 1px solid #ccc;
        border-radius: 20px;
        background: #f8f9fa;
        cursor: pointer;
        font-size: 13px;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .cinema-list {
        display: none;
        position: absolute;
        top: 40px;
        left: 0;
        width: 220px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        overflow: hidden;
        z-index: 999;
    }

    .cinema-list a {
        display: block;
        padding: 10px;
        font-size: 13px;
        color: #333;
        text-decoration: none;
    }

    .cinema-list a:hover {
        background: #eef3ff;
        color: #0d6efd;
    }

    /* ACTIVE */
    .cinema-select.active .cinema-list {
        display: block;
    }

    /* MENU */
    .menu {

        justify-content: space-between;
        display: flex;
        list-style: none;
        gap: 25px;
        margin: 0;
        padding: 0;
    }

    .menu a {
        justify-content: space-between;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        color: #333;
    }

    .menu a:hover {
        color: #0d6efd;
    }

    /* RIGHT */
    .user-box {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .username {
        font-size: 14px;
        font-weight: 600;
        color: #333;
    }

    /* BUTTON */
    .login-btn {
        padding: 6px 18px;
        background: linear-gradient(45deg, #0d6efd, #00c6ff);
        color: #fff;
        border-radius: 20px;
        border: none;
        cursor: pointer;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
    }

    .login-btn:hover {
        opacity: 0.9;
    }

    .logout-btn {
        padding: 6px 18px;
        background: #dc3545;
        color: #fff;
        border-radius: 20px;
        border: none;
        cursor: pointer;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
    }

    .logout-btn:hover {
        opacity: 0.9;
    }

    /* ===== ACCOUNT DROPDOWN ===== */
    .account-box {
        position: relative;
    }

    .account-btn {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 6px 14px;
        background: linear-gradient(135deg, #1e3a8a, #2563eb);
        color: #fff;
        border-radius: 22px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        border: none;
        transition: 0.2s;
        user-select: none;
    }

    .account-btn:hover { opacity: 0.9; }

    .account-dropdown {
        display: none;
        position: absolute;
        top: 42px;
        right: 0;
        min-width: 200px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        overflow: hidden;
        z-index: 1000;
        border: 1px solid #e5e7eb;
    }

    .account-box.active .account-dropdown {
        display: block;
    }

    .dropdown-header {
        padding: 14px 16px;
        background: linear-gradient(135deg, #1e3a8a, #2563eb);
        color: #fff;
        font-size: 13px;
        font-weight: 600;
    }

    .dropdown-item {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 12px 16px;
        font-size: 13px;
        color: #374151;
        text-decoration: none;
        transition: 0.15s;
    }

    .dropdown-item:hover {
        background: #f0f7ff;
        color: #1d4ed8;
    }

    .dropdown-divider {
        height: 1px;
        background: #f3f4f6;
        margin: 0;
    }

    .dropdown-item.logout {
        color: #dc2626;
    }

    .dropdown-item.logout:hover {
        background: #fff5f5;
        color: #dc2626;
    }
    
</style>

<header class="header">

    <div class="left">
        <!-- LOGO -->
        <div class="logo">
            <a href="${pageContext.request.contextPath}/home">
                <img src="https://www.shutterstock.com/image-vector/film-chicken-movie-video-logo-260nw-2684687891.jpg" alt="Logo">
            </a>
        </div>

        <!-- CHỌN RẠP -->
        <div class="cinema-select" id="cinemaBox">
            <div class="cinema-btn" onclick="toggleCinema()">
                <%= request.getAttribute("selectedCinemaName") != null
                        ? request.getAttribute("selectedCinemaName")
                        : "Chọn rạp" %>
            </div>

            <div class="cinema-list">
                <% if (cinemas != null && !cinemas.isEmpty()) {
                    for (Cinema c : cinemas) { %>
                <a href="<%= request.getContextPath() %>/showtime?cinemaId=<%= c.getCinemaId() %>">
                    <%= c.getName() %>
                </a>
                <%  }
                } else { %>
                <a href="#">Không có rạp</a>
                <% } %>
            </div>
        </div>


    </div>
            
            <div class="menu">     
    <!-- MENU -->
    <ul class="menu">
        <li><a href="${pageContext.request.contextPath}/showtime">Lịch chiếu</a></li>
        <li><a href="${pageContext.request.contextPath}/home">Phim</a></li>
        <li><a href="${pageContext.request.contextPath}/cinema">Rạp</a></li>
        <li><a href="${pageContext.request.contextPath}/price">Giá vé</a></li>
        <li><a href="${pageContext.request.contextPath}/news">Tin tức</a></li>
    </ul>
            </div>
    
    
    <div class="user-box">
        <% if (u == null) { %>
        <a href="${pageContext.request.contextPath}/pages/login.jsp" class="login-btn">
            Đăng nhập
        </a>
        <% } else { %>
        <!-- ACCOUNT DROPDOWN -->
        <div class="account-box" id="accountBox">
            <div class="account-btn" onclick="toggleAccount()">
                👤 <%= u.getUsername() %> ▾
            </div>
            <div class="account-dropdown">
                <div class="dropdown-header">👤 <%= u.getUsername() %></div>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/history">
                    🎟 Lịch sử đặt vé
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item logout"
                   href="${pageContext.request.contextPath}/auth?action=logout">
                    🚪 Đăng xuất
                </a>
            </div>
        </div>
        <% } %>
    </div>

</header>

<script>
    function toggleCinema() {
        document.getElementById("cinemaBox").classList.toggle("active");
        document.getElementById("accountBox") && document.getElementById("accountBox").classList.remove("active");
    }

    function toggleAccount() {
        document.getElementById("accountBox").classList.toggle("active");
        document.getElementById("cinemaBox").classList.remove("active");
    }

    document.addEventListener("click", function (e) {
        const cinemaBox = document.getElementById("cinemaBox");
        if (cinemaBox && !cinemaBox.contains(e.target)) {
            cinemaBox.classList.remove("active");
        }
        const accountBox = document.getElementById("accountBox");
        if (accountBox && !accountBox.contains(e.target)) {
            accountBox.classList.remove("active");
        }
    });
</script>