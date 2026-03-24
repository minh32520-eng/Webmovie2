<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Booking</title>

<style>
body {
    margin: 0;
    font-family: Arial;
    background: #ffffff;
}

/* CONTAINER */
.section {
    max-width: 1200px;
    margin: 40px auto;
    padding: 20px;
}

/* TAB MENU */
.tabs {
    display: flex;
    justify-content: center;
    gap: 40px;
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 30px;
    border-bottom: 2px solid #eee;
}

/* TAB */
.tabs span {
    cursor: pointer;
    color: #999;
    padding-bottom: 8px;
    transition: 0.3s;
}

/* TAB ACTIVE (XANH) */
.tabs span.active {
    color: #1e3a8a;
    border-bottom: 3px solid #1e3a8a;
}

/* HOVER */
.tabs span:hover {
    color: #1e3a8a;
}

/* CONTENT */
.tab-content {
    display: none;
}

.tab-content.active {
    display: block;
}
</style>

</head>

<body>

<!-- HEADER -->
<jsp:include page="/components/header.jsp" />

<!-- BANNER -->
<jsp:include page="/components/banner.jsp" />

<div class="section">

    <!-- TAB -->
    <div class="tabs">
        <span class="active" onclick="switchTab(0)">
            PHIM SẮP CHIẾU
        </span>
        <span onclick="switchTab(1)">
            PHIM ĐANG CHIẾU
        </span>
        <span onclick="switchTab(2)">
            SUẤT CHIẾU NỔI BẬT
        </span>
    </div>

    <!-- CONTENT -->
    <div class="tab-content active">
        <jsp:include page="/sections/home/movieComing.jsp" />
    </div>

    <div class="tab-content">
        <jsp:include page="/sections/home/movieNow.jsp" />
    </div>

    <div class="tab-content">
        <jsp:include page="/sections/home/showtimeHot.jsp" />
    </div>

</div>

<!-- FOOTER -->
<jsp:include page="/components/footer.jsp" />

<script>
function switchTab(index) {
    let tabs = document.querySelectorAll(".tabs span");
    let contents = document.querySelectorAll(".tab-content");

    // reset
    tabs.forEach(t => t.classList.remove("active"));
    contents.forEach(c => c.classList.remove("active"));

    // set active
    tabs[index].classList.add("active");
    contents[index].classList.add("active");
}
</script>

</body>
</html>