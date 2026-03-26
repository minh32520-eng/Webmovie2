package controller;

import dao.CinemaDAO;
import entity.Cinema;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class SuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Nếu không có session hoặc không có data đặt vé  về trang chủ
        if (session == null || session.getAttribute("successCode") == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Lấy data từ session rồi XÓA đi 
        request.setAttribute("bookingCode", session.getAttribute("successCode"));
        request.setAttribute("movie",       session.getAttribute("successMovie"));
        request.setAttribute("cinema",      session.getAttribute("successCinema"));
        request.setAttribute("time",        session.getAttribute("successTime"));
        request.setAttribute("seats",       session.getAttribute("successSeats"));
        request.setAttribute("total",       session.getAttribute("successTotal"));

        session.removeAttribute("successCode");
        session.removeAttribute("successMovie");
        session.removeAttribute("successCinema");
        session.removeAttribute("successTime");
        session.removeAttribute("successSeats");
        session.removeAttribute("successTotal");

        // Truyền cinemas cho header
        CinemaDAO cinemaDAO = new CinemaDAO();
        List<Cinema> cinemas = cinemaDAO.getAllCinemas();
        request.setAttribute("cinemas", cinemas);

        request.getRequestDispatcher("/pages/success.jsp")
                .forward(request, response);
    }
}
