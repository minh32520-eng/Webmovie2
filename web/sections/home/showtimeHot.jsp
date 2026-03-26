<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, entity.Movie" %>

<style>
/* === SUẤT CHIẾU NỔI BẬT === */
.special-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 25px;
}

.special-card {
    background: #111827;
    border-radius: 16px;
    overflow: hidden;
    cursor: pointer;
    transition: transform 0.3s, box-shadow 0.3s;
    position: relative;
}

.special-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 30px rgba(0,0,0,0.5);
}

.special-card .poster-wrap {
    position: relative;
    width: 100%;
    height: 380px;
    overflow: hidden;
}

.special-card .poster-wrap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s;
}

.special-card:hover .poster-wrap img {
    transform: scale(1.05);
}

.special-card .poster-wrap .overlay {
    position: absolute;
    bottom: 0;
    width: 100%;
    height: 55%;
    background: linear-gradient(to top, rgba(0,0,0,0.92), transparent);
}

.special-badge {
    position: absolute;
    top: 12px;
    left: 12px;
    background: #f97316;
    color: white;
    font-size: 11px;
    font-weight: bold;
    padding: 3px 10px;
    border-radius: 20px;
    letter-spacing: 0.5px;
}

.special-info {
    padding: 14px 16px;
}

.special-title {
    font-size: 15px;
    font-weight: bold;
    color: #fff;
    margin-bottom: 6px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.special-meta {
    font-size: 13px;
    color: #9ca3af;
    margin-bottom: 10px;
}

.special-rating {
    color: #facc15;
    font-size: 13px;
    font-weight: bold;
}

.special-btn {
    display: inline-block;
    margin-top: 10px;
    padding: 8px 20px;
    background: #1d4ed8;
    color: white;
    border-radius: 8px;
    font-size: 13px;
    text-decoration: none;
    transition: background 0.2s;
}

.special-btn:hover {
    background: #2563eb;
}
</style>

<%
    List<Movie> specialMovies = (List<Movie>) request.getAttribute("specialMovies");
%>

<div class="special-grid">
<% if (specialMovies != null && !specialMovies.isEmpty()) {
    for (Movie m : specialMovies) {
        String poster = m.getPoster();
        String imgSrc = (poster != null && (poster.startsWith("http://") || poster.startsWith("https://")))
                ? poster
                : request.getContextPath() + "/" + poster;
        String age = m.getAgeLimit() != null ? m.getAgeLimit() : "P";
%>

    <div class="special-card"
         onclick="window.location.href='${pageContext.request.contextPath}/moviedetail?id=<%= m.getMovieId() %>'">

        <div class="poster-wrap">
            <span class="special-badge">🎬 NỔI BẬT</span>
            <img src="<%= imgSrc %>" alt="<%= m.getTitle() %>">
            <div class="overlay"></div>
        </div>

        <div class="special-info">
            <div class="special-title"><%= m.getTitle() %></div>
            <div class="special-meta"><%= m.getGenre() %> • <%= m.getDuration() %> phút • <%= age %></div>
            <div class="special-rating">⭐ <%= m.getRating() %></div>
            <a class="special-btn"
               href="${pageContext.request.contextPath}/showtime?movieId=<%= m.getMovieId() %>">
               🎟️ Mua vé
            </a>
        </div>
    </div>

<%  }
} else { %>
    <p style="color:#9ca3af; text-align:center; grid-column: 1/-1;">Chưa có suất chiếu nổi bật</p>
<% } %>
</div>