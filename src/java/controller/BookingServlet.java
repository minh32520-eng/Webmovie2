package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // có thể nhận data từ request
        String cinema = request.getParameter("cinema");
        String date = request.getParameter("date");
        String time = request.getParameter("time");

        // set sang JSP
        request.setAttribute("cinema", cinema);
        request.setAttribute("date", date);
        request.setAttribute("time", time);

        // chuyển sang trang chọn ghế
        request.getRequestDispatcher("/pages/booking.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}