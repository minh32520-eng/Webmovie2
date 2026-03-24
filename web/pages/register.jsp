<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>

<!-- ICON -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
    background: linear-gradient(135deg, #1e3a8a, #2563eb);
    font-family: 'Segoe UI', sans-serif;
}

/* CONTAINER */
.register-container {
    width: 420px;
    margin: 80px auto;
    background: #fff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}

/* TITLE */
.register-title {
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
    outline: none;
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
.btn-register {
    width: 100%;
    padding: 12px;
    background: linear-gradient(45deg,#1e3a8a,#2563eb);
    color: #fff;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
}
.btn-register:hover {
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
</style>
</head>

<body>

<div class="register-container">
    <div class="register-title">ĐĂNG KÝ</div>

    <form action="${pageContext.request.contextPath}/auth" method="post">
        
        <input type="hidden" name="action" value="register"/>

        <div class="error">
            ${error}
        </div>

        <!-- USERNAME -->
        <div class="input-group">
            <input type="text" name="username" placeholder="Username" required>
        </div>

        <!-- EMAIL -->
        <div class="input-group">
            <input type="email" name="email" placeholder="Email" required>
        </div>

        <!-- PASSWORD -->
        <div class="input-group password-box">
            <input type="password" id="password" name="password" placeholder="Password" required>
            <span onclick="togglePass('password','icon1')">
                <i id="icon1" class="fa-solid fa-eye"></i>
            </span>
        </div>

        <!-- CONFIRM PASSWORD -->
        <div class="input-group password-box">
            <input type="password" id="confirm" placeholder="Confirm Password" required>
            <span onclick="togglePass('confirm','icon2')">
                <i id="icon2" class="fa-solid fa-eye"></i>
            </span>
        </div>

        <!-- BUTTON -->
        <button class="btn-register">Register</button>
    </form>

    <div class="extra">
        <a href="${pageContext.request.contextPath}/pages/login.jsp">Đã có tài khoản? Đăng nhập</a>
    </div>
</div>

<script>
// show hide password
function togglePass(inputId, iconId) {
    let p = document.getElementById(inputId);
    let icon = document.getElementById(iconId);

    if (p.type === "password") {
        p.type = "text";
        icon.classList.replace("fa-eye", "fa-eye-slash");
    } else {
        p.type = "password";
        icon.classList.replace("fa-eye-slash", "fa-eye");
    }
}

// validate confirm password
document.querySelector("form").addEventListener("submit", function(e){
    let pass = document.getElementById("password").value;
    let confirm = document.getElementById("confirm").value;

    if(pass !== confirm){
        alert("Mật khẩu không khớp!");
        e.preventDefault();
    }
});
</script>

</body>
</html>