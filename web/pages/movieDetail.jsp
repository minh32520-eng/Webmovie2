<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Movie, java.util.List, entity.Showtime"%>

<%
    Movie m = (Movie) request.getAttribute("movie");
    List<Showtime> showtimes = (List<Showtime>) request.getAttribute("showtimes");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết phim</title>

<style>
.container {
    max-width: 1100px;
    margin: 40px auto;
    display: flex;
    gap: 30px;
    font-family: Arial;
}
.poster img {
    width: 300px;
    border-radius: 15px;
}
.info {
    flex: 1;
}
.title {
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 10px;
}
.meta {
    color: #666;
    margin-bottom: 10px;
}
.desc {
    margin-top: 15px;
    line-height: 1.6;
}

/* SHOWTIME */
.showtime {
    margin-top: 25px;
}
.time-btn {
    display: inline-block;
    margin: 5px;
    padding: 10px 15px;
    background: #0d6efd;
    color: white;
    border-radius: 8px;
    text-decoration: none;
    transition: 0.2s;
}
.time-btn:hover {
    background: #0b5ed7;
}
</style>

</head>
<body>

<jsp:include page="/components/header.jsp" />

<div class="container">

<% if (m != null) { %>

    <!-- POSTER -->
    <div class="poster">
        <img src="<%= m.getPoster() %>">
    </div>

    <!-- INFO -->
    <div class="info">

        <div class="title"><%= m.getTitle() %></div>

        <div class="meta">
            🎬 <%= m.getGenre() %> |
            ⏱ <%= m.getDuration() %> phút |
            🌐 <%= m.getLanguage() %>
        </div>

        <div class="meta">
            🎭 Diễn viên: <%= m.getCastList() %>
        </div>

        <div class="meta">
            🎥 Đạo diễn: <%= m.getDirector() %>
        </div>

        <div class="meta">
            ⭐ Rating: <%= m.getRating() %>
        </div>

        <div class="desc">
            <%= m.getDescription() %>
        </div>

        <!-- 🔥 SHOWTIME -->
        <div class="showtime">
            <h3>🎬 Suất chiếu</h3>

            <% if (showtimes != null && !showtimes.isEmpty()) {
                for (Showtime s : showtimes) { %>

                <a class="time-btn"
                   href="${pageContext.request.contextPath}/booking?showtimeId=<%= s.getShowtimeId() %>">
                   <%= new java.text.SimpleDateFormat("HH:mm").format(s.getStartTime()) %>
                </a>

            <% }
            } else { %>
                <p>Chưa có suất chiếu</p>
            <% } %>
        </div>

    </div>

<% } else { %>
    <h2>Không tìm thấy phim</h2>
<% } %>

</div>

<jsp:include page="/components/footer.jsp" />

</body>
</html>