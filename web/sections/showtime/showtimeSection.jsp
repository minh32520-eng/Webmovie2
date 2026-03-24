<%@ page contentType="text/html;charset=UTF-8" %>

<style>
.showtime-container {
    background: #fff;
    padding: 20px;
    border-radius: 10px;
}

/* TITLE */
.showtime-title {
    font-size: 22px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 20px;
}

/* MOVIE ITEM */
.movie-item {
    display: flex;
    gap: 20px;
    border-bottom: 1px solid #ddd;
    padding: 20px 0;
}

/* POSTER */
.movie-poster img {
    width: 120px;
    border-radius: 10px;
}

/* INFO */
.movie-info {
    flex: 1;
}

.movie-name {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
}

/* TIME BUTTONS */
.showtime-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}

.showtime-btn {
    padding: 8px 14px;
    border: 1px solid #1e3a8a;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    background: #fff;
    color: #1e3a8a;
    transition: 0.3s;
}

.showtime-btn:hover {
    background: #1e3a8a;
    color: #fff;
}
</style>

<div class="showtime-container">

    <div class="showtime-title">
        LỊCH CHIẾU THEO RẠP
    </div>

    <!-- MOVIE 1 -->
    <div class="movie-item">
        <div class="movie-poster">
            <img src="https://www.betacinemas.vn/Assets/Common/movie/noimage.jpg">
        </div>

        <div class="movie-info">
            <div class="movie-name">Avengers: Endgame</div>

            <div class="showtime-list">
                <div class="showtime-btn">09:00</div>
                <div class="showtime-btn">11:30</div>
                <div class="showtime-btn">14:00</div>
                <div class="showtime-btn">18:30</div>
            </div>
        </div>
    </div>

    <!-- MOVIE 2 -->
    <div class="movie-item">
        <div class="movie-poster">
            <img src="https://www.betacinemas.vn/Assets/Common/movie/noimage.jpg">
        </div>

        <div class="movie-info">
            <div class="movie-name">Nhà Bà Nữ</div>

            <div class="showtime-list">
                <div class="showtime-btn">10:00</div>
                <div class="showtime-btn">13:00</div>
                <div class="showtime-btn">16:00</div>
                <div class="showtime-btn">20:00</div>
            </div>
        </div>
    </div>

</div>