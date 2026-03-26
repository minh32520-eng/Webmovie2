<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, entity.Cinema, entity.Movie" %>

<%
    List<Cinema> cinemas = (List<Cinema>) request.getAttribute("cinemas");
    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
%>

<style>
.cinema-container {
    background: #fff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.08);
}

/* TITLE */
.title {
    font-size: 24px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 25px;
    border-left: 5px solid #1e3a8a;
    padding-left: 10px;
}

/* LAYOUT */
.cinema-content {
    display: flex;
    gap: 30px;
}

/* LEFT */
.cinema-left {
    width: 35%;
    max-height: 400px;
    overflow-y: auto;
}

.cinema-item {
    display: flex;
    gap: 12px;
    margin-bottom: 12px;
    padding: 12px;
    border-radius: 10px;
    transition: 0.25s;
    cursor: pointer;
}

.cinema-item:hover {
    background: #eef3ff;
    transform: translateX(5px);
}

.cinema-item img {
    width: 55px;
    height: 55px;
    border-radius: 10px;
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
    width: 65%;
}

/* MOVIE TITLE */
.movie-hot-title {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #1e3a8a;
}

/* MOVIE LIST */
.movie-list {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
}

/* MOVIE ITEM */
.movie-item {
    width: 130px;
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
    height: 180px;
    object-fit: cover;
}

.movie-name {
    font-size: 13px;
    margin-top: 6px;
    font-weight: 600;
}

/* EMPTY */
.empty {
    color: #888;
}
</style>

<div class="cinema-container">

    <div class="title">HỆ THỐNG RẠP</div>

    <div class="cinema-content">

        <!-- LEFT: DANH SÁCH RẠP -->
        <div class="cinema-left">

            <% if (cinemas != null && !cinemas.isEmpty()) {
                for (Cinema c : cinemas) { %>

                <div class="cinema-item"
                     onclick="location.href='<%= request.getContextPath() %>/showtime?cinemaId=<%= c.getCinemaId() %>'">

                    <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png">

                    <div>
                        <div class="cinema-name">
                            <%= c.getName() %>
                        </div>

                        <div class="cinema-desc">
                            <%= c.getAddress() %>
                        </div>
                    </div>

                </div>

            <% }} else { %>
                <p class="empty">Không có rạp</p>
            <% } %>

        </div>

        <!-- RIGHT: PHIM -->
        <div class="cinema-right">

            <div class="movie-hot-title">PHIM ĐANG CHIẾU</div>

            <div class="movie-list">

                <% if (movies != null && !movies.isEmpty()) {
                    for (Movie m : movies) { %>

                    <div class="movie-item"
                         onclick="location.href='<%= request.getContextPath() %>/showtime?movieId=<%= m.getMovieId() %>'">

                        <img src="<%= m.getPoster() %>">

                        <div class="movie-name">
                            <%= m.getTitle() %>
                        </div>

                    </div>

                <% }} else { %>
                    <p class="empty">Không có phim</p>
                <% } %>

            </div>

        </div>

    </div>

</div>