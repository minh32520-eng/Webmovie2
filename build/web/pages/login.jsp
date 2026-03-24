<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<!-- ICON CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
    background: linear-gradient(135deg, #1e3a8a, #2563eb);
    font-family: 'Segoe UI', sans-serif;
}

/* CONTAINER */
.login-container {
    width: 400px;
    margin: 100px auto;
    background: #fff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}

/* TITLE */
.login-title {
    text-align: center;
    font-size: 26px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 20px;
}

/* INPUT */
.input-group {
    margin-bottom: 15px;
}
.input-group input {
    width: 100%;
    padding: 12px;
    border-radius: 8px;
    border: 1px solid #ccc;
}
.input-group input:focus {
    border-color: #2563eb;
}

/* PASSWORD */
.password-box {
    position: relative;
}
.password-box span {
    position: absolute;
    right: 12px;
    top: 12px;
    cursor: pointer;
    color: #555;
}

/* BUTTON */
.btn-login {
    width: 100%;
    padding: 12px;
    background: linear-gradient(45deg,#1e3a8a,#2563eb);
    color: #fff;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
}
.btn-login:hover {
    opacity: 0.9;
}

/* ERROR */
.error {
    color: red;
    text-align: center;
    margin-bottom: 10px;
}

/* LINK */
.extra {
    text-align: center;
    margin-top: 10px;
}
.extra a {
    text-decoration: none;
    color: #2563eb;
    font-size: 13px;
}

/* SOCIAL */
.social-login {
    text-align: center;
    margin-top: 20px;
}
.social-login span {
    font-size: 13px;
    color: #999;
}
.social-icons {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 10px;
}
.social-icons div {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    font-size: 18px;
    color: #fff;
}

.facebook { background: #1877f2; }
.google { background: #db4437; }

</style>
</head>

<body>

<div class="login-container">
    <div class="login-title">ĐĂNG NHẬP</div>

    <!-- LOGIN FORM -->
    <form action="${pageContext.request.contextPath}/auth" method="post">
        <input type="hidden" name="action" value="login"/>

        <div class="error">
            ${error}
        </div>

        <!-- EMAIL -->
        <div class="input-group">
            <input type="email" name="email" placeholder="Email" required>
        </div>

        <!-- PASSWORD -->
        <div class="input-group password-box">
            <input type="password" id="password" name="password" placeholder="Password" required>
            <span onclick="togglePass()">
                <i class="fa-solid fa-eye"></i>
            </span>
        </div>

        <button class="btn-login">Login</button>
    </form>

    <!-- LINK -->
    <div class="extra">
        <a href="${pageContext.request.contextPath}/pages/register.jsp">Đăng ký</a> |
        
        <!-- FIX QUÊN MẬT KHẨU -->
        <a href="${pageContext.request.contextPath}/pages/forgot.jsp">
            Quên mật khẩu
        </a>
    </div>

    <!-- SOCIAL -->
    <div class="social-login">
        <span>Hoặc đăng nhập bằng</span>
        <div class="social-icons">
            <div class="facebook">
                <i class="fab fa-facebook-f"></i>
            </div>
            <div class="google">
                <i class="fab fa-google"></i>
            </div>
        </div>
    </div>
</div>

<script>
function togglePass() {
    let p = document.getElementById("password");
    let icon = document.querySelector(".password-box i");

    if (p.type === "password") {
        p.type = "text";
        icon.classList.replace("fa-eye", "fa-eye-slash");
    } else {
        p.type = "password";
        icon.classList.replace("fa-eye-slash", "fa-eye");
    }
}
</script>

</body>
</html>