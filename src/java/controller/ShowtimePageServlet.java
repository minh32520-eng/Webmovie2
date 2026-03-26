package controller;

import dao.ShowtimeDAO;
import dao.CinemaDAO;
import entity.Showtime;
import entity.Cinema;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ShowtimePageServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ShowtimeDAO dao = new ShowtimeDAO();
        CinemaDAO cinemaDAO = new CinemaDAO();

        List<Cinema> cinemas = cinemaDAO.getAllCinemas();

        String selectedCinemaId = request.getParameter("cinemaId");
        String selectedCinemaName = "Chọn rạp";

        List<Showtime> list;
        if (selectedCinemaId != null && !selectedCinemaId.isEmpty()) {
            try {
                int cinemaId = Integer.parseInt(selectedCinemaId);
                //loc rap
                list = dao.getShowtimesByCinema(cinemaId); 
            } catch (NumberFormatException e) {
                list = dao.getAllShowtimesWithMovie();
            }
        } else {
            list = dao.getAllShowtimesWithMovie();
        }

        if (selectedCinemaId != null && cinemas != null) {
            for (Cinema c : cinemas) {
                if (String.valueOf(c.getCinemaId()).equals(selectedCinemaId)) {
                    selectedCinemaName = c.getName();
                    break;
                }
            }
        }

        request.setAttribute("showtimes", list);
        request.setAttribute("cinemas", cinemas);
        request.setAttribute("selectedCinemaName", selectedCinemaName);

        request.getRequestDispatcher("/pages/showtime.jsp")
               .forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}