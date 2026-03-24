<%-- 
    Document   : bookingModal.jsp
    Created on : Mar 23, 2026, 9:13:12 PM
    Author     : DELL
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Booking</title>

    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.6);
        }

        .modalcontent {
            background: #fff;
            width: 600px;
            margin: 10% auto;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            position: relative;
        }

        .closebtn {
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 22px;
            cursor: pointer;
        }

        .title {
            font-weight: bold;
            margin-bottom: 20px;
        }

        .cinemaname {
            font-size: 22px;
            color: #2a5bd7;
            margin-bottom: 20px;
        }

        .infotable {
            width: 100%;
            margin-bottom: 20px;
        }

        .infotable td {
            padding: 10px;
            text-align: center;
        }

        .btnconfirm {
            background: #2a5bd7;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btnbuy {
            background: orange;
            color: white;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
        }
    </style>

    <script>
        function openModal(cinema, date, time) {
            document.getElementById("modal").style.display = "block";

            document.getElementById("cinema").innerText = cinema;
            document.getElementById("date").innerText = date;
            document.getElementById("time").innerText = time;
        }

        function closeModal() {
            document.getElementById("modal").style.display = "none";
        }

        function confirmBooking() {
            window.location.href = "BookingServlet";
        }
    </script>
</head>

<body>

<!-- NÚT TEST -->
<button class="btnbuy"
        onclick="openModal('Beta Thái Nguyên','23/03/2026','23:00')">
    Mua vé
</button>

<!-- MODAL -->
<div id="modal" class="modal">
    <div class="modalcontent">

        <span class="closebtn" onclick="closeModal()">×</span>

        <div class="title">BẠN ĐANG ĐẶT VÉ XEM PHIM</div>

        <div class="cinemaname">Quỷ Nhập Tràng 2</div>

        <table class="infotable">
            <tr>
                <td><b>Rạp chiếu</b></td>
                <td><b>Ngày chiếu</b></td>
                <td><b>Giờ chiếu</b></td>
            </tr>
            <tr>
                <td id="cinema"></td>
                <td id="date"></td>
                <td id="time"></td>
            </tr>
        </table>

        <button class="btnconfirm" onclick="confirmBooking()">
            ĐỒNG Ý
        </button>

    </div>
</div>

</body>
</html>
