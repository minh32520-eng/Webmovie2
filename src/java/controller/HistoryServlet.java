package controller;

import dao.BookingDAO;
import dao.CinemaDAO;
import entity.Booking;
import entity.Cinema;
import entity.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;


public class HistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("pages/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        //  lấy lịch sử
        BookingDAO dao = new BookingDAO();
        List<Booking> list = dao.getBookingByUser(user.getUserId());

        //  lấy cinemas cho header dropdown
        CinemaDAO cinemaDAO = new CinemaDAO();
        List<Cinema> cinemas = cinemaDAO.getAllCinemas();

        //  gửi sang JSP
        request.setAttribute("list", list);
        request.setAttribute("cinemas", cinemas);
        request.getRequestDispatcher("/pages/history.jsp")
                .forward(request, response);
    }
}
