<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entity.Showtime"%>
<%@page import="entity.Movie"%>
<%@page import="entity.Room"%>
<%
    List<Showtime> showtimes = (List<Showtime>) request.getAttribute("showtimes");
    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
    Showtime editShowtime = (Showtime) request.getAttribute("editShowtime");
    String error = (String) request.getAttribute("error");
    java.text.SimpleDateFormat dtf = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý suất chiếu</title>
<style>
body{font-family:Arial;background:#f1f5f9;margin:0}
.container{width:95%;margin:30px auto}
.card{background:#fff;border-radius:12px;padding:20px;box-shadow:0 4px 12px rgba(0,0,0,.08);margin-bottom:20px}
.grid{display:grid;grid-template-columns:repeat(3,1fr);gap:12px}
.input,select{width:100%;padding:10px;border:1px solid #cbd5e1;border-radius:8px;box-sizing:border-box}
.btn{padding:10px 18px;background:#1e3a8a;color:#fff;border-radius:8px;text-decoration:none;border:none;cursor:pointer}
.btn-danger{background:#dc2626}
.btn-secondary{background:#475569}
.table{width:100%;border-collapse:collapse;background:#fff}
.table th{background:#1e3a8a;color:#fff;padding:12px}
.table td{padding:10px;text-align:center;border-bottom:1px solid #e5e7eb}
.action-box{display:flex;gap:8px;justify-content:center}

/*  ERROR BOX  */
.alert-error{
    background:#fee2e2;
    color:#b91c1c;
    border:1px solid #fecaca;
    padding:12px 16px;
    border-radius:8px;
    margin-bottom:15px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    animation:fadeIn .3s ease-in-out;
}
.alert-error button{
    background:none;
    border:none;
    font-size:16px;
    cursor:pointer;
    color:#b91c1c;
}
@keyframes fadeIn{
    from{opacity:0;transform:translateY(-5px)}
    to{opacity:1;transform:translateY(0)}
}
</style>

<script>
function closeAlert(){
    document.getElementById("errorBox").style.display="none";
}
</script>

</head>
<body>
<div class="container">

    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px">
        <h2 style="color:#1e3a8a">Quản lý suất chiếu</h2>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin">Dashboard</a>
    </div>

    <!-- ===== HIỂN THỊ LỖI ===== -->
    <% if(error != null){ %>
        <div id="errorBox" class="alert-error">
            <span><%= error %></span>
            <button onclick="closeAlert()">✖</button>
        </div>
    <% } %>

    <div class="card">
        <form action="${pageContext.request.contextPath}/adminshowtime" method="post">
            <input type="hidden" name="showtime_id" value="<%= editShowtime != null ? editShowtime.getShowtimeId() : "" %>">
            <div class="grid">
                <div><label>Phim</label><select class="input" name="movie_id"><% for(Movie m : movies){ %><option value="<%= m.getMovieId() %>" <%= editShowtime!=null && editShowtime.getMovieId()==m.getMovieId()?"selected":"" %>><%= m.getTitle() %></option><% } %></select></div>
                <div><label>Phòng</label><select class="input" name="room_id"><% for(Room r : rooms){ %><option value="<%= r.getRoomId() %>" <%= editShowtime!=null && editShowtime.getRoomId()==r.getRoomId()?"selected":"" %>><%= r.getRoomName() %></option><% } %></select></div>
                <div><label>Format</label><select class="input" name="format"><option value="2D" <%= editShowtime!=null && "2D".equals(editShowtime.getFormat())?"selected":"" %>>2D</option><option value="3D" <%= editShowtime!=null && "3D".equals(editShowtime.getFormat())?"selected":"" %>>3D</option><option value="IMAX" <%= editShowtime!=null && "IMAX".equals(editShowtime.getFormat())?"selected":"" %>>IMAX</option></select></div>
                <div><label>Bắt đầu</label><input class="input" type="datetime-local" name="start_time" value="<%= editShowtime!=null && editShowtime.getStartTime()!=null ? dtf.format(editShowtime.getStartTime()) : "" %>"></div>
                <div><label>Kết thúc</label><input class="input" type="datetime-local" name="end_time" value="<%= editShowtime!=null && editShowtime.getEndTime()!=null ? dtf.format(editShowtime.getEndTime()) : "" %>"></div>
                <div><label>Trạng thái</label><select class="input" name="status"><option value="ACTIVE">ACTIVE</option><option value="CANCELLED">CANCELLED</option><option value="FULL">FULL</option></select></div>
                <div><label>Giá STD</label><input class="input" type="number" name="price_std" value="<%= editShowtime!=null ? (long)editShowtime.getPriceStd() : 85000 %>"></div>
                <div><label>Giá VIP</label><input class="input" type="number" name="price_vip" value="<%= editShowtime!=null ? (long)editShowtime.getPriceVip() : 120000 %>"></div>
                <div><label>Giá Couple</label><input class="input" type="number" name="price_couple" value="<%= editShowtime!=null ? (long)editShowtime.getPriceCouple() : 200000 %>"></div>
            </div>
            <div style="margin-top:15px;display:flex;gap:10px">
                <button class="btn"><%= editShowtime != null ? "Cập nhật suất chiếu" : "Thêm suất chiếu" %></button>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/adminshowtime">Làm mới</a>
            </div>
        </form>
    </div>

    <table class="table">
        <tr><th>ID</th><th>Phim</th><th>Phòng</th><th>Bắt đầu</th><th>Kết thúc</th><th>Giá</th><th>Format</th><th>Trạng thái</th><th>Hành động</th></tr>
        <% if (showtimes != null) for (Showtime s : showtimes) { %>
        <tr>
            <td><%= s.getShowtimeId() %></td>
            <td><%= s.getMovieTitle() %></td>
            <td><%= s.getCinemaName() %></td>
            <td><%= s.getStartTime() %></td>
            <td><%= s.getEndTime() %></td>
            <td>STD <%= (long)s.getPriceStd() %><br>VIP <%= (long)s.getPriceVip() %><br>COUPLE <%= (long)s.getPriceCouple() %></td>
            <td><%= s.getFormat() %></td>
            <td><%= s.getStatus() %></td>
            <td>
                <div class="action-box">
                    <a class="btn" href="${pageContext.request.contextPath}/adminshowtime?action=edit&id=<%= s.getShowtimeId() %>">Sửa</a>
                    <a class="btn btn-danger" onclick="return confirm('Xóa suất chiếu này?')" href="${pageContext.request.contextPath}/adminshowtime?action=delete&id=<%= s.getShowtimeId() %>">Xóa</a>
                </div>
            </td>
        </tr>
        <% } %>
    </table>

</div>
</body>
</html>