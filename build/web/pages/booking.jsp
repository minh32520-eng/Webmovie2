<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Showtime"%>
<%
    Showtime s = (Showtime) request.getAttribute("showtime");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt vé</title>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', Arial;
    background: linear-gradient(135deg, #eef2ff, #f8fafc);
}

/* CONTAINER */
.container {
    max-width: 950px;
    margin: 50px auto;
    background: #fff;
    padding: 35px;
    border-radius: 18px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
}

/* TITLE */
.title {
    font-size: 26px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 25px;
    text-align: center;
}

/* INFO BOX */
.info {
    display: flex;
    gap: 15px;
    margin-bottom: 20px;
}

.info div {
    flex: 1;
    background: linear-gradient(135deg, #1e3a8a, #2563eb);
    color: white;
    padding: 20px;
    border-radius: 15px;
    text-align: center;
    transition: 0.3s;
}

.info div:hover {
    transform: translateY(-5px);
}

/* LABEL */
.info b {
    display: block;
    font-size: 14px;
    opacity: 0.8;
    margin-bottom: 8px;
}

/* VALUE */
.value {
    font-size: 18px;
    font-weight: bold;
}

/* PRICE */
.price-box {
    display: flex;
    justify-content: space-around;
    margin-top: 20px;
}

.price-item {
    background: #f1f5f9;
    padding: 15px;
    border-radius: 10px;
    text-align: center;
    width: 30%;
}

.price-item b {
    display: block;
    margin-bottom: 5px;
}

/* BUTTON */
.btn {
    display: block;
    margin: 30px auto 0;
    background: linear-gradient(135deg, #f59e0b, #f97316);
    color: white;
    padding: 14px 40px;
    border: none;
    border-radius: 12px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: 0.3s;
}

.btn:hover {
    transform: scale(1.05);
}

/* ERROR */
.error {
    color: red;
    text-align: center;
    margin-top: 20px;
}
</style>
</head>

<body>

<jsp:include page="/components/header.jsp" />

<div class="container">

    <div class="title">🎟 THÔNG TIN ĐẶT VÉ</div>

    <% if (s != null) { %>

    <!-- INFO -->
    <div class="info">
        <div>
            <b>Phim</b>
            <div class="value"><%= s.getMovieTitle() %></div>
        </div>

        <div>
            <b>Rạp</b>
            <div class="value"><%= s.getCinemaName() %></div>
        </div>

        <div>
            <b>Giờ</b>
            <div class="value">
                <%= new java.text.SimpleDateFormat("HH:mm")
                        .format(s.getStartTime()) %>
            </div>
        </div>
    </div>

    <!-- DATE -->
    <div class="info">
        <div>
            <b>Ngày chiếu</b>
            <div class="value">
                <%= new java.text.SimpleDateFormat("dd/MM/yyyy")
                        .format(s.getStartTime()) %>
            </div>
        </div>
    </div>

    <!-- PRICE -->
    <div class="price-box">
        <div class="price-item">
            <b>Ghế thường</b>
            <%= (int)s.getPriceStd() %> VNĐ
        </div>

        <div class="price-item">
            <b>Ghế VIP</b>
            <%= (int)s.getPriceVip() %> VNĐ
        </div>

        <div class="price-item">
            <b>Ghế đôi</b>
            <%= (int)s.getPriceCouple() %> VNĐ
        </div>
    </div>

    <% } else { %>
        <div class="error"> Không tìm thấy suất chiếu</div>
    <% } %>

    <!-- FORM -->
    <form action="seat" method="get">
        <input type="hidden" name="showtimeId"
               value="<%= (s != null ? s.getShowtimeId() : "") %>">

        <button class="btn">CHỌN GHẾ</button>
    </form>

</div>

<jsp:include page="/components/footer.jsp" />

</body>
</html>