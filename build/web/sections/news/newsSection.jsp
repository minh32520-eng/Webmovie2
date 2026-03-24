<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
.news-container {
    background: #fff;
    padding: 30px;
    border-radius: 10px;
}

/* TITLE */
.news-title {
    font-size: 22px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 20px;
}

/* LIST */
.news-list {
    display: flex;
    gap: 20px;
}

/* CARD */
.news-card {
    width: 30%;
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: 0.3s;
    cursor: pointer;
}

.news-card:hover {
    transform: translateY(-5px);
}

/* IMAGE */
.news-card img {
    width: 100%;
    height: 160px;
    object-fit: cover;
}

/* CONTENT */
.news-content {
    padding: 10px;
}

.news-text {
    font-size: 14px;
    font-weight: bold;
}
</style>

<div class="news-container">

    <div class="news-title">TIN TỨC & ƯU ĐÃI</div>

    <div class="news-list">

        <!-- CARD 1 -->
        <div class="news-card">
            <img src="https://www.betacinemas.vn/Assets/Common/movie/noimage.jpg">
            <div class="news-content">
                <div class="news-text">Phim mới tháng 4</div>
            </div>
        </div>

        <!-- CARD 2 -->
        <div class="news-card">
            <img src="https://www.betacinemas.vn/Assets/Common/movie/noimage.jpg">
            <div class="news-content">
                <div class="news-text">Khuyến mãi mùa hè</div>
            </div>
        </div>

        <!-- CARD 3 -->
        <div class="news-card">
            <img src="https://www.betacinemas.vn/Assets/Common/movie/noimage.jpg">
            <div class="news-content">
                <div class="news-text">Review phim hot</div>
            </div>
        </div>

    </div>

</div>