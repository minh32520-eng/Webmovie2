<%-- 
    Document   : moviecoming
    Created on : Mar 23, 2026, 2:44:13 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.List, entity.Movie" %>
<%
    List<Movie> movies = (List<Movie>) request.getAttribute("comingMovies");
%>

<style>
.sectiontitle {
    font-size: 26px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #1e3a8a;
}
.moviegrid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
}
.moviecard {
    position: relative;
    border-radius: 15px;
    overflow: hidden;
    background: #000;
    color: #fff;
}
.moviecard img {
    width: 100%;
    height: 300px;
    object-fit: cover;
}
.movietag {
    position: absolute;
    top: 10px;
    left: 10px;
    background: #3b82f6;
    padding: 3px 8px;
    border-radius: 6px;
    font-size: 12px;
}
.movietitle {
    font-size: 18px;
    font-weight: bold;
    margin: 10px 0 5px;
}
.moviedesc {
    font-size: 13px;
    color: #ccc;
}
</style>

<div class="sectiontitle">
    PHIM SẮP CHIẾU
</div>

<div class="moviegrid">
<% if (movies != null) {
    for (Movie m : movies) { %>

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

            <!-- click sang showtime -->
            <div style="margin-top:10px;">
                <a href="${pageContext.request.contextPath}/showtime?movieId=<%= m.getMovieId() %>">
                    <button class="showtimebtn">Xem lịch chiếu</button>
                </a>
            </div>
        </div>
    </div>

<%  }
} %>
</div>