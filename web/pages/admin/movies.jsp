<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entity.Movie"%>
<%
    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý phim</title>
<style>
body{margin:0;font-family:Arial;background:#f1f5f9}
.container{width:95%;margin:30px auto}
.titlemain{font-size:26px;color:#1e3a8a;font-weight:bold;margin-bottom:18px}
.topbar{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px}
.btn{padding:10px 18px;background:#1e3a8a;color:#fff;border-radius:8px;text-decoration:none;border:none;cursor:pointer}
.btn:hover{opacity:.9}.btn-danger{background:#dc2626}.btn-secondary{background:#475569}
.tablemain{width:100%;border-collapse:collapse;margin-top:20px;background:#fff;box-shadow:0 4px 12px rgba(0,0,0,.08)}
.tablemain th{background:#1e3a8a;color:white;padding:12px}.tablemain td{padding:10px;text-align:center;border-bottom:1px solid #e5e7eb}
.tablemain tr:nth-child(even){background:#f8fafc}.poster{width:70px;height:95px;object-fit:cover;border-radius:8px}
.action-box{display:flex;gap:8px;justify-content:center}
</style>
</head>
<body>
<div class="container">
    <div class="topbar">
        <div class="titlemain">Quản lý phim</div>
        <div>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin">Dashboard</a>
            <a class="btn" href="${pageContext.request.contextPath}/adminmovie?action=add">Thêm phim</a>
        </div>
    </div>
    <table class="tablemain">
        <tr>
            <th>ID</th><th>Tên phim</th><th>Poster</th><th>Thời lượng</th><th>Thể loại</th><th>Trạng thái</th><th>Hành động</th>
        </tr>
        <% if (movies != null) for (Movie m : movies) { %>
        <tr>
            <td><%= m.getMovieId() %></td>
            <td><%= m.getTitle() %></td>
            <td><img class="poster" src="<%= m.getPoster() %>"></td>
            <td><%= m.getDuration() %> phút</td>
            <td><%= m.getGenre() %></td>
            <td><%= m.getStatus() %></td>
            <td>
                <div class="action-box">
                    <a class="btn" href="${pageContext.request.contextPath}/adminmovie?action=edit&id=<%= m.getMovieId() %>">Sửa</a>
                    <a class="btn btn-danger" onclick="return confirm('Xóa phim này?')" href="${pageContext.request.contextPath}/adminmovie?action=delete&id=<%= m.getMovieId() %>">Xóa</a>
                </div>
            </td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
