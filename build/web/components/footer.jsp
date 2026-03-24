<%-- 
    Document   : footer
    Created on : Mar 22, 2026, 10:51:05 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
     <style>
    .footer {
        background: #222;
        color: #bbb;
        padding: 40px 5%;
        font-family: Arial, sans-serif;
        margin-top: 50px;
    }
    .footer-content {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 20px;
    }
    .footer-column { flex: 1; min-width: 200px; }
    .footer-column h4 { color: #fff; text-transform: uppercase; margin-bottom: 15px; }
    .footer-column p { font-size: 13px; line-height: 1.6; }
    .footer-bottom {
        text-align: center;
        padding-top: 20px;
        border-top: 1px solid #444;
        margin-top: 20px;
        font-size: 12px;
    }
</style>

<footer class="footer">
    <div class="footer-content">
        <div class="footer-column">
            <h4>Giới thiệu</h4>
            <p>Beta Cinemas - Hệ thống rạp chiếu phim giá rẻ, hiện đại hàng đầu Việt Nam.</p>
        </div>
        <div class="footer-column">
            <h4>Liên hệ</h4>
            <p>Email: contact@betacinemas.vn</p>
            <p>Hotline: 1900 636 707</p>
        </div>
        <div class="footer-column">
            <h4>Chính sách</h4>
            <p>Chính sách bảo mật</p>
            <p>Điều khoản sử dụng</p>
        </div>
    </div>
    <div class="footer-bottom">
        &copy; 2026 Beta Cinemas. All rights reserved.
    </div>
</footer>
    </body>
</html>
