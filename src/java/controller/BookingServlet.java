package controller;

import dao.ShowtimeDAO;
import entity.Showtime;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class BookingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        String cinema = request.getParameter("cinema");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String showtimeIdRaw = request.getParameter("showtimeId");

        Showtime s = null;

        //  LẤY SHOWTIME TỪ DB
        if (showtimeIdRaw != null && !showtimeIdRaw.isEmpty()) {
            try {
                int showtimeId = Integer.parseInt(showtimeIdRaw);
                ShowtimeDAO dao = new ShowtimeDAO();
                s = dao.getShowtimeById(showtimeId); 
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        //  SET ATTRIBUTE
        request.setAttribute("showtime", s);
        request.setAttribute("cinema", cinema);
        request.setAttribute("date", date);
        request.setAttribute("time", time);
        request.setAttribute("showtimeId", showtimeIdRaw);

    
        request.getRequestDispatcher("/pages/booking.jsp")
               .forward(request, response);
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