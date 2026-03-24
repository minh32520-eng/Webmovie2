<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
.promo-container {
    background: #fff;
    padding: 30px;
    border-radius: 10px;
}

/* TITLE */
.promo-title {
    font-size: 22px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 20px;
}

/* LAYOUT */
.promo-content {
    display: flex;
    gap: 30px;
}

/* LEFT */
.promo-left {
    width: 50%;
}

.promo-item {
    display: flex;
    gap: 15px;
    margin-bottom: 20px;
    background: #f5f7fb;
    padding: 10px;
    border-radius: 10px;
}

.promo-item img {
    width: 120px;
    height: 80px;
    border-radius: 10px;
    object-fit: cover;
}

.promo-info {
    font-size: 14px;
}

.promo-info h4 {
    margin: 0;
    color: #1e3a8a;
}

.promo-info p {
    margin: 5px 0 0;
    color: #555;
}

/* RIGHT */
.promo-right {
    width: 50%;
}

.promo-big {
    position: relative;
}

.promo-big img {
    width: 100%;
    border-radius: 15px;
}

.promo-big-text {
    position: absolute;
    bottom: 10px;
    left: 15px;
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    background: rgba(0,0,0,0.5);
    padding: 5px 10px;
    border-radius: 5px;
}
</style>

<div class="promo-container">

    <div class="promo-title">ƯU ĐÃI & KHUYẾN MÃI</div>

    <div class="promo-content">

        <!-- LEFT: LIST KHUYẾN MÃI -->
        <div class="promo-left">

            <div class="promo-item">
                <img src="https://www.betacinemas.vn/Assets/Common/banner/khuyenmai1.jpg">
                <div class="promo-info">
                    <h4>Giảm 20% vé</h4>
                    <p>Áp dụng cho tất cả suất chiếu từ thứ 2 đến thứ 5.</p>
                </div>
            </div>

            <div class="promo-item">
                <img src="https://www.betacinemas.vn/Assets/Common/banner/khuyenmai2.jpg">
                <div class="promo-info">
                    <h4>Combo bắp nước</h4>
                    <p>Mua combo chỉ từ 49K - tiết kiệm hơn 30%.</p>
                </div>
            </div>

            <div class="promo-item">
                <img src="https://www.betacinemas.vn/Assets/Common/banner/khuyenmai3.jpg">
                <div class="promo-info">
                    <h4>Thành viên VIP</h4>
                    <p>Tích điểm đổi vé miễn phí và nhiều ưu đãi hấp dẫn.</p>
                </div>
            </div>

        </div>

        <!-- RIGHT: BANNER LỚN -->
        <div class="promo-right">
            <div class="promo-big">
                <img src="https://www.betacinemas.vn/Assets/Common/banner/khuyenmai4.jpg">
                <div class="promo-big-text">
                    Ưu đãi mùa hè cực sốc 🔥
                </div>
            </div>
        </div>

    </div>

</div>