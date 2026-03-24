package controller;

import dao.MovieDAO;
import dao.ShowtimeDAO;
import entity.Movie;
import entity.Showtime;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class HomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // MOVIE
        MovieDAO dao = new MovieDAO();
        List<Movie> movies = dao.getAllMovies();

        // SHOWTIME HOT
        ShowtimeDAO showtimeDAO = new ShowtimeDAO();
        List<Showtime> hot = showtimeDAO.getHotShowtimes();

        // SET ATTRIBUTE
        request.setAttribute("movies", movies);
        request.setAttribute("hotShowtimes", hot);

        // FORWARD
        request.getRequestDispatcher("/pages/home.jsp")
               .forward(request, response);
    }
}