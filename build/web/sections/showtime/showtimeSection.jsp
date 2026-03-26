<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, entity.Showtime, java.text.SimpleDateFormat" %>

<%
    List<Showtime> list = (List<Showtime>) request.getAttribute("showtimes");
    Map<Integer, List<Showtime>> map = new LinkedHashMap<>();

    if(list != null){
        for(Showtime s : list){
            map.computeIfAbsent(s.getMovieId(), k -> new ArrayList<>()).add(s);
        }
    }

    SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
%>

<html>
<head>
<title>Lịch chiếu</title>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', Arial;
    background: linear-gradient(135deg, #eef2ff, #f8fafc);
}

.container {
    max-width: 1100px;
    margin: 40px auto;
}

.showtime-container {
    background: #fff;
    padding: 30px;
    border-radius: 16px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
}

.showtime-title {
    font-size: 26px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 30px;
    border-left: 6px solid #1e3a8a;
    padding-left: 12px;
}

.movie-item {
    display: flex;
    gap: 20px;
    padding: 20px 0;
    border-bottom: 1px solid #eee;
    transition: 0.3s;
}

.movie-item:hover {
    background: #f9fbff;
    border-radius: 10px;
    padding-left: 10px;
}

.movie-poster img {
    width: 120px;
    height: 170px;
    object-fit: cover;
    border-radius: 12px;
    box-shadow: 0 5px 12px rgba(0,0,0,0.15);
    transition: 0.3s;
}

.movie-poster img:hover {
    transform: scale(1.06);
}

.movie-info {
    flex: 1;
}

.movie-name {
    font-size: 20px;
    font-weight: bold;
    color: #111827;
    margin-bottom: 6px;
}

.movie-date {
    color: #64748b;
    margin-bottom: 12px;
    font-size: 14px;
}

.showtime-list {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
}

.showtime-btn {
    padding: 10px 18px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 500;
    border: 1px solid #2563eb;
    color: #2563eb;
    background: #fff;
    transition: all 0.25s ease;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}

.showtime-btn:hover {
    background: #2563eb;
    color: #fff;
    transform: translateY(-3px);
}

.showtime-btn:active {
    transform: scale(0.95);
}

a {
    text-decoration: none;
}

.empty {
    text-align: center;
    color: #888;
    font-size: 16px;
    padding: 20px;
}
</style>

</head>

<body>

<div class="container">
<div class="showtime-container">

<div class="showtime-title">
    🎬 LỊCH CHIẾU THEO RẠP
</div>

<% if (map != null && !map.isEmpty()) {
    for (Integer movieId : map.keySet()) {
        List<Showtime> shows = map.get(movieId);
        Showtime first = shows.get(0);
%>

<div class="movie-item">

    <!-- POSTER -->
    <div class="movie-poster">
        <img src="<%= first.getPoster() != null ? first.getPoster() : "https://www.betacinemas.vn/Assets/Common/movie/noimage.jpg" %>">
    </div>

    <!-- INFO -->
    <div class="movie-info">

        <!-- TÊN PHIM -->
        <div class="movie-name">
            <%= first.getMovieTitle() %>
        </div>

        <!-- NGÀY CHIẾU -->
        <div class="movie-date">
            📅 <%= sdfDate.format(first.getStartTime()) %>
        </div>

        <!-- DANH SÁCH GIỜ -->
        <div class="showtime-list">
            <% for (Showtime s : shows) { %>
                <a href="<%= request.getContextPath() %>/booking?showtimeId=<%= s.getShowtimeId() %>">
                    <div class="showtime-btn">
                        <%= sdfTime.format(s.getStartTime()) %>
                    </div>
                </a>
            <% } %>
        </div>

    </div>

</div>

<%  }
} else { %>

<p class="empty">Không có suất chiếu</p>

<% } %>

</div>
</div>

</body>
</html>