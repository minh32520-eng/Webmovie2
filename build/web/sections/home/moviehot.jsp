<%-- 
    Document   : promotion
    Created on : Mar 23, 2026, 2:45:12 PM
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
.movie-list {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 25px;
}

/* CARD */
.movie-card {
    cursor: pointer;
}

/* IMAGE */
.movie-img {
    position: relative;
    height: 380px;
    border-radius: 15px;
    overflow: hidden;
}

.movie-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: 0.4s;
}

.movie-card:hover img {
    transform: scale(1.05);
}

/* OVERLAY */
.overlay {
    position: absolute;
    bottom: 0;
    height: 60%;
    width: 100%;
    background: linear-gradient(to top, rgba(0,0,0,0.9), transparent);
}

/* TITLE */
.movie-title {
    position: absolute;
    bottom: 65px;
    left: 15px;
    color: white;
    font-weight: bold;
}

/* INFO */
.movie-info {
    position: absolute;
    bottom: 40px;
    left: 15px;
    color: #ddd;
    font-size: 13px;
}

/* TIME */
.showtime {
    position: absolute;
    bottom: 15px;
    left: 15px;
    background: #f97316;
    color: white;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 12px;
}

/* TAG */
.tag {
    position: absolute;
    top: 10px;
    left: 10px;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 12px;
    color: white;
}

.k { background: #22c55e; }
.t13 { background: #3b82f6; }
.t18 { background: #ef4444; }

/* BUTTON */
.buy-btn {
    position: absolute;
    bottom: -50px;
    right: 15px;
    background: #2f5597;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 8px;
    transition: 0.3s;
}

.movie-card:hover .buy-btn {
    bottom: 15px;
}
</style>

<div class="movie-list">

    <!-- 1 -->
    <div class="movie-card">
        <div class="movie-img">
            <span class="tag t13">T13</span>
            <img src="https://upload.wikimedia.org/wikipedia/en/3/30/Coraline_poster.jpg">
            <div class="overlay"></div>
            <div class="movie-title">Coraline</div>
            <div class="movie-info">Hoạt hình</div>
            <div class="showtime">18:00</div>
            <button class="buy-btn">🎟️ ĐẶT</button>
        </div>
    </div>

    <!-- 2 -->
    <div class="movie-card">
        <div class="movie-img">
            <span class="tag t18">T18</span>
            <img src="https://i.imgur.com/8Km9tLL.jpg">
            <div class="overlay"></div>
            <div class="movie-title">Quỷ Nhập Tràng 2</div>
            <div class="movie-info">Kinh dị</div>
            <div class="showtime">20:30</div>
            <button class="buy-btn">🎟️ ĐẶT</button>
        </div>
    </div>

    <!-- 3 -->
    <div class="movie-card">
        <div class="movie-img">
            <span class="tag k">K</span>
            <img src="https://cdn.galaxycine.vn/media/2024/12/1/muipho_1733042723076.jpg">
            <div class="overlay"></div>
            <div class="movie-title">Mùi Phở</div>
            <div class="movie-info">Hài</div>
            <div class="showtime">17:15</div>
            <button class="buy-btn">🎟️ ĐẶT</button>
        </div>
    </div>

    <!-- 4 -->
    <div class="movie-card">
        <div class="movie-img">
            <span class="tag t13">T13</span>
            <img src="https://i.imgur.com/5tj6S7Ol.jpg">
            <div class="overlay"></div>
            <div class="movie-title">Đêm Ngày Xa Mẹ</div>
            <div class="movie-info">Gia đình</div>
            <div class="showtime">19:00</div>
            <button class="buy-btn">🎟️ ĐẶT</button>
        </div>
    </div>

    <!-- 5 -->
    <div class="movie-card">
        <div class="movie-img">
            <span class="tag t18">T18</span>
            <img src="https://upload.wikimedia.org/wikipedia/en/7/7e/Smile_2022_film_poster.png">
            <div class="overlay"></div>
            <div class="movie-title">Smile</div>
            <div class="movie-info">Kinh dị</div>
            <div class="showtime">21:00</div>
            <button class="buy-btn">🎟️ ĐẶT</button>
        </div>
    </div>

    <!-- 6 -->
    <div class="movie-card">
        <div class="movie-img">
            <span class="tag k">K</span>
            <img src="https://upload.wikimedia.org/wikipedia/en/6/6a/Project_Y_poster.jpg">
            <div class="overlay"></div>
            <div class="movie-title">Project Y</div>
            <div class="movie-info">Tâm lý</div>
            <div class="showtime">16:30</div>
            <button class="buy-btn">🎟️ ĐẶT</button>
        </div>
    </div>

    <!-- 7 -->
    <div class="movie-card">
        <div class="movie-img">
            <span class="tag t13">T13</span>
            <img src="https://i.imgur.com/ZXBtVw7l.jpg">
            <div class="overlay"></div>
            <div class="movie-title">Cú Nhảy Kỳ Diệu</div>
            <div class="movie-info">Hoạt hình</div>
            <div class="showtime">15:45</div>
            <button class="buy-btn">🎟️ ĐẶT</button>
        </div>
    </div>

    <!-- 8 -->
    <div class="movie-card">
        <div class="movie-img">
            <span class="tag t18">T18</span>
            <img src="https://i.imgur.com/UYiroysl.jpg">
            <div class="overlay"></div>
            <div class="movie-title">Bus Một Chiều</div>
            <div class="movie-info">Kinh dị</div>
            <div class="showtime">22:00</div>
            <button class="buy-btn">🎟️ ĐẶT</button>
        </div>
    </div>

</div>
    </body>
</html>
