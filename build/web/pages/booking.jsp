<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt vé</title>

<style>
body {
    margin: 0;
    font-family: Arial;
    background: #f5f7fb;
}

/* CONTAINER */
.container {
    max-width: 900px;
    margin: 40px auto;
    background: #fff;
    padding: 30px;
    border-radius: 15px;
}

/* TITLE */
.title {
    font-size: 24px;
    font-weight: bold;
    color: #1e3a8a;
    margin-bottom: 20px;
}

/* INFO */
.info {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.info div {
    width: 30%;
    background: #f1f5f9;
    padding: 15px;
    border-radius: 10px;
    text-align: center;
}

.info b {
    display: block;
    margin-bottom: 5px;
}

/* BUTTON */
.btn {
    background: #1e3a8a;
    color: white;
    padding: 12px 30px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    margin-top: 20px;
}

.btn:hover {
    background: #162d6b;
}
</style>

</head>

<body>

<!-- HEADER -->
<jsp:include page="/components/header.jsp" />

<div class="container">

    <div class="title">THÔNG TIN ĐẶT VÉ</div>

    <div class="info">
        <div>
            <b>Rạp</b>
            ${cinema}
        </div>
        <div>
            <b>Ngày</b>
            ${date}
        </div>
        <div>
            <b>Giờ</b>
            ${time}
        </div>
    </div>

    <!-- chuyển sang chọn ghế -->
    <form action="seat" method="get">
        <input type="hidden" name="cinema" value="${cinema}">
        <input type="hidden" name="date" value="${date}">
        <input type="hidden" name="time" value="${time}">
        
        <button class="btn">CHỌN GHẾ</button>
    </form>

</div>

<!-- FOOTER -->
<jsp:include page="/components/footer.jsp" />

</body>
</html>