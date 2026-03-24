<%-- 
    Document   : banner
    Created on : Mar 23, 2026, 3:19:06 PM
    Author     : DELL
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banner</title>

    <style>
        body {
            margin: 0;
            background: #0b1a31; /* nền giống web rạp */
        }

        /* ===== BANNER ===== */
        .banner-container {
            position: relative;
            width: 100%;
            height: 280px;
            overflow: hidden;
            background: #000;
        }

        .banner-wrapper {
            display: flex;
            height: 100%;
            transition: transform 0.6s ease-in-out;
        }

        .slide {
            min-width: 100%;
            height: 100%;
        }

        .slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
            display: block;
        }

        /* ===== NÚT ĐIỀU HƯỚNG ===== */
        .nav-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(0,0,0,0.4);
            color: white;
            border: none;
            padding: 15px 10px;
            cursor: pointer;
            z-index: 10;
            font-size: 20px;
            transition: 0.3s;
        }

        .nav-btn:hover {
            background: rgba(0,0,0,0.7);
        }

        .prev { left: 0; }
        .next { right: 0; }

        /* ===== OVERLAY MỜ ===== */
        .banner-container::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 40%;
            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
        }
    </style>
</head>

<body>

    <!-- ===== BANNER ===== -->
    <div class="banner-container">

        <div class="banner-wrapper" id="slider">
            <div class="slide">
                <img src="https://cdn2.fptshop.com.vn/unsafe/Uploads/images/tin-tuc/167892/Originals/phim-doraemon-tap-dai%20(2).jpg" alt="Banner 1">
            </div>
            <div class="slide">
                <img src="https://media.vov.vn/sites/default/files/styles/large/public/2022-05/still_4.jpg" alt="Banner 2">
            </div>
        </div>

        <button class="nav-btn prev" onclick="moveSlide(-1)">&#10094;</button>
        <button class="nav-btn next" onclick="moveSlide(1)">&#10095;</button>
    </div>

    <!-- ===== SCRIPT ===== -->
    <script>
        let currentPos = 0;
        const slider = document.getElementById('slider');
        const totalItems = document.querySelectorAll('.slide').length;

        function moveSlide(step) {
            currentPos += step;

            if (currentPos >= totalItems) {
                currentPos = 0;
            } else if (currentPos < 0) {
                currentPos = totalItems - 1;
            }

            const distance = -currentPos * 100;
            slider.style.transform = `translateX(${distance}%)`;
        }

        // Auto chạy
        let autoSlide = setInterval(() => moveSlide(1), 4000);

        // Pause khi hover
        const banner = document.querySelector('.banner-container');

        banner.addEventListener('mouseenter', () => {
            clearInterval(autoSlide);
        });

        banner.addEventListener('mouseleave', () => {
            autoSlide = setInterval(() => moveSlide(1), 4000);
        });
    </script>

</body>
</html>