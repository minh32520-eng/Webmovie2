<%-- 
    Document   : price
    Created on : Mar 23, 2026, 10:42:24 PM
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
table {
    width: 100%;
    border-collapse: collapse;
}
td, th {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
}
</style>
</head>
<body>

<jsp:include page="/components/header.jsp" />

<div class="section">
    <jsp:include page="/sections/price/priceSection.jsp" />
</div>

<jsp:include page="/components/footer.jsp" />

</body>
</html>
