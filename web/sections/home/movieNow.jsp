<%@ page import="java.util.List, entity.Movie" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Movie> movies = (List<Movie>) request.getAttribute("nowMovies");
%>

<style>
.movie-list {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 25px;
}
.movie-card {
    cursor: pointer;
}
.movie-img {
    position: relative;
    height: 380px;
    border-radius: 15px;
    overflow: hidden;
}
.movie-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: 0.4s;
}
.movie-card:hover img {
    transform: scale(1.05);
}
.overlay {
    position: absolute;
    bottom: 0;
    height: 60%;
    width: 100%;
    background: linear-gradient(to top, rgba(0,0,0,0.9), transparent);
}
.movie-title {
    position: absolute;
    bottom: 50px;
    left: 15px;
    color: white;
    font-weight: bold;
}
.movie-info {
    position: absolute;
    bottom: 20px;
    left: 15px;
    color: #ddd;
    font-size: 13px;
}
.tag {
    position: absolute;
    top: 10px;
    left: 10px;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 12px;
    color: white;
}
.k { background: #22c55e; }
.t13 { background: #3b82f6; }
.t18 { background: #ef4444; }

.buy-btn {
    position: absolute;
    bottom: -50px;
    left: 50%;
    transform: translateX(-50%);
    background: #2f5597;
    color: white;
    border: none;
    padding: 10px 25px;
    border-radius: 10px;
    transition: 0.3s;
}
.movie-card:hover .buy-btn {
    bottom: 15px;
}
</style>

<div class="movie-list">

<% if (movies != null && !movies.isEmpty()) {
    for (Movie m : movies) { %>

    <div class="movie-card">
        <div class="movie-img">

            <!-- TAG -->
            <span class="tag 
                <%= "K".equals(m.getAgeLimit()) ? "k" :
                    "T13".equals(m.getAgeLimit()) ? "t13" : "t18" %>">
                <%= m.getAgeLimit() %>
            </span>

            <!-- POSTER -->
            <img src="<%= m.getPoster() %>" alt="movie">

            <div class="overlay"></div>

            <!-- TITLE -->
            <div class="movie-title">
                <%= m.getTitle() %>
            </div>

            <!-- INFO -->
            <div class="movie-info">
                <%= m.getGenre() %> • <%= m.getDuration() %> phút
            </div>

            <!-- BUTTON -->
            <a href="${pageContext.request.contextPath}/showtime?movieId=<%= m.getMovieId() %>">
                <button class="buy-btn">🎟️ MUA VÉ</button>
            </a>

        </div>
    </div>

<%  }
} else { %>

    <p>Không có phim nào đang chiếu</p>

<% } %>

</div>