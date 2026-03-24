<%-- 
    Document   : moviecoming
    Created on : Mar 23, 2026, 2:44:13 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
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

.showtimes {
    display: flex;
    gap: 10px;
    margin-top: 10px;
}

.showtimebtn {
    background: #fff;
    color: #1e3a8a;
    padding: 6px 12px;
    border-radius: 8px;
    font-size: 12px;
    cursor: pointer;
}
</style>

<div class="sectiontitle">
    PHIM SẮP CHIẾU
</div>

<div class="moviegrid">

    <!-- Movie 1 -->
    <div class="moviecard">
        <span class="movietag">T13</span>
        <img src="https://via.placeholder.com/300x400">

        <div style="padding: 10px;">
            <div class="movietitle">Đêm Ngày Xa Mẹ</div>
            <div class="moviedesc">Gia đình • 109 phút</div>

            <div class="showtimes">
                <div class="showtimebtn">17:15</div>
                <div class="showtimebtn">18:45</div>
                <div class="showtimebtn">20:00</div>
            </div>
        </div>
    </div>

    <!-- Movie 2 -->
    <div class="moviecard">
        <span class="movietag" style="background: green;">K</span>
        <img src="https://via.placeholder.com/300x400">

        <div style="padding: 10px;">
            <div class="movietitle">Kỳ Diệu</div>
            <div class="moviedesc">Hoạt hình • 95 phút</div>

            <div class="showtimes">
                <div class="showtimebtn">21:30</div>
            </div>
        </div>
    </div>

</div>
    </body>
</html>
