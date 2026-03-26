<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, entity.Booking, entity.User" %>

<%
    List<Booking> list = (List<Booking>) request.getAttribute("list");
    if (list == null) list = new ArrayList<>();
    User u = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Lịch sử đặt vé</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
* { box-sizing: border-box; margin: 0; padding: 0; }

body {
    font-family: 'Inter', sans-serif;
    background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 50%, #0f172a 100%);
    min-height: 100vh;
    color: #fff;
}

/* ===== PAGE WRAPPER ===== */
.page-wrapper {
    max-width: 900px;
    margin: 0 auto;
    padding: 40px 20px 60px;
}

/* ===== PROFILE CARD ===== */
.profile-card {
    background: rgba(255,255,255,0.07);
    border: 1px solid rgba(255,255,255,0.12);
    border-radius: 20px;
    padding: 28px 32px;
    margin-bottom: 32px;
    display: flex;
    align-items: center;
    gap: 20px;
    backdrop-filter: blur(10px);
}

.avatar {
    width: 64px;
    height: 64px;
    border-radius: 50%;
    background: linear-gradient(135deg, #3b82f6, #8b5cf6);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 26px;
    font-weight: 700;
    flex-shrink: 0;
}

.profile-info h2 {
    font-size: 20px;
    font-weight: 700;
    color: #fff;
}

.profile-info p {
    font-size: 14px;
    color: #94a3b8;
    margin-top: 4px;
}

/* ===== SECTION TITLE ===== */
.section-title {
    font-size: 22px;
    font-weight: 700;
    color: #fff;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
}

.section-title span {
    background: linear-gradient(135deg, #3b82f6, #8b5cf6);
    -webkit-background-clip: text;
    background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* ===== BOOKING CARD ===== */
.booking-card {
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.10);
    border-radius: 16px;
    padding: 22px 26px;
    margin-bottom: 16px;
    display: flex;
    align-items: center;
    gap: 20px;
    transition: all 0.25s ease;
    backdrop-filter: blur(6px);
    cursor: default;
}

.booking-card:hover {
    background: rgba(255,255,255,0.09);
    border-color: rgba(59,130,246,0.4);
    transform: translateY(-2px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}

/* ICON */
.booking-icon {
    width: 52px;
    height: 52px;
    border-radius: 12px;
    background: linear-gradient(135deg, #1e40af, #3b82f6);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    flex-shrink: 0;
}

/* DETAILS */
.booking-details {
    flex: 1;
    min-width: 0;
}

.movie-title {
    font-size: 16px;
    font-weight: 600;
    color: #f1f5f9;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    margin-bottom: 6px;
}

.booking-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 14px;
    font-size: 13px;
    color: #94a3b8;
}

.booking-meta span {
    display: flex;
    align-items: center;
    gap: 5px;
}

/* RIGHT SIDE */
.booking-right {
    text-align: right;
    flex-shrink: 0;
}

.amount {
    font-size: 17px;
    font-weight: 700;
    color: #fbbf24;
    margin-bottom: 8px;
}

/* STATUS BADGE */
.badge {
    display: inline-block;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.3px;
}

.badge-paid    { background: rgba(16,185,129,0.15); color: #10b981; border: 1px solid rgba(16,185,129,0.3); }
.badge-pending { background: rgba(245,158,11,0.15); color: #f59e0b; border: 1px solid rgba(245,158,11,0.3); }
.badge-cancelled { background: rgba(239,68,68,0.15); color: #ef4444; border: 1px solid rgba(239,68,68,0.3); }

/* CODE */
.booking-code {
    font-size: 12px;
    color: #64748b;
    margin-top: 6px;
    font-family: monospace;
}

/* ===== EMPTY STATE ===== */
.empty-state {
    text-align: center;
    padding: 60px 20px;
    background: rgba(255,255,255,0.04);
    border: 1px dashed rgba(255,255,255,0.15);
    border-radius: 20px;
}

.empty-state .icon { font-size: 56px; margin-bottom: 16px; }
.empty-state h3 { font-size: 18px; font-weight: 600; color: #cbd5e1; margin-bottom: 8px; }
.empty-state p  { font-size: 14px; color: #64748b; margin-bottom: 24px; }

.btn-browse {
    display: inline-block;
    padding: 12px 28px;
    background: linear-gradient(135deg, #3b82f6, #1d4ed8);
    color: #fff;
    border-radius: 12px;
    text-decoration: none;
    font-weight: 600;
    font-size: 14px;
    transition: 0.2s;
}
.btn-browse:hover { opacity: 0.9; transform: translateY(-1px); }

/* ===== SUMMARY BAR ===== */
.summary-bar {
    background: rgba(59,130,246,0.1);
    border: 1px solid rgba(59,130,246,0.25);
    border-radius: 14px;
    padding: 16px 24px;
    display: flex;
    gap: 30px;
    margin-bottom: 24px;
    flex-wrap: wrap;
}

.summary-item {
    display: flex;
    flex-direction: column;
    gap: 2px;
}

.summary-item .label { font-size: 12px; color: #94a3b8; }
.summary-item .value { font-size: 18px; font-weight: 700; color: #fff; }
.summary-item .value.yellow { color: #fbbf24; }
</style>
</head>
<body>

<jsp:include page="/components/header.jsp" />

<div class="page-wrapper">

    <!-- PROFILE CARD -->
    <div class="profile-card">
        <div class="avatar">
            <%= u != null ? String.valueOf(u.getUsername().charAt(0)).toUpperCase() : "?" %>
        </div>
        <div class="profile-info">
            <h2>👤 <%= u != null ? u.getUsername() : "Khách" %></h2>
            <p>Tài khoản cá nhân • Lịch sử đặt vé</p>
        </div>
    </div>

    <!-- SUMMARY BAR -->
    <% if (!list.isEmpty()) {
        double total = 0;
        for (Booking b : list) total += b.getTotalAmount();
    %>
    <div class="summary-bar">
        <div class="summary-item">
            <span class="label">Tổng vé đã đặt</span>
            <span class="value"><%= list.size() %></span>
        </div>
        <div class="summary-item">
            <span class="label">Tổng chi tiêu</span>
            <span class="value yellow">
                <%= String.format("%,.0f", total) %> VNĐ
            </span>
        </div>
    </div>
    <% } %>

    <!-- TITLE -->
    <div class="section-title">
        🎟 <span>Lịch sử đặt vé</span>
    </div>

    <!-- LIST -->
    <% if (list.isEmpty()) { %>
        <div class="empty-state">
            <div class="icon">🎬</div>
            <h3>Chưa có vé nào</h3>
            <p>Bạn chưa đặt vé nào. Hãy chọn phim yêu thích và đặt ngay!</p>
            <a href="${pageContext.request.contextPath}/home" class="btn-browse">Xem phim ngay</a>
        </div>
    <% } else {
        for (Booking b : list) {
            // Xác định badge
            String status = b.getPaymentStatus();
            String badgeClass = "badge-pending";
            String badgeText = "⏳ Chờ thanh toán";
            if ("PAID".equals(status)) {
                badgeClass = "badge-paid";
                badgeText = "✅ Đã thanh toán";
            } else if ("CANCELLED".equals(status)) {
                badgeClass = "badge-cancelled";
                badgeText = "❌ Đã huỷ";
            }

            // Format ngày
            String dateStr = "";
            if (b.getCreatedAt() != null) {
                dateStr = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(b.getCreatedAt());
            }
    %>
        <div class="booking-card">
            <div class="booking-icon">🎫</div>

            <div class="booking-details">
                <div class="movie-title"><%= b.getMovieTitle() != null ? b.getMovieTitle() : "Phim không xác định" %></div>
                <div class="booking-meta">
                    <span>📅 <%= dateStr %></span>
                </div>
                <div class="booking-code">Mã vé: <%= b.getBookingCode() %></div>
            </div>

            <div class="booking-right">
                <div class="amount"><%= String.format("%,.0f", b.getTotalAmount()) %> VNĐ</div>
                <span class="badge <%= badgeClass %>"><%= badgeText %></span>
            </div>
        </div>
    <%  }
    } %>

</div>

<jsp:include page="/components/footer.jsp" />

</body>
</html>