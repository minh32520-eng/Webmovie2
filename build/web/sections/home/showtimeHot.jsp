<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
body {
    font-family: Arial;
}

/* CONTAINER */
.movie-list {
    display: flex;
    gap: 30px;
    flex-wrap: wrap;
    background: #ffffff; /* nền trắng */
}

/* CARD */
.movie-card {
    width: 250px;
    background: #fff;
    padding: 10px;
    border-radius: 15px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
    transition: 0.3s;
}

.movie-card:hover {
    transform: translateY(-5px);
}

/* POSTER */
.poster {
    width: 100%;
    height: 340px;
    border-radius: 20px;
    overflow: hidden;
    position: relative;
}

.poster img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* TAG (T16, T18...) */
.tag {
    position: absolute;
    top: 10px;
    left: 10px;
    background: #f4c542;
    color: #fff;
    padding: 5px 10px;
    border-radius: 8px;
    font-weight: bold;
    font-size: 12px;
}

/* TITLE */
.movie-title {
    font-size: 18px;
    font-weight: bold;
    color: #1e3a8a;
    margin: 10px 0 5px;
}

/* INFO */
.movie-info {
    font-size: 14px;
    color: #555;
    margin-bottom: 3px;
}

/* BUTTON */
.btn-buy {
    margin-top: 15px;
    width: 100%;
    background: #2a3f8f;
    color: white;
    padding: 12px;
    border: none;
    border-radius: 10px;
    font-weight: bold;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
}

.btn-buy:hover {
    background: #1e2f6f;
}
</style>

<div class="movie-list">

    <!-- MOVIE 1 -->
    <div class="movie-card">
        <div class="poster">
            <img src="https://via.placeholder.com/300x450">
            <div class="tag">T16</div>
        </div>

        <div class="movie-title">
            Hẹn Em Ngày Nhật Thức
        </div>

        <div class="movie-info">
            Thể loại: Tâm lý, Gia đình
        </div>

        <div class="movie-info">
            Thời lượng: 118 phút
        </div>

        <button class="btn-buy"
                onclick="openModal('Beta','23/03','20:00')">
            🎟️ MUA VÉ
        </button>
    </div>

    <!-- MOVIE 2 -->
    <div class="movie-card">
        <div class="poster">
            <img src="https://via.placeholder.com/300x450">
            <div class="tag">T18</div>
        </div>

        <div class="movie-title">
            Quỷ Nhập Tràng 2
        </div>

        <div class="movie-info">
            Thể loại: Kinh dị, Hồi hộp
        </div>

        <div class="movie-info">
            Thời lượng: 127 phút
        </div>

        <button class="btn-buy"
                onclick="openModal('Beta','23/03','21:30')">
            🎟️ MUA VÉ
        </button>
    </div>

</div>