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
            .footer-column {
                flex: 1;
                min-width: 200px;
            }
            .footer-column h4 {
                color: #fff;
                text-transform: uppercase;
                margin-bottom: 15px;
            }
            .footer-column p {
                font-size: 13px;
                line-height: 1.6;
            }
            .footer-column img {
                height: 60px;
                width: auto;
                object-fit: contain;
                margin-top: 10px;
            }
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
                    <p>Chicken Cinemas - Hệ thống rạp chiếu phim hoàng gia đi dầu Việt Nam.</p>
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
                </div>        <div class="footer-column">
                    <h4>Đối tác chiến lược</h4>
                    <p><img src="https://scontent.fhan2-5.fna.fbcdn.net/v/t39.30808-6/625515073_122099480829241879_3338881461901299918_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=1d70fc&_nc_ohc=KfHMmJD4EMcQ7kNvwHzCI2L&_nc_oc=AdreMETmAhq9f-PX3AuEuJV8oda0gWEOhNvOt8Mv-lEH60Iaj-KQ3CNgotIaCIllSSI&_nc_zt=23&_nc_ht=scontent.fhan2-5.fna&_nc_gid=uXMa0WFo81KU_C_-MzcAZQ&_nc_ss=7a32e&oh=00_AfxAvvGqByPOOoFJuiubXBlMiWa9IABYnZHyqL7wrFYs8g&oe=69CA1806" alt="Logo"> 
                        <img src="https://scontent.fhan20-1.fna.fbcdn.net/v/t39.30808-6/623791884_122103529581230948_1348844550180455052_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=1d70fc&_nc_ohc=WBrjE81qkcAQ7kNvwFRWiS9&_nc_oc=AdoyxuTuJxkSltEQFtGDHAw2IBVsjOJmASMd2YnZjYKWPKKH9ko0_BOP7ajGzWAJGLQ&_nc_zt=23&_nc_ht=scontent.fhan20-1.fna&_nc_gid=Jkzor9l7dWDMogVjidU4tQ&_nc_ss=7a3a8&oh=00_AfzmcP1ejaENDthEB4lhOHOJm9Ma02jXr82363cKKrESfw&oe=69CA01B0" alt="Logo"></p>

                </div>
            </div>
            <div class="footer-bottom">
                &copy; 2026 Beta Cinemas. All rights reserved.
            </div>
        </footer>
    </body>
</html>
