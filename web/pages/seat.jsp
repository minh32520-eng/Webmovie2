<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, entity.Seat" %>

<%
    List<Seat> seats = (List<Seat>) request.getAttribute("seats");
    List<Integer> booked = (List<Integer>) request.getAttribute("bookedSeats");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chọn ghế</title>

<style>
body {
    background: linear-gradient(135deg, #0f172a, #1e293b);
    color: #fff;
    font-family: 'Segoe UI', Arial, sans-serif;
}

.container {
    max-width: 950px;
    margin: 40px auto;
    text-align: center;
    padding: 25px;
    background: rgba(255,255,255,0.05);
    border-radius: 15px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.4);
}

h2 {
    margin-bottom: 20px;
    letter-spacing: 2px;
}

/* Màn hình */
.screen {
    background: linear-gradient(to right, #e5e7eb, #9ca3af);
    color: #000;
    padding: 14px;
    border-radius: 12px;
    margin-bottom: 40px;
    font-weight: bold;
    transform: perspective(300px) rotateX(-10deg);
    box-shadow: 0 10px 20px rgba(255,255,255,0.2);
}

/* Grid ghế */
.seat-grid {
    display: grid;
    grid-template-columns: repeat(8, 1fr);
    gap: 12px;
}

/* Ghế chung */
.seat {
    padding: 12px 0;
    border-radius: 10px;
    cursor: pointer;
    background: #334155;
    transition: all 0.25s ease;
    font-size: 14px;
    font-weight: 500;
}

/* Hover */
.seat:hover {
    transform: scale(1.15);
    background: #475569;
}

/* Đang chọn */
.seat.selected {
    background: #3b82f6;
    color: #fff;
    box-shadow: 0 0 10px #3b82f6;
}

/* VIP */
.seat.vip {
    background: linear-gradient(135deg, gold, orange);
    color: #000;
}

/* Couple */
.seat.couple {
    background: linear-gradient(135deg, pink, hotpink);
    color: #000;
}

/* Đã đặt */
.seat.booked {
    background: #111;
    color: #666;
    cursor: not-allowed;
    transform: none;
}

/* Legend */
.legend {
    margin-top: 25px;
    font-size: 14px;
}

.legend span {
    margin: 0 12px;
}

/* Button */
.btn {
    margin-top: 25px;
    padding: 14px 30px;
    background: linear-gradient(135deg, #2563eb, #1e3a8a);
    color: #fff;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: 0.3s;
}

.btn:hover {
    transform: scale(1.05);
    box-shadow: 0 5px 20px rgba(37, 99, 235, 0.6);
}
</style>

</head>

<body>

<jsp:include page="/components/header.jsp" />

<div class="container">

    <h2>CHỌN GHẾ</h2>

    <div class="screen">MÀN HÌNH</div>

    <div class="seat-grid">
        <% if (seats != null) {
            for (Seat s : seats) {
                boolean isBooked = booked != null && booked.contains(s.getSeatId());

                String typeClass = "";
                if ("VIP".equals(s.getSeatType())) typeClass = "vip";
                if ("COUPLE".equals(s.getSeatType())) typeClass = "couple";

                int price = 85000;
                if ("VIP".equals(s.getSeatType())) price = 120000;
                if ("COUPLE".equals(s.getSeatType())) price = 200000;
        %>

        <!-- 🔥 FIX CHUẨN: KHÔNG lỗi HTML -->
        <div class="seat <%= typeClass %> <%= isBooked ? "booked" : "" %>"
             data-id="<%= s.getSeatId() %>"
             data-price="<%= price %>"
             onclick="selectSeat(this)">
             
            <%= s.getRowLabel() %><%= s.getColNum() %>
        </div>

        <%  }
        } %>
    </div>

    <div class="legend">
        <span>⬜ Thường</span>
        <span style="color:gold;">⬜ VIP</span>
        <span style="color:pink;">⬜ Couple</span>
        <span>🟦 Đang chọn</span>
        <span>⬛ Đã đặt</span>
    </div>

    <!-- SUBMIT -->
    <form action="payment" method="post" onsubmit="return validateSeat()">
        <input type="hidden" name="seatIds" id="seatIds">
        <input type="hidden" name="showtimeId" value="${showtimeId}">
        <input type="hidden" name="total" id="total">
        <button class="btn">XÁC NHẬN</button>
    </form>

</div>

<jsp:include page="/components/footer.jsp" />

<script>
let selectedIds = [];
let total = 0;

function selectSeat(el) {
    if (el.classList.contains("booked")) return;

    let id = el.getAttribute("data-id");
    let price = parseInt(el.getAttribute("data-price"));

    el.classList.toggle("selected");

    if (selectedIds.includes(id)) {
        selectedIds = selectedIds.filter(x => x !== id);
        total -= price;
    } else {
        selectedIds.push(id);
        total += price;
    }

    document.getElementById("seatIds").value = selectedIds.join(",");
    document.getElementById("total").value = total;
}

function validateSeat() {
    if (selectedIds.length === 0) {
        alert("Vui lòng chọn ghế!");
        return false;
    }
    return true;
}
</script>

</body>
</html>