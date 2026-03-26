<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
    List<String> seats = (List<String>) request.getAttribute("seats");
    Integer total = (Integer) request.getAttribute("total");

    String bookingCode = (String) request.getAttribute("bookingCode");
    String movie = (String) request.getAttribute("movie");
    String cinema = (String) request.getAttribute("cinema");
    Object time = request.getAttribute("time");

    if (seats == null) seats = new ArrayList<>();
    if (total == null) total = 0;
    if (bookingCode == null) bookingCode = "N/A";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt vé thành công</title>

<style>
body {
    margin: 0;
    font-family: Arial;
    background: linear-gradient(135deg, #1e3a8a, #3b82f6);
}
.container {
    max-width: 600px;
    margin: 60px auto;
    background: #fff;
    padding: 30px;
    border-radius: 20px;
    text-align: center;
}
.success {
    font-size: 28px;
    font-weight: bold;
    color: #16a34a;
}
.ticket {
    margin-top: 20px;
    border: 2px dashed #ccc;
    border-radius: 15px;
    padding: 20px;
    text-align: left;
}
.row {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
}
.total {
    font-size: 20px;
    font-weight: bold;
    color: red;
    text-align: right;
}
.btn {
    margin-top: 20px;
    padding: 12px 25px;
    background: #1e3a8a;
    color: #fff;
    border: none;
    border-radius: 10px;
}
</style>
</head>

<body>

<jsp:include page="/components/header.jsp" />

<div class="container">

    <div class="success">🎉 ĐẶT VÉ THÀNH CÔNG</div>

    <div class="ticket">

        <div class="row">
            <span><b>Mã vé:</b></span>
            <span><%= bookingCode %></span>
        </div>

        <div class="row">
            <span><b>Phim:</b></span>
            <span><%= movie %></span>
        </div>

        <div class="row">
            <span><b>Rạp:</b></span>
            <span><%= cinema %></span>
        </div>

        <div class="row">
            <span><b>Giờ chiếu:</b></span>
            <span><%= time %></span>
        </div>

        <div class="row">
            <span><b>Ghế:</b></span>
            <span>
                <% for (String s : seats) { %>
                    <%= s %> 
                <% } %>
            </span>
        </div>

        <div class="row total">
            Tổng tiền: <%= total %> VNĐ
        </div>

    </div>

    <a href="home">
        <button class="btn">Về trang chủ</button>
    </a>

</div>

<jsp:include page="/components/footer.jsp" />

</body>
</html>