<%-- 
    Document   : promotion
    Created on : Mar 23, 2026, 10:45:16 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.section {
    max-width: 1000px;
    margin: 40px auto;
}
.card {
    background: #ffe0b2;
    padding: 15px;
    margin-bottom: 10px;
}
</style>
</head>
<body>

<jsp:include page="/components/header.jsp" />

<div class="section">
    <jsp:include page="/sections/promotion/promotionSection.jsp" />
</div>

<jsp:include page="/components/footer.jsp" />

</body>
</html>
