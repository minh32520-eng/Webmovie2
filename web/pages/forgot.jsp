<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quên mật khẩu</title>
<style>
body {
    background: linear-gradient(135deg,#1e3a8a,#2563eb);
    font-family: 'Segoe UI';
}
.container {
    width: 400px;
    margin: 120px auto;
    background: #fff;
    padding: 30px;
    border-radius: 12px;
}
.title {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 20px;
}
.input {
    width: 100%;
    padding: 12px;
    margin-bottom: 15px;
    border-radius: 8px;
    border: 1px solid #ccc;
}
.btn {
    width: 100%;
    padding: 12px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}
.error {
    color: red;
    text-align: center;
}
.back {
    text-align: center;
    margin-top: 10px;
}
.back a {
    text-decoration: none;
    color: #2563eb;
}
</style>
</head>
<body>

<div class="container">
    <div class="title">Quên mật khẩu</div>

    <div class="error">${error}</div>

    <form action="${pageContext.request.contextPath}/auth" method="post">
        <input type="hidden" name="action" value="forgot"/>

        <input class="input" type="email" name="email" placeholder="Nhập email" required>

        <button class="btn">Gửi yêu cầu</button>
    </form>

    <div class="back">
        <a href="login.jsp"> Quay lại đăng nhập</a>
    </div>
</div>

</body>
</html>