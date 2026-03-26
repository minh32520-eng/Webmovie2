<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Movie"%>
<%
    Movie movie = (Movie) request.getAttribute("movie");
    boolean isEdit = movie != null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= isEdit ? "Sửa phim" : "Thêm phim" %></title>
<style>
body{font-family:Arial;background:#f1f5f9;margin:0}
.container{width:860px;margin:30px auto;background:#fff;padding:25px;border-radius:12px;box-shadow:0 4px 15px rgba(0,0,0,.08)}
.grid{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.full{grid-column:1 / -1}
.input-main, textarea, select{width:100%;padding:10px;margin-top:6px;border:1px solid #cbd5e1;border-radius:8px;box-sizing:border-box}
label{font-weight:bold;color:#334155}
.btn-wrap{margin-top:18px;display:flex;gap:10px}
.btn{padding:10px 20px;background:#1e3a8a;color:white;border:none;border-radius:8px;cursor:pointer;text-decoration:none}
.btn-secondary{background:#64748b}
textarea{min-height:110px;resize:vertical}
h2{margin-top:0;color:#1e3a8a}
</style>
</head>
<body>
<div class="container">
    <h2><%= isEdit ? "Sửa phim" : "Thêm phim" %></h2>

    <form action="${pageContext.request.contextPath}/adminmovie" method="post">
        <input type="hidden" name="movie_id" value="<%= isEdit ? movie.getMovieId() : "" %>">

        <div class="grid">
            <div>
                <label>Tên phim</label>
                <input class="input-main" name="title" required
                       value="<%= isEdit ? movie.getTitle() : "" %>">
            </div>

            <div>
                <label>Poster</label>
                <input class="input-main" name="poster" required
                       value="<%= isEdit ? movie.getPoster() : "" %>">
            </div>

            <div>
                <label>Thời lượng (phút)</label>
                <input class="input-main" type="number" min="1" name="duration" required
                       value="<%= isEdit ? movie.getDuration() : "" %>">
            </div>

            <div>
                <label>Thể loại</label>
                <input class="input-main" name="genre"
                       value="<%= isEdit ? movie.getGenre() : "" %>">
            </div>

            <div>
                <label>Ngôn ngữ</label>
                <input class="input-main" name="language"
                       value="<%= isEdit ? movie.getLanguage() : "" %>">
            </div>

            <div>
                <label>Đạo diễn</label>
                <input class="input-main" name="director"
                       value="<%= isEdit ? movie.getDirector() : "" %>">
            </div>

            <div>
                <label>Diễn viên</label>
                <input class="input-main" name="cast_list"
                       value="<%= isEdit ? movie.getCastList() : "" %>">
            </div>

            <div>
                <label>Rating</label>
                <input class="input-main" type="number" step="0.1" min="0" max="10" name="rating"
                       value="<%= isEdit ? movie.getRating() : "0" %>">
            </div>

            <div>
                <label>Độ tuổi</label>
                <input class="input-main" name="age_limit"
                       value="<%= isEdit ? movie.getAgeLimit() : "P" %>">
            </div>

            <div class="full">
                <label>Mô tả</label>
                <textarea name="description"><%= isEdit && movie.getDescription()!=null ? movie.getDescription() : "" %></textarea>
            </div>

            <div>
                <label>Trạng thái</label>
                <select name="status">
                    <option value="NOW_SHOWING" <%= isEdit && "NOW_SHOWING".equals(movie.getStatus()) ? "selected" : "" %>>NOW_SHOWING</option>
                    <option value="COMING_SOON" <%= isEdit && "COMING_SOON".equals(movie.getStatus()) ? "selected" : "" %>>COMING_SOON</option>
                    <option value="SPECIAL_SHOW" <%= isEdit && "SPECIAL_SHOW".equals(movie.getStatus()) ? "selected" : "" %>>SPECIAL_SHOW</option>
                </select>
            </div>
        </div>

        <div class="btn-wrap">
            <button class="btn"><%= isEdit ? "Cập nhật" : "Thêm phim" %></button>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/adminmovie">Quay lại</a>
        </div>
    </form>
</div>
</body>
</html>