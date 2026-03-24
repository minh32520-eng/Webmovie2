<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt lại mật khẩu</title>
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
.password-box {
    position: relative;
}
.password-box span {
    position: absolute;
    right: 12px;
    top: 12px;
    cursor: pointer;
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
</style>
</head>
<body>

<div class="container">
    <div class="title">Đặt lại mật khẩu</div>

    <div class="error">${error}</div>

    <form action="${pageContext.request.contextPath}/auth" method="post">
        <input type="hidden" name="action" value="reset"/>
        <input type="hidden" name="token" value="${param.token}"/>

        <div class="password-box">
            <input id="pass" class="input" type="password" name="password" placeholder="Mật khẩu mới" required>
            <span onclick="togglePass()">👁</span>
        </div>

        <button class="btn">Xác nhận</button>
    </form>
</div>

<script>
function togglePass(){
    let p = document.getElementById("pass");
    p.type = (p.type === "password") ? "text" : "password";
}
</script>

</body>
</html>