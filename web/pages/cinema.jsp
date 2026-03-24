<%-- 
    Document   : cinema
    Created on : Mar 23, 2026, 10:41:11 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<style>
.section {
    max-width: 1200px;
    margin: 40px auto;
}
.title {
    font-size: 22px;
    font-weight: bold;
}
</style>
</head>
<body>

<jsp:include page="/components/header.jsp" />

<div class="section">
    <jsp:include page="/sections/cinema/cinemaSection.jsp" />
</div>

<jsp:include page="/components/footer.jsp" />

</body>
</html>

