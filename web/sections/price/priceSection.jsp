<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, entity.Showtime" %>

<%
    List<Showtime> list = (List<Showtime>) request.getAttribute("prices");
%>

<style>
.price-container {
    max-width: 1000px;
    margin: 40px auto;
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.08);
}

.title {
    font-size: 24px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 20px;
}

/* TABLE */
table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background: #0d6efd;
    color: #fff;
    padding: 10px;
}

td {
    padding: 10px;
    border-bottom: 1px solid #eee;
    text-align: center;
}

tr:hover {
    background: #f5f7fb;
}

.empty {
    text-align: center;
    color: #888;
}
</style>

<div class="price-container">

    <div class="title">BẢNG GIÁ VÉ</div>

    <table>
        <tr>
            <th>Phim</th>
            <th>Giờ chiếu</th>
            <th>Thường</th>
            <th>VIP</th>
            <th>Couple</th>
        </tr>

        <% if (list != null && !list.isEmpty()) {
            for (Showtime s : list) { %>

            <tr>
                <td><%= s.getMovieTitle() %></td>
                <td><%= new java.text.SimpleDateFormat("HH:mm").format(s.getStartTime()) %></td>
                <td><%= s.getPriceStd() %>đ</td>
                <td><%= s.getPriceVip() %>đ</td>
                <td><%= s.getPriceCouple() %>đ</td>
            </tr>

        <% }} else { %>
            <tr>
                <td colspan="5" class="empty">Không có dữ liệu</td>
            </tr>
        <% } %>

    </table>

</div>