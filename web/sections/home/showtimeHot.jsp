<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, entity.Showtime, entity.Movie" %>
<%
    List<Showtime> list = (List<Showtime>) request.getAttribute("hotShowtimes");
%>

<style>
.hot-list {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 25px;
}
.hot-card {
    background: #111;
    color: #fff;
    padding: 15px;
    border-radius: 12px;
}
.hot-time {
    font-size: 22px;
    font-weight: bold;
    color: #3b82f6;
}
.hot-movie {
    margin-top: 10px;
    font-weight: bold;
}
.hot-btn {
    margin-top: 10px;
    padding: 6px 12px;
    background: #fff;
    color: #1e3a8a;
    border-radius: 8px;
    cursor: pointer;
    display: inline-block;
}
</style>

<div class="hot-list">

<% if (list != null) {
    for (Showtime s : list) { %>

    <div class="hot-card">

        <!-- TIME -->
        <div class="hot-time">
            <%= s.getStartTime() %>
        </div>

        <!-- MOVIE ID (tạm, lát join movie) -->
        <div class="hot-movie">
            Movie ID: <%= s.getMovieId() %>
        </div>

        <!-- BUTTON -->
        <a href="${pageContext.request.contextPath}/booking?showtimeId=<%= s.getShowtimeId() %>">
            <div class="hot-btn">Đặt vé</div>
        </a>

    </div>

<%  }
} %>

</div>