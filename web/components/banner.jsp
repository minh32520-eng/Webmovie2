<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    .banner-container {
        position: relative;
        width: 100%;
        height: 420px; /* tăng chiều cao để ảnh đỡ bị cắt */
        overflow: hidden;
        background: #000;
    }

    .banner-wrapper {
        display: flex;
        width: 100%;
        height: 100%;
        transition: transform 0.6s ease-in-out;
    }

    .slide {
        min-width: 100%;
        height: 100%;
        flex-shrink: 0;
    }

    .slide img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center center;
        display: block;
    }

    .nav-btn {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        background: rgba(0,0,0,0.45);
        color: #fff;
        border: none;
        width: 42px;
        height: 60px;
        cursor: pointer;
        z-index: 10;
        font-size: 24px;
        transition: 0.3s;
    }

    .nav-btn:hover {
        background: rgba(0,0,0,0.75);
    }

    .prev { left: 0; }
    .next { right: 0; }

    .banner-container::after {
        content: "";
        position: absolute;
        left: 0;
        bottom: 0;
        width: 100%;
        height: 35%;
        background: linear-gradient(to top, rgba(11,26,49,0.95), transparent);
        pointer-events: none;
    }

    @media (max-width: 1024px) {
        .banner-container {
            height: 320px;
        }
    }

    @media (max-width: 768px) {
        .banner-container {
            height: 240px;
        }

        .nav-btn {
            width: 36px;
            height: 50px;
            font-size: 20px;
        }
    }
</style>

<div class="banner-container">
    <div class="banner-wrapper" id="slider">
        <div class="slide">
            <img src="https://i.ytimg.com/vi/9Mxflfuwo4A/maxresdefault.jpg" alt="Banner 1">
        </div>
        <div class="slide">
            <img src="https://media.vov.vn/sites/default/files/styles/large/public/2022-05/still_4.jpg" alt="Banner 2">
        </div>
    </div>

    <button class="nav-btn prev" onclick="moveSlide(-1)">&#10094;</button>
    <button class="nav-btn next" onclick="moveSlide(1)">&#10095;</button>
</div>

<script>
    let currentPos = 0;
    const slider = document.getElementById("slider");
    const totalItems = document.querySelectorAll(".slide").length;

    function moveSlide(step) {
        currentPos += step;

        if (currentPos >= totalItems) {
            currentPos = 0;
        } else if (currentPos < 0) {
            currentPos = totalItems - 1;
        }

        slider.style.transform = "translateX(" + (-currentPos * 100) + "%)";
    }

    let autoSlide = setInterval(() => moveSlide(1), 4000);

    const banner = document.querySelector(".banner-container");

    banner.addEventListener("mouseenter", function () {
        clearInterval(autoSlide);
    });

    banner.addEventListener("mouseleave", function () {
        autoSlide = setInterval(() => moveSlide(1), 4000);
    });
</script>