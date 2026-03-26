package controller;

import dao.SeatDAO;
import entity.Seat;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class SeatServlet extends HttpServlet {

 protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    //  LẤY showtimeId
    int showtimeId = Integer.parseInt(request.getParameter("showtimeId"));

    SeatDAO dao = new SeatDAO();

  
    List<Seat> seats = dao.getSeatsByShowtime(showtimeId);

    List<Integer> bookedSeats = dao.getBookedSeats(showtimeId);

    //  SET DATA
    request.setAttribute("seats", seats);
    request.setAttribute("bookedSeats", bookedSeats);
    request.setAttribute("showtimeId", showtimeId);

    request.getRequestDispatcher("/pages/seat.jsp")
           .forward(request, response);
}
}