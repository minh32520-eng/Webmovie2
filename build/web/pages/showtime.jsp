<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<style>
body {
    margin: 0;
    font-family: Arial;
    background: #f5f7fb;
}

.container {
    max-width: 1200px;
    margin: 40px auto;
}
</style>
</head>

<body>

<jsp:include page="/components/header.jsp"/>

<div class="container">
    <jsp:include page="/sections/showtime/showtimeSection.jsp"/>
</div>

<jsp:include page="/components/footer.jsp"/>

</body>
</html>