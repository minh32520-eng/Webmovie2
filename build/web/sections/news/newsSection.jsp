<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, entity.News" %>

<%
List<News> newsList = (List<News>) request.getAttribute("newsList");
List<News> promoList = (List<News>) request.getAttribute("promoList");
%>

<style>
.section {
    margin: 40px auto;
    max-width: 1100px;
}

.title {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #1e3a8a;
}

.card-list {
    display: flex;
    gap: 20px;
}

.card {
    width: 250px;
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-5px);
}

.card img {
    width: 100%;
    height: 150px;
    object-fit: cover;
}

.card-title {
    padding: 10px;
    font-weight: bold;
    font-size: 14px;
}
</style>

<!-- NEWS -->
<div class="section">
    <div class="title">TIN TỨC</div>
    <div class="card-list">
        <% for(News n : newsList){ %>
        <div class="card">
            <img src="<%= n.getImage() %>">
            <div class="card-title"><%= n.getTitle() %></div>
        </div>
        <% } %>
    </div>
</div>

<!-- PROMOTION -->
<div class="section">
    <div class="title">ƯU ĐÃI</div>
    <div class="card-list">
        <% for(News n : promoList){ %>
        <div class="card">
            <img src="<%= n.getImage() %>">
            <div class="card-title"><%= n.getTitle() %></div>
        </div>
        <% } %>
    </div>
</div>