<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
.cinema-container {
    background: #fff;
    padding: 30px;
    border-radius: 10px;
}

/* TITLE */
.title {
    font-size: 22px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 20px;
}

/* LAYOUT */
.cinema-content {
    display: flex;
    gap: 30px;
}

/* LEFT */
.cinema-left {
    width: 40%;
}

.cinema-item {
    display: flex;
    gap: 10px;
    margin-bottom: 15px;
    align-items: flex-start;
    padding: 10px;
    border-radius: 10px;
    transition: 0.3s;
    cursor: pointer;
}

.cinema-item:hover {
    background: #f5f7fb;
}

.cinema-item img {
    width: 60px;
    height: 60px;
    border-radius: 10px;
    object-fit: cover;
}

.cinema-info {
    display: flex;
    flex-direction: column;
}

.cinema-name {
    font-weight: bold;
    font-size: 14px;
}

.cinema-desc {
    font-size: 12px;
    color: #666;
}

/* RIGHT */
.cinema-right {
    width: 60%;
}

/* MOVIE HOT */
.movie-hot-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #1e3a8a;
}

.movie-list {
    display: flex;
    gap: 15px;
}

.movie-item {
    width: 120px;
    text-align: center;
    transition: 0.3s;
    cursor: pointer;
}

.movie-item:hover {
    transform: scale(1.05);
}

.movie-item img {
    width: 100%;
    border-radius: 10px;
}

.movie-name {
    font-size: 13px;
    margin-top: 5px;
}
</style>

<div class="cinema-container">
    <div class="title">HỆ THỐNG RẠP</div>

    <div class="cinema-content">

        <!-- LEFT: DANH SÁCH RẠP -->
        <div class="cinema-left">

            <div class="cinema-item">
                <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png">
                <div class="cinema-info">
                    <div class="cinema-name">CGV Hà Nội</div>
                    <div class="cinema-desc">
                        Rạp hiện đại, màn hình IMAX, âm thanh Dolby 7.1
                    </div>
                </div>
            </div>

            <div class="cinema-item">
                <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png">
                <div class="cinema-info">
                    <div class="cinema-name">Lotte Cinema</div>
                    <div class="cinema-desc">
                        Không gian sang trọng, ghế VIP cao cấp
                    </div>
                </div>
            </div>

            <div class="cinema-item">
                <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png">
                <div class="cinema-info">
                    <div class="cinema-name">Beta Cinema</div>
                    <div class="cinema-desc">
                        Giá rẻ, phù hợp sinh viên, nhiều ưu đãi
                    </div>
                </div>
            </div>

        </div>

        <!-- RIGHT: PHIM HOT -->
        <div class="cinema-right">
            <div class="movie-hot-title">PHIM ĐANG HOT</div>

            <div class="movie-list">

                <div class="movie-item">
                    <img src="https://www.betacinemas.vn/Assets/Common/movie/noimage.jpg">
                    <div class="movie-name">Avengers</div>
                </div>

                <div class="movie-item">
                    <img src="https://www.betacinemas.vn/Assets/Common/movie/noimage.jpg">
                    <div class="movie-name">Nhà Bà Nữ</div>
                </div>

                <div class="movie-item">
                    <img src="https://www.betacinemas.vn/Assets/Common/movie/noimage.jpg">
                    <div class="movie-name">Fast & Furious</div>
                </div>

                <div class="movie-item">
                    <img src="https://www.betacinemas.vn/Assets/Common/movie/noimage.jpg">
                    <div class="movie-name">Avatar</div>
                </div>

            </div>
        </div>

    </div>
</div>