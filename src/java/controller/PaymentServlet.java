package controller;

import dao.BookingDAO;
import dao.SeatDAO;
import dao.ShowtimeDAO;
import entity.Seat;
import entity.Showtime;
import entity.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //  CHECK LOGIN neu chua dang nhap thi chuyen sang trang login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("""
                <script>
                    if (confirm("Bạn cần đăng nhập để đặt vé!")) {
                        window.location.href = "pages/login.jsp";
                    } else {
                        window.history.back();
                    }
                </script>
            """);
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"user".equals(role)) {
            response.getWriter().println("Chỉ user mới được đặt vé!");
            return;
        }

        User user = (User) session.getAttribute("user");

       
        String seatIdsRaw = request.getParameter("seatIds");
        int showtimeId = Integer.parseInt(request.getParameter("showtimeId"));

        //  LẤY THÔNG TIN SUẤT CHIẾU 
        ShowtimeDAO showtimeDAO = new ShowtimeDAO();
        Showtime showtime = showtimeDAO.getShowtimeById(showtimeId);

        double priceStd    = showtime.getPriceStd();
        double priceVip    = showtime.getPriceVip();
        double priceCouple = showtime.getPriceCouple();

        //  TÍNH TỔNG TIỀN & GHI LẤY TÊN GHẾ 
        SeatDAO seatDAO = new SeatDAO();
        BookingDAO bookingDAO = new BookingDAO();

        String[] arr = seatIdsRaw.split(",");
        List<String> seatNames = new ArrayList<>();
        int total = 0;

        for (String s : arr) {
            int seatId = Integer.parseInt(s.trim());
            Seat seat = seatDAO.getSeatById(seatId);

            int price;
            if ("VIP".equals(seat.getSeatType()))         price = (int) priceVip;
            else if ("COUPLE".equals(seat.getSeatType())) price = (int) priceCouple;
            else                                           price = (int) priceStd;

            total += price;
            seatNames.add(seat.getRowLabel() + seat.getColNum());
        }

        // TẠO BOOKING 
        int bookingId = bookingDAO.createBooking(user.getUserId(), showtimeId, total);
        String bookingCode = bookingDAO.getBookingCodeById(bookingId);

        //  LƯU TỪNG GHẾ 
        for (String s : arr) {
            int seatId = Integer.parseInt(s.trim());
            Seat seat = seatDAO.getSeatById(seatId);

            int price;
            if ("VIP".equals(seat.getSeatType()))         price = (int) priceVip;
            else if ("COUPLE".equals(seat.getSeatType())) price = (int) priceCouple;
            else                                           price = (int) priceStd;

            bookingDAO.saveBookingSeatWithPrice(bookingId, showtimeId, seatId, price);
        }

        //  Lưu session  Redirect sang /success 
        session.setAttribute("successCode",   bookingCode);
        session.setAttribute("successMovie",  showtime.getMovieTitle());
        session.setAttribute("successCinema", showtime.getCinemaName());
        session.setAttribute("successTime",   showtime.getStartTime());
        session.setAttribute("successSeats",  seatNames);
        session.setAttribute("successTotal",  total);

        response.sendRedirect(request.getContextPath() + "/success");
    }
}