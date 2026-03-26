<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, entity.Movie" %>
<%
    List<Movie> movies = (List<Movie>) request.getAttribute("comingMovies");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Phim sắp chiếu</title>

<style>
body {
    font-family: Arial;
}

/* ===== TITLE ===== */
.sectiontitle {
    font-size: 26px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #1e3a8a;
}

/* ===== GRID ===== */
.moviegrid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
}

/* ===== LINK ===== */
.movie-link {
    text-decoration: none;
    color: inherit;
    display: block;
}

/* ===== CARD ===== */
.moviecard {
    position: relative;
    border-radius: 15px;
    overflow: hidden;
    background: #000;
    color: #fff;
    cursor: pointer;
    transition: all 0.3s ease;
}

/* hover */
.moviecard:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow: 0 12px 25px rgba(0,0,0,0.3);
}

/* click effect */
.moviecard:active {
    transform: scale(0.97);
}

/* ===== IMAGE ===== */
.moviecard img {
    width: 100%;
    height: 300px;
    object-fit: cover;
    transition: transform 0.4s ease;
}

/* zoom ảnh */
.moviecard:hover img {
    transform: scale(1.08);
}

/* gradient */
.moviecard::after {
    content: "";
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 55%;
    background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
}

/* ===== TAG ===== */
.movietag {
    position: absolute;
    top: 10px;
    left: 10px;
    background: #3b82f6;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: bold;
}

/* ===== TEXT ===== */
.movietitle {
    font-size: 18px;
    font-weight: bold;
    margin: 10px 0 5px;
}

.moviedesc {
    font-size: 13px;
    color: #ccc;
}

/* ===== FADE IN ===== */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(15px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.moviecard {
    animation: fadeIn 0.5s ease forwards;
}
</style>

</head>

<body>

<div class="sectiontitle">
    PHIM SẮP CHIẾU
</div>

<div class="moviegrid">

<% if (movies != null) {
    for (Movie m : movies) { %>

    <!-- CLICK TO DETAIL -->
    <a href="${pageContext.request.contextPath}/moviedetail?id=<%= m.getMovieId() %>" class="movie-link">

        <div class="moviecard">

            <span class="movietag"><%= m.getAgeLimit() %></span>

            <img src="<%= m.getPoster() %>">

            <div style="padding: 10px;">
                <div class="movietitle">
                    <%= m.getTitle() %>
                </div>

                <div class="moviedesc">
                    <%= m.getGenre() %> • <%= m.getDuration() %> phút
                </div>
            </div>

        </div>

    </a>

<%  }
} %>

</div>

</body>
</html>